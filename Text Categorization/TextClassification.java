/**
 * @author Siva Karthik Gade
 *
 */

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

enum Class {
	neg,
	pos
}

public class TextClassification {
	
	private static final String STOP_WORDS_FILE = "Stop_Words.txt";
	private static final int foldCnt = 10;
	private String dataFolder = null;
	private Set<String> vocabulary = new HashSet<String>();
	private List<String> vocab = new ArrayList<String>();
	private Set<String> stopWords = new HashSet<String>();
	private Map<Class, Integer> docCntPerClass = new HashMap<Class, Integer>();
	private Map<Class, Double> prior = new HashMap<Class, Double>();
	private Map<Class, Map<String, Integer>> tokenCounts = new HashMap<Class, Map<String, Integer>>();
	private Map<Class, Map<String, Double>> tokenCondProb = new HashMap<Class, Map<String, Double>>();
	private Map<Class, List<String>> classTokens = new HashMap<Class, List<String>>();
	private boolean ignoreStopWords = false;
	private String regex = "[^a-z\'\\:\\/\\@\\+]";
	private Map<Integer,Map<Integer,Integer>> data = null;
	Map<Class, File[]> totalFiles, testFiles;
	Map<Class, Object[]> trainFiles;
	
	public TextClassification() throws Exception {
	}
	
	public TextClassification(String dataFolder) throws Exception {
		this.dataFolder = dataFolder;
	}
	
	public boolean isIgnoreStopWords() {
		return this.ignoreStopWords;
	}

	public void setIgnoreStopWords(boolean ignoreStopWords) {
		this.ignoreStopWords = ignoreStopWords;
	}

	public Map<Integer, Map<Integer, Integer>> getData() {
		return data;
	}

	public void setData(Map<Integer, Map<Integer,Integer>> data) {
		this.data = data;
	}

	public String getRegex() {
		return regex;
	}

	public void setRegex(String regex) {
		this.regex = regex;
	}

	public Set<String> getStopWords() {
		return stopWords;
	}

	public void setStopWords(Set<String> stopWords) {
		this.stopWords = stopWords;
	}

	public Map<Class, List<String>> getClassTokens() {
		return classTokens;
	}

	public void setClassTokens(Map<Class, List<String>> classTokens) {
		this.classTokens = classTokens;
	}

	public Map<Class, Double> getPrior() {
		return prior;
	}

	public void setPrior(Map<Class, Double> prior) {
		this.prior = prior;
	}

	public Map<Class, Integer> getDocCntPerClass() {
		return docCntPerClass;
	}

	public void setDocCntPerClass(Map<Class, Integer> docCntPerClass) {
		this.docCntPerClass = docCntPerClass;
	}

	public Set<String> getVocabulary() {
		return vocabulary;
	}

	public void setVocabulary(Set<String> vocabulary) {
		this.vocabulary = vocabulary;
	}

	public Map<Class, Map<String, Double>> getTokenCondProb() {
		return tokenCondProb;
	}

	public void setTokenCondProb(Map<Class, Map<String, Double>> tokenCondProb) {
		this.tokenCondProb = tokenCondProb;
	}

	public Map<Class, Map<String, Integer>> getTokenCounts() {
		return tokenCounts;
	}

	public void setTokenCounts(Map<Class, Map<String, Integer>> tokenCounts) {
		this.tokenCounts = tokenCounts;
	}

	public String getDataFolder() {
		return dataFolder;
	}

	public void setDataFolder(String dataFolder) {
		this.dataFolder = dataFolder;
	}

	public void loadStopWords() throws Exception {
		BufferedReader br = null;
		try {
			br = new BufferedReader(new FileReader(TextClassification.STOP_WORDS_FILE));
		} catch(FileNotFoundException e) {
			throw new Exception("Please copy Stop_Words.txt file into the same folder as SpamFilter.java");
		}
		String str = null;
		while((str=br.readLine())!=null) {
			getStopWords().add(str.toLowerCase());
		}
		br.close();
		//log("StopWord count: "+getStopWords().size());
	}
	
	public void trainMultiNomial() throws Exception {
			
			getDocCntPerClass().put(Class.neg, trainFiles.get(Class.neg).length);
			getDocCntPerClass().put(Class.pos, trainFiles.get(Class.pos).length);

			getPrior().put(Class.neg, (double)getDocCntPerClass().get(Class.neg)/(getDocCntPerClass().get(Class.neg) + getDocCntPerClass().get(Class.pos)));
			getPrior().put(Class.pos, (double)getDocCntPerClass().get(Class.pos)/(getDocCntPerClass().get(Class.neg) + getDocCntPerClass().get(Class.pos)));

			trainMultiNomialNB(null);
			writeLM();
	}
	
	private void writeLM() throws Exception {
		BufferedWriter bw = new BufferedWriter(new FileWriter("lm.txt"));
		bw.write("prior probabilities:");
		bw.newLine();
		bw.write(Class.neg+" "+getPrior().get(Class.neg));
		bw.newLine();
		bw.write(Class.pos+" "+getPrior().get(Class.pos));
		bw.newLine();
		bw.flush();
		bw.write("data likelihood:");
		bw.newLine();
		Iterator<Class> itr = getTokenCondProb().keySet().iterator();
		while(itr.hasNext()) {
			Class c = itr.next();
			Iterator<String> itr2 = getTokenCondProb().get(c).keySet().iterator();
			while(itr2.hasNext()) {
				String token = itr2.next();
				Double val = getTokenCondProb().get(c).get(token);
				bw.write(c+" "+token+" "+val);
				bw.newLine();
			}
		}
		bw.close();
	}
	
	private void readLM() throws Exception {
		prior = new HashMap<Class, Double>();
		tokenCondProb = new HashMap<Class, Map<String, Double>>();

		BufferedReader br = new BufferedReader(new FileReader("lm.txt"));
		br.readLine();
		String str = null;
		while((str = br.readLine()) != null) {
			if(str.equals("data likelihood:")) {
				break;
			}
			String tokens[] = str.split(" ");
			prior.put((tokens[0].trim().equals("neg")?Class.neg:Class.pos), Double.parseDouble(tokens[1].trim()));
		}
		Iterator<Class> itr = prior.keySet().iterator();
		while(itr.hasNext()) {
			tokenCondProb.put(itr.next(), new HashMap<String, Double>());
		}
		while((str = br.readLine()) != null) {
			String tokens[] = str.split(" ");
			tokenCondProb.get(tokens[0].trim().equals("neg")?Class.neg:Class.pos).put((tokens.length==2?"":tokens[1]), Double.parseDouble(tokens[tokens.length-1].trim()));
		}
		br.close();
	}
	
	private void trainMultiNomialNB(Class currClass) throws Exception {
		vocabulary = new HashSet<String>();
		
		if(currClass == null) {

			for(Class c: Class.values()) {
				getTokenCounts().put(c, new HashMap<String, Integer>());
				getTokenCondProb().put(c, new HashMap<String, Double>());
			}
			
			for(Class c: Class.values()) {
				trainMultiNomialNB(c);
			}
			
			for(Class c: Class.values()) {
				int totalTokenCnt = getClassTokens().get(c).size() + getVocabulary().size();
				for(String word: getVocabulary()) {
					getTokenCondProb().get(c).put(word, (double)getTokenCounts().get(c).get(word)/totalTokenCnt);
				}
			}
			
			return;
		}
		
		String filePath = null;
		Object[] listOfFiles = null;
		String fileText = null, str = null, token = null;
		BufferedReader br = null;
		Collection<String> tokens = null;
		Iterator<String> itr = null;
		
		listOfFiles = trainFiles.get(currClass);
		getClassTokens().put(currClass, new ArrayList<String>());
		
		for(int i = 0; i < listOfFiles.length; i++) {
			if(((File)listOfFiles[i]).isFile()) {
				fileText = "";
				filePath = ((File)listOfFiles[i]).getAbsolutePath();
				br = new BufferedReader(new FileReader(filePath));
				while((str = br.readLine()) != null) {
					fileText = fileText + " " + str;
				}
				br.close();
				fileText = fileText.toLowerCase();
				//fileText = fileText.replaceAll(getRegex(), " ");
				tokens = new ArrayList<String>(Arrays.asList(fileText.toLowerCase().split("[\\s]+")));

				itr = tokens.iterator();
				while(itr.hasNext()) {
					token = itr.next();
					if(isIgnoreStopWords() && getStopWords().contains(token)) {
						itr.remove();
						continue;
					}
					if(getTokenCounts().get(currClass).get(token) == null)
						getTokenCounts().get(currClass).put(token,2);
					else
						getTokenCounts().get(currClass).put(token,getTokenCounts().get(currClass).get(token)+1);
					for(Class c: Class.values()) {
						if(c == currClass)
							continue;
						if(getTokenCounts().get(c).get(token) == null)
							getTokenCounts().get(c).put(token,1);
					}
				}
				
				getClassTokens().get(currClass).addAll(tokens);
				getVocabulary().addAll(tokens);
				vocab = new ArrayList<String>(getVocabulary());
			}
		}
	}

	public double testMultiNomial() throws Exception {
		readLM();
		int correctCnt = testMultiNomialNB(null);
		int totalTestDocCnt = 0;
		for(Class c: Class.values())
			totalTestDocCnt+=testFiles.get(c).length;
		double accuracy = ((double)correctCnt*100/(double)totalTestDocCnt);
		System.out.println("Accuracy of naive bayes classifier ("+(isIgnoreStopWords()?"excluding":"including")+" stopwords) is: "+accuracy);
		return accuracy;
	}
	
	private int testMultiNomialNB(File[] files) throws Exception {
		int correctCnt = 0, totalCnt = 0;
		Class expectedClass = null;
		
		if(files == null) {
			for(Class c: Class.values())
				correctCnt+=testMultiNomialNB(testFiles.get(c));
			return correctCnt;
		}
		
		if(files[0].getParent().substring(files[0].getParent().lastIndexOf(File.separator)+1).equalsIgnoreCase(Class.neg.name()))
			expectedClass = Class.neg;
		else if(files[0].getParent().substring(files[0].getParent().lastIndexOf(File.separator)+1).equalsIgnoreCase(Class.pos.name()))
			expectedClass = Class.pos;
		
		File[] listOfFiles = files;
		String filePath = null;
		String fileText = null, str = null;
		BufferedReader br = null;
		List<String> tokensInDoc = null;
		double probability = 0, maxProbability = 0;
		Class actualClass = null;
		List<String> tokens = null;
		Iterator<String> itr = null;
	
		for(int i = 0; i < listOfFiles.length; i++) {
			if(listOfFiles[i].isFile()) {
				fileText = "";
				filePath = listOfFiles[i].getAbsolutePath();
				br = new BufferedReader(new FileReader(filePath));
				while((str = br.readLine()) != null) {
					fileText = fileText + " " + str;
				}
				br.close();
				tokensInDoc = new ArrayList<String>();
				fileText = fileText.toLowerCase();
				//fileText = fileText.replaceAll(getRegex(), " ");
				tokens = new ArrayList<String>(Arrays.asList(fileText.toLowerCase().split("[\\s]+")));
				if(isIgnoreStopWords()) {
					itr = tokens.iterator();
					while(itr.hasNext()) {
						str = itr.next();
						if(getStopWords().contains(str)) {
							itr.remove();
							continue;
						}
					}
				}
				tokensInDoc.addAll(tokens);
				
				actualClass = null;
				maxProbability = 0;
				for(Class c: Class.values()) {
					probability = Math.log10(getPrior().get(c))/Math.log10(2);
					for(String token: tokensInDoc) {
						probability = probability + (getTokenCondProb().get(c).get(token)==null ? 0 : Math.log10(getTokenCondProb().get(c).get(token))/Math.log10(2));
					}
					if(actualClass == null || (probability > maxProbability)) {
						maxProbability = probability;
						actualClass = c;
					}
				}
				
				if(actualClass == expectedClass)
					correctCnt++;
				totalCnt++;
			}
		}

		//log("correct count in class "+ expectedClass.name() + ": "+correctCnt+"/"+totalCnt+". Accuracy: "+((double)correctCnt/totalCnt));
		return correctCnt;
	}

	public void perform10FoldCrossValidation() throws Exception {
		System.out.println("NAIVE BAYES: PERFORMING 10 FOLD CROSS VALIDATION");
		double accuracy = 0.0;
		int chunkSize = 0;
		
		File negFolder = new File(getDataFolder()+File.separator+Class.neg.name());
		File posFolder = new File(getDataFolder()+File.separator+Class.pos.name());

		totalFiles = new HashMap<Class, File[]>();
		totalFiles.put(Class.neg, negFolder.listFiles());
		totalFiles.put(Class.pos, posFolder.listFiles());
		chunkSize = totalFiles.get(Class.pos).length/10;

		for(int i = 0; i < foldCnt; i++) {
			int testFrom, testTo;
			testFrom = (foldCnt - i - 1)*chunkSize;
			testTo = testFrom + chunkSize;

			testFiles = new HashMap<Class, File[]>();
			testFiles.put(Class.neg, Arrays.copyOfRange(totalFiles.get(Class.neg), testFrom, testTo));
			testFiles.put(Class.pos, Arrays.copyOfRange(totalFiles.get(Class.pos), testFrom, testTo));

			trainFiles = new HashMap<Class, Object[]>();
			List<File> tempList = new ArrayList<File>(Arrays.asList(Arrays.copyOfRange(totalFiles.get(Class.neg), 0, testFrom)));
			List<File> tempList2 = new ArrayList<File>(Arrays.asList(Arrays.copyOfRange(totalFiles.get(Class.neg), testTo, totalFiles.get(Class.neg).length)));
			tempList.addAll(tempList2);
			trainFiles.put(Class.neg, tempList.toArray());
			
			tempList = new ArrayList<File>(Arrays.asList(Arrays.copyOfRange(totalFiles.get(Class.pos), 0, testFrom)));
			tempList2 = new ArrayList<File>(Arrays.asList(Arrays.copyOfRange(totalFiles.get(Class.pos), testTo, totalFiles.get(Class.pos).length)));
			trainFiles.put(Class.pos, tempList.toArray());

			trainMultiNomial();
			accuracy += testMultiNomial();
		}
		
		System.out.println("Final accuracy of naive bayes classifier ("+(isIgnoreStopWords()?"excluding":"including")+" stopwords) is: "+(accuracy/foldCnt));
	}

	public static void main(String[] args) throws Exception {

		String dataFolder = args[0];
		boolean ignoreStopWords = (args[1] == null ? false : Boolean.parseBoolean(args[1]));

		TextClassification filter = null;
		
		filter = new TextClassification(dataFolder);
		filter.loadStopWords();
		filter.setIgnoreStopWords(ignoreStopWords);
		filter.perform10FoldCrossValidation();

	}

}
