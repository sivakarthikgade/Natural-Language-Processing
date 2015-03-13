import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

public class bigramtrain {

	public static void train(String trainFile, String lmFile) throws Exception {
		Map<String, Map<String, Value>> bigrams = new TreeMap<String, Map<String, Value>>();
		Map<String, Value> unigrams = new TreeMap<String, Value>();
		
		BufferedReader br = new BufferedReader(new FileReader(trainFile));
		String str;
		Iterator<String> itr, itr2;
		while((str = br.readLine()) != null) {
			String[] tokens = str.split("\\s+");
			String f, s;
			f = tokens[0];
			for(int i = 1; i < tokens.length; i++) {
				s = tokens[i];
				if(unigrams.containsKey(f)) {
					unigrams.get(f).c++;
				} else {
					unigrams.put(f, new Value(1,0));
				}
				
				if(bigrams.containsKey(f)) {
					if(bigrams.get(f).containsKey(s)) {
						bigrams.get(f).get(s).c++;
					} else {
						bigrams.get(f).put(s, new Value(1,0));
					}
				} else {
					bigrams.put(f, new TreeMap<String, Value>());
					bigrams.get(f).put(s, new Value(1,0));
				}
				f = s;
			}
			
			if(unigrams.containsKey(f)) {
				unigrams.get(f).c++;
			} else {
				unigrams.put(f, new Value(1,0));
			}
			
		}
		br.close();
		
		int totalTokenCount = 0, N1 = 0, N2 = 0;

		itr = unigrams.keySet().iterator();
		while(itr.hasNext()) {
			String key = itr.next();
			Value val = unigrams.get(key);
			
			totalTokenCount+=val.c;
		}
		
		itr = unigrams.keySet().iterator();
		while(itr.hasNext()) {
			String key = itr.next();
			Value val = unigrams.get(key);
			val.p = (double)val.c/totalTokenCount;
			val.p = (Math.floor(val.p*Math.pow(10, 9))/Math.pow(10, 9));
		}
		
//		System.out.println("Total Unigram Token Count: "+totalTokenCount);
		
		itr = bigrams.keySet().iterator();
		while(itr.hasNext()) {
			String key = itr.next();
			Map<String, Value> vals = bigrams.get(key);

			itr2 = vals.keySet().iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				Value val = vals.get(key2);
				if(val.c == 1)
					N1++;
				if(val.c == 2)
					N2++;
			}
		}
		
//		System.out.println("N1 Count: "+N1);
//		System.out.println("N2 Count: "+N2);

		itr = bigrams.keySet().iterator();
		while(itr.hasNext()) {
			String key = itr.next();
			Map<String, Value> vals = bigrams.get(key);

			int count = 0, cntOnes = 0;
			itr2 = vals.keySet().iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				Value val = vals.get(key2);
				count+=val.c;
				if(val.c == 1)
					cntOnes++;
			}

			double num = 0.0f, den = 0.0f;
			itr2 = vals.keySet().iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				Value val = vals.get(key2);
				if(val.c > 1) {
					val.p=(double)val.c/count;
					if(cntOnes == 0)
						val.p*=0.99;
				} else {
					double lnum = (double)2*N2/N1;
					val.p= lnum/count;
				}
				val.p= (double)(Math.floor(val.p*Math.pow(10, 9))/Math.pow(10, 9));
				num+=val.p;
				den+=unigrams.get(key2).p;
			}
			num = 1 - num;
			den = 1 - den;
			unigrams.get(key).b = (double)(Math.floor((num/den)*Math.pow(10, 9))/Math.pow(10, 9));
		}
		
//		System.out.println("Unigrams Map Size: "+unigrams.size());
//		System.out.println("Bigrams Map Size: "+bigrams.size());
		
		BufferedWriter bw = new BufferedWriter(new FileWriter(lmFile));
		bw.write("Unigrams:");
		bw.newLine();
		itr = unigrams.keySet().iterator();
		int cnt = 0;
		while(itr.hasNext()) {
			String key = itr.next();
			Value val = unigrams.get(key);
			bw.write(Math.log10(val.p)/Math.log10(2) + " " + key + " " + Math.log10(val.b)/Math.log10(2));
			bw.newLine();
			cnt++;
			if(cnt%100 == 0)
				bw.flush();
		}
		
		bw.write("Bigrams:");
		bw.newLine();
		itr = bigrams.keySet().iterator();
		cnt = 0;
		while(itr.hasNext()) {
			String key = itr.next();
			Map<String, Value> vals = bigrams.get(key);
			itr2 = vals.keySet().iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				Value val = vals.get(key2);
				bw.write(Math.log10(val.p)/Math.log10(2) + " " + key + " " + key2);
				bw.newLine();
				cnt++;
				if(cnt%100 == 0)
					bw.flush();
			}
		}
		
		bw.flush();
		bw.close();
	}
	
	public static void main(String args[]) throws Exception {
		String trainFile = null, lmFile = null;
		for(int i = 0; i < args.length; i++) {
			if(args[i].equalsIgnoreCase("-text"))
				trainFile = args[i+1];
			if(args[i].equalsIgnoreCase("-lm"))
				lmFile = args[i+1];
		}
		
		train(trainFile, lmFile);
	}
}
