import java.io.*;

public class  EnsembleResultGenerator
{
	public static void main(String args[]) throws Exception {
		EnsembleResultGenerator g = new EnsembleResultGenerator();
		BufferedReader br = new BufferedReader(new FileReader("EnsembleResults.txt"));
		int tp = 0, tn = 0, fp = 0, fn = 0;
		String str = "", actualClass = "", predClass = "";
		while((str = br.readLine()) != null) {
			if(!str.startsWith("Actual Class: "))
				continue;
			str = str.substring("Actual Class: ".length());
			actualClass = str.substring(0, 3);
			str = str.substring(str.indexOf("Predicted Class: ")+"Predicted Class: ".length());
			predClass = str.substring(0, 3);
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
		System.out.println("tp: "+tp+"; tn: "+tn+"; fp: "+fp+"; fn: "+fn);
	}
}