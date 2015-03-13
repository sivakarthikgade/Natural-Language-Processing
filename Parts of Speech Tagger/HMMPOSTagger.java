import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

public class HMMPOSTagger {
	
	public static void train(String trainFile, String modelFile) throws Exception {
		Map<String, Map<String, Value>> tprobs = new TreeMap<String, Map<String, Value>>();
		Map<String, Map<String, Value>> oprobs = new TreeMap<String, Map<String, Value>>();
		Map<String, Set<String>> postagsforwords = new TreeMap<String, Set<String>>();
		Map<String, Value> tagprobs = new TreeMap<String, Value>();
		String start = "__start__";
		
		BufferedReader br = new BufferedReader(new FileReader(trainFile));
		String str, f, s;
		int tagcount = 0;
		Iterator<String> itr, itr2;
		while((str = br.readLine()) != null) {
			String[] tokens = str.split("\\s+");
			tagcount+=tokens.length;
			f = start;
			for(int i = 0; i < tokens.length; i++) {
				String[] tokens2 = tokens[i].split("/");
				s = tokens2[tokens2.length-1];
				
				if(tprobs.containsKey(f)) {
					if(tprobs.get(f).containsKey(s)) {
						tprobs.get(f).get(s).c++;
					} else {
						tprobs.get(f).put(s, new Value(1,0));
					}
				} else {
					tprobs.put(f, new TreeMap<String, Value>());
					tprobs.get(f).put(s, new Value(1,0));
				}
				
				if(tagprobs.containsKey(s)) {
					tagprobs.get(s).c++;
				} else {
					tagprobs.put(s, new Value(1,0));
				}

				f = s;
			}
		}
		br.close();

		itr = tprobs.keySet().iterator();
		while(itr.hasNext()) {
			String key = itr.next();
			Map<String, Value> vals = tprobs.get(key);

			int count = 0;
			itr2 = vals.keySet().iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				Value val = vals.get(key2);
				count+=val.c;
			}

			itr2 = vals.keySet().iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				Value val = vals.get(key2);
				val.p=(double)val.c/(double)count;
			}
		}
		
		itr = tagprobs.keySet().iterator();
		while(itr.hasNext()) {
			String key = itr.next();
			Value val = tagprobs.get(key);
			val.p = (double)val.c/(double)tagcount;
		}

		br = new BufferedReader(new FileReader(trainFile));
		while((str = br.readLine()) != null) {
			String[] tokens = str.split("\\s+");
			for(int i = 0; i < tokens.length; i++) {
				String[] tokens2 = tokens[i].split("/");
				f = tokens2[1];
				s = tokens2[0];
				
				if(oprobs.containsKey(f)) {
					if(oprobs.get(f).containsKey(s)) {
						oprobs.get(f).get(s).c++;
					} else {
						oprobs.get(f).put(s, new Value(1,0));
					}
				} else {
					oprobs.put(f, new TreeMap<String, Value>());
					oprobs.get(f).put(s, new Value(1,0));
				}
				
				if(!postagsforwords.containsKey(s))
					postagsforwords.put(s, new HashSet<String>());
				postagsforwords.get(s).add(f);
			}
		}
		br.close();

		itr = oprobs.keySet().iterator();
		while(itr.hasNext()) {
			String key = itr.next();
			Map<String, Value> vals = oprobs.get(key);

			int count = 0;
			itr2 = vals.keySet().iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				Value val = vals.get(key2);
				count+=val.c;
			}

			itr2 = vals.keySet().iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				Value val = vals.get(key2);
				val.p=(double)val.c/(double)count;
			}
		}

		BufferedWriter bw = new BufferedWriter(new FileWriter(modelFile));
		bw.write("Transition Probabilities");
		bw.newLine();
		itr = tprobs.keySet().iterator();
		int cnt = 0;
		while(itr.hasNext()) {
			String key = itr.next();
			Map<String, Value> vals = tprobs.get(key);
			itr2 = vals.keySet().iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				Value val = vals.get(key2);
				bw.write((val.p) + " " + key + " " + key2);
				bw.newLine();
				cnt++;
				if(cnt%100 == 0)
					bw.flush();
			}
		}

		bw.write("Observation Probabilities");
		bw.newLine();
		itr = oprobs.keySet().iterator();
		cnt = 0;
		while(itr.hasNext()) {
			String key = itr.next();
			Map<String, Value> vals = oprobs.get(key);
			itr2 = vals.keySet().iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				Value val = vals.get(key2);
				bw.write((val.p) + " " + key + " " + key2);
				bw.newLine();
				cnt++;
				if(cnt%100 == 0)
					bw.flush();
			}
		}
		
		bw.write("Possible POS Tags");
		bw.newLine();
		itr = postagsforwords.keySet().iterator();
		cnt = 0;
		while(itr.hasNext()) {
			String key = itr.next();
			bw.write(key + " ");
			Set<String> tags = postagsforwords.get(key);
			itr2 = tags.iterator();
			while(itr2.hasNext()) {
				String key2 = itr2.next();
				bw.write(key2 + " ");
			}
			bw.newLine();
			cnt++;
			if(cnt%100 == 0)
				bw.flush();
		}
		
		bw.write("Tag Probabilities");
		bw.newLine();
		itr = tagprobs.keySet().iterator();
		while(itr.hasNext()) {
			String key = itr.next();
			bw.write(key + " " + tagprobs.get(key).p);
			bw.newLine();
		}

		bw.flush();
		bw.close();
	}
	
	public static void test(String testFile, String modelFile, String outputFile) throws Exception {
		Map<String, Map<String, Value>> tprobs = new TreeMap<String, Map<String, Value>>();
		Map<String, Map<String, Value>> oprobs = new TreeMap<String, Map<String, Value>>();
		Map<String, Set<String>> postagsforwords = new TreeMap<String, Set<String>>();
		Map<String, Value> tagprobs = new TreeMap<String, Value>();
		String start = "__start__";
		
		Map<String, Map<String, Value>> probs = tprobs;
		BufferedReader br = new BufferedReader(new FileReader(modelFile));
		String str = br.readLine();	//Ignoring Transition Probabilities header
		String markerStr = "Observation Probabilities";
		int markerProcessedCnt = 1;
		while((str = br.readLine()) != null) {
			if(str.equals(markerStr)) {
				markerProcessedCnt++;
				if(markerProcessedCnt == 3) {
					markerStr = "Tag Probabilities";
					break;
				} else {
					markerStr = "Possible POS Tags";
					probs = oprobs;
					continue;
				}
			}
			String tokens[] = str.split("\\s+");
			if(!probs.containsKey(tokens[1]))
				probs.put(tokens[1], new TreeMap<String, Value>());
			probs.get(tokens[1]).put(tokens[2], new Value(0, Double.parseDouble(tokens[0]), 0));
		}
		while((str = br.readLine()) != null) {
			if(str.equals(markerStr))
				break;
			String tokens[] = str.split("\\s+");
			postagsforwords.put(tokens[0], new HashSet<String>());
			for(int i = 1; i < tokens.length; i++) {
				postagsforwords.get(tokens[0]).add(tokens[i]);
			}
		}
		while((str = br.readLine()) != null) {
			String tokens[] = str.split("\\s+");
			tagprobs.put(tokens[0], new Value(0, Double.parseDouble(tokens[1]), 0));
		}
		br.close();
		List<String> POS = new ArrayList<String>(oprobs.keySet());
		POS.add(0, start);
		
		br = new BufferedReader(new FileReader(testFile));
		BufferedWriter bw = new BufferedWriter(new FileWriter(outputFile));
		while((str = br.readLine()) != null) {
			String tokens[] = str.split("\\s+");
			double[][] dynprog = new double[POS.size()][tokens.length+1];
			int[][] dynprogptr = new int[POS.size()][tokens.length+1];
			
			for(int i = 0; i < dynprog.length; i++) {
				for(int j = 0; j < dynprog[0].length; j++) {
					dynprog[i][j] = -100;
				}
			}

			dynprog[0][0] = 1.0;
			for(int j = 1; j < dynprog[0].length; j++) {
				for(int i = 1; i < dynprog.length; i++) {
					double max = -1;
					int maxPtr = -1;
					for(int k = 0; k < dynprog.length; k++) {
						if(dynprog[k][j-1] == -100)
							continue;
						if((tprobs.get(POS.get(k)).get(POS.get(i)) != null) && (max < (dynprog[k][j-1] * tprobs.get(POS.get(k)).get(POS.get(i)).p))) {
							max = dynprog[k][j-1] * tprobs.get(POS.get(k)).get(POS.get(i)).p;
							maxPtr = k;
						}
					}
					dynprog[i][j] = ((oprobs.get(POS.get(i)).get(tokens[j-1]) != null) 
										? oprobs.get(POS.get(i)).get(tokens[j-1]).p 
										: (postagsforwords.get(tokens[j-1]) != null 
											? 0 
											: .00001)) * max;//(((double)1.0/(double)tagprobs.size())/tagprobs.get(POS.get(i)).p)*
					dynprogptr[i][j] = maxPtr;
				}
				if(postagsforwords.get(tokens[j-1]) == null) {
					tokens[j-1] = "~~" + tokens[j-1];
				}
			}
			
			String poses[] = new String[tokens.length];
			int pos = -1;
			double val = -1;
			for(int i = 1; i < dynprog.length; i++) {
				if(val < dynprog[i][dynprog[0].length-1]) {
					val = dynprog[i][dynprog[0].length-1];
					pos = dynprogptr[i][dynprog[0].length-1];
					poses[poses.length-1] = POS.get(i);
				}
			}
			
			for(int i = poses.length-2; i >= 0; i--) {
				poses[i] = POS.get(dynprogptr[pos][i+2]);
			}
			
			for(int i = 0; i < tokens.length; i++) {
				bw.write(tokens[i]+"/"+poses[i]+" ");
			}
			bw.newLine();
		}
		br.close();
		bw.flush();
		bw.close();
	}
	
	public static void evaluate(String refFile, String outputFile) throws Exception {
		BufferedReader br1 = new BufferedReader(new FileReader(refFile));
		BufferedReader br2 = new BufferedReader(new FileReader(outputFile));
		int scnt = 0, uscnt = 0, sccnt = 0, usccnt = 0;
		String str1, str2;
		
		while((str1 = br1.readLine()) != null) {
			str2 = br2.readLine();
			
			String tokens1[] = str1.split("\\s+");
			String tokens2[] = str2.split("\\s+");
			
			for(int i = 0; i < tokens1.length; i++) {
				if(tokens2[i].startsWith("~~")) {
					uscnt++;
					tokens2[i] = tokens2[i].substring(2);
					if(tokens1[i].equals(tokens2[i])) {
						usccnt++;
					}
				} else {
					scnt++;
					if(tokens1[i].equals(tokens2[i])) {
						sccnt++;
					}
				}
			}
		}
		
		System.out.println("Overall Accuracy:"+((double)(sccnt+usccnt)/(double)(scnt+uscnt)) + " " + "Total Token Count:"+(scnt+uscnt) + " " + "Correct Token Count:"+(sccnt+usccnt));
		System.out.println("Known Word Accuracy:"+((double)(sccnt)/(double)(scnt)) + " " + "Total Token Count:"+(scnt) + " " + "Correct Token Count:"+(sccnt));
		System.out.println("Unknown Word Accuracy:"+((double)(usccnt)/(double)(uscnt)) + " " + "Total Token Count:"+(uscnt) + " " + "Correct Token Count:"+(usccnt));
		
		br1.close();
		br2.close();
	}
	
	public static void main(String args[]) throws Exception {
		String trainFile = null, modelFile = null, testFile = null, outputFile = null, refFile = null;

		for(int i = 0; i < args.length; i++) {
			if(args[i].equalsIgnoreCase("-train"))
				trainFile = args[i+1];
			else if(args[i].equalsIgnoreCase("-model"))
				modelFile = args[i+1];
			else if(args[i].equalsIgnoreCase("-test"))
				testFile = args[i+1];
			else if(args[i].equalsIgnoreCase("-o"))
				outputFile = args[i+1];
			else if(args[i].equalsIgnoreCase("-ref"))
				refFile = args[i+1];
			else if(args[i].equalsIgnoreCase("-sys"))
				outputFile = args[i+1];
		}
		
		if(trainFile != null)
			train(trainFile, modelFile);
		else if(testFile != null)
			test(testFile, modelFile, outputFile);
		else if(refFile != null)
			evaluate(refFile, outputFile);
	}

}
