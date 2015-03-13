import java.util.*;
import java.io.*;

public class ClassifierEvaluator
{
	public static void main(String args[]) throws Exception {
		int tp = 0, tn = 0, fp = 0, fn = 0;
		File dir = new File(".\\aclImdb_final_test_set");
		File[] subDirs = dir.listFiles();
		for(File subDir: subDirs) {
			File[] files = subDir.listFiles();
			for(File file: files) {
				String testFile = file.getAbsolutePath();
				MovieReviewSentimentAnalyser c = new MovieReviewSentimentAnalyser();
				String actualClass = subDir.getName();
				String predClass = c.classify(testFile);
				System.out.println("Actual Class: "+actualClass+"; Predicted Class: "+predClass);
				if("pos".equals(actualClass)) {
					if("pos".equals(predClass)) {
						tp++;
					} else {
						fn++;
					}
				}
				if("neg".equals(actualClass)) {
					if("neg".equals(predClass)) {
						tn++;
					} else {
						fp++;
					}
				}
			}
		}
		System.out.println("tp: "+tp+"; tn: "+tn+"; fp: "+fp+"; fn: "+fn);
	}
}