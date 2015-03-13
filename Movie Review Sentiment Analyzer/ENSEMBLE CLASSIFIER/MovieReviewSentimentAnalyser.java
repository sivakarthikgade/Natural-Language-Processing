
// Accepts a movie review as input. Uses the 5 chosen best models it has access to -> analyses the review using each of them -> Employs a voting mechanism and outputs a prediction.
// Prediction - Majority. If tie then weighted Majority. Weights - NB-2, DT-1, SVM1-2, SVM2-2, RF-1. If tie even after the tie breaker, then output SMO1 classifiers output.

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MovieReviewSentimentAnalyser {

	private static final AvailableModel[] Models = {AvailableModel.NaiveBayes, AvailableModel.J48, AvailableModel.SMO1, AvailableModel.SMO2, AvailableModel.RF};
	
	public MovieReviewSentimentAnalyser() {
	}
	
	public String classify(String inputFilePath) throws Exception {
		String prediction;
		Map<String, List<AvailableModel>> predictionList = new HashMap<String, List<AvailableModel>>();
		for(int i = 0; i < Models.length; i++) {
			MyFilteredClassifier classifier = new MyFilteredClassifier();
			classifier.load(inputFilePath);
			classifier.loadModel(Models[i].path);
			classifier.makeInstance();
			prediction = classifier.classify();
			if(!predictionList.keySet().contains(prediction)) {
				predictionList.put(prediction, new ArrayList<AvailableModel>());
			}
			predictionList.get(prediction).add(Models[i]);
			log("Done with: "+Models[i].name+" classifier. Prediction: "+prediction);
		}
		
		//Output the majority votes class as the prediction.
		String selectedPrediction = null;
		int selectedPredictionVotes = 0, tiePredVotes = 0;
		boolean tie = false;
		for(String prd: predictionList.keySet()) {
			if(selectedPredictionVotes < getWeightedVote(predictionList.get(prd), false)) {
				selectedPrediction = prd;
				selectedPredictionVotes = getWeightedVote(predictionList.get(prd), false);
			} else if(selectedPredictionVotes == getWeightedVote(predictionList.get(prd), false)) {
				tie = true;
				tiePredVotes = selectedPredictionVotes;
			}
		}
		
		//Output the majority weighted votes class as the prediction.
		if(tie && (tiePredVotes == selectedPredictionVotes)) {
			selectedPrediction = null;
			selectedPredictionVotes = 0; tiePredVotes = 0;
			tie = false;
			for(String prd: predictionList.keySet()) {
				if(selectedPredictionVotes < getWeightedVote(predictionList.get(prd), true)) {
					selectedPrediction = prd;
					selectedPredictionVotes = getWeightedVote(predictionList.get(prd), true);
				} else if(selectedPredictionVotes == getWeightedVote(predictionList.get(prd), true)) {
					tie = true;
					tiePredVotes = selectedPredictionVotes;
				}
			}

			//Output SMO1 prediction.
			if(tie && (tiePredVotes == selectedPredictionVotes)) {
				for(String prd: predictionList.keySet()) {
					if(predictionList.get(prd).contains(AvailableModel.SMO1)) {
						selectedPrediction = prd;
						log("Predicted Class: "+selectedPrediction);
						break;
					}
				}
			} else {
				log("Predicted Class: "+selectedPrediction);
			}
		} else {
			log("Predicted Class: "+selectedPrediction);
		}

		return selectedPrediction;
	}

	private int getWeightedVote(List<AvailableModel> models, boolean weighted) {
		if(!weighted) {
			return models.size();
		} else {
			int sum = 0;
			for(AvailableModel model: models) {
				sum = sum + model.weightage;
			}
			return sum;
		}
	}
	
	public static void main(String args[]) throws Exception {
		MovieReviewSentimentAnalyser c = new MovieReviewSentimentAnalyser();
		String testFile = args[0];
		c.classify(testFile);
	}
	
	private void log(String message) {
		System.out.println(message);
	}

}

