import java.io.BufferedReader;
import java.io.FileReader;
import java.util.HashMap;
import java.util.Map;


public class bigramtest {

	public static void test(String testFile, String lmFile) throws Exception {
		Map<String, Map<String, Value>> bigrams = new HashMap<String, Map<String, Value>>();
		Map<String, Value> unigrams = new HashMap<String, Value>();
		
		BufferedReader br = new BufferedReader(new FileReader(lmFile));
		String str = br.readLine();	//Ignoring Unigrams: header
		while((str = br.readLine()) != null) {
			if(str.equals("Bigrams:"))
				break;
			String tokens[] = str.split("\\s+");
			unigrams.put(tokens[1], new Value(0, Double.parseDouble(tokens[0]), Double.parseDouble(tokens[2])));
		}
		
		while((str = br.readLine()) != null) {
			String tokens[] = str.split("\\s+");
			if(!bigrams.containsKey(tokens[1]))
				bigrams.put(tokens[1], new HashMap<String, Value>());
			bigrams.get(tokens[1]).put(tokens[2], new Value(0, Double.parseDouble(tokens[0]), 0));
		}
		br.close();
		
		double totalTokenCount = 0;
		double perplexity = 0.0;
		
		br = new BufferedReader(new FileReader(testFile));
		while((str = br.readLine()) != null) {
			String[] tokens = str.split("\\s+");
			String f, s;
			f = tokens[0];
			totalTokenCount++;
			for(int i = 1; i < tokens.length; i++) {
				totalTokenCount++;
				s = tokens[i];
				if(bigrams.get(f) != null) {
					if(bigrams.get(f).get(s) != null) {
						perplexity+=bigrams.get(f).get(s).p;
					} else {
						perplexity+=(unigrams.get(f) == null ? 0 : unigrams.get(f).b);
						perplexity+=(unigrams.get(s) == null ? 0 : unigrams.get(s).p);
					}
				}
				f = s;
			}
		}
		
		perplexity = - perplexity/(totalTokenCount);
		perplexity = Math.pow(2, perplexity);
		
//		System.out.println("token count: "+totalTokenCount);
		System.out.println("perplexity: "+perplexity);
	}
	
	public static void main(String args[]) throws Exception {
		String testFile = null, lmFile = null;
		for(int i = 0; i < args.length; i++) {
			if(args[i].equalsIgnoreCase("-text"))
				testFile = args[i+1];
			if(args[i].equalsIgnoreCase("-lm"))
				lmFile = args[i+1];
		}
		
		test(testFile, lmFile);
	}
}
