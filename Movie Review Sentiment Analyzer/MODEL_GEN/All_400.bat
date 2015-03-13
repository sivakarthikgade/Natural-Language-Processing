echo 'NB 400 Train Model'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier 
	-t train.arff 
	-d train_NB.model 
	-c 2 -x 3 -v -o 
	-F "weka.filters.MultiFilter 
		-F \"weka.filters.unsupervised.attribute.StringToWordVector 
			-R first -W 1000000 -prune-rate -1.0 -I -N 0 -L 
			-stemmer \\\"weka.core.stemmers.SnowballStemmer -S porter\\\" -M 2 
			-tokenizer \\\"weka.core.tokenizers.WordTokenizer -delimiters \\\\\\\" \\\\\\\\r \\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!<>\\\\\\\"\\\"\" 
		-F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" 
	-W weka.classifiers.bayes.NaiveBayes --


java -classpath %classpath% weka.classifiers.meta.FilteredClassifier 
	-t train.arff 
	-d train_NB.model 
	-c 2 -x 3 -v -o 
	-F "weka.filters.MultiFilter 
		-F \"weka.filters.unsupervised.attribute.StringToWordVector 
			-R first-last -W 100000 -prune-rate -1.0 -T -I -N 0 -L 
			-S -stemmer weka.core.stemmers.SnowballStemmer -M 1 
			-stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" 
			-tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" 
		-F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" 
	-W weka.classifiers.bayes.NaiveBayes --






echo 'J48 400 Train Model'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train_400.arff -d train_DT400.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first -W 1000000 -prune-rate -1.0 -I -N 0 -L -stemmer \\\"weka.core.stemmers.SnowballStemmer -S porter\\\" -M 2 -tokenizer \\\"weka.core.tokenizers.WordTokenizer -delimiters \\\\\\\" \\\\\\\\r \\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!<>\\\\\\\"\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2

echo 'SMO Degree1 Kernel 400 Train Model'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO1400.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first -W 1000000 -prune-rate -1.0 -I -N 0 -L -stemmer \\\"weka.core.stemmers.SnowballStemmer -S porter\\\" -M 2 -tokenizer \\\"weka.core.tokenizers.WordTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!<>\\\\\\\"\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 1.0"

echo 'SMO Degree2 Kernel 400 Train Model'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2400.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first -W 1000000 -prune-rate -1.0 -I -N 0 -L -stemmer \\\"weka.core.stemmers.SnowballStemmer -S porter\\\" -M 2 -tokenizer \\\"weka.core.tokenizers.WordTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!<>\\\\\\\"\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"

echo 'SMO RbF Kernel 400 Train Model'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMORbF400.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first -W 1000000 -prune-rate -1.0 -I -N 0 -L -stemmer \\\"weka.core.stemmers.SnowballStemmer -S porter\\\" -M 2 -tokenizer \\\"weka.core.tokenizers.WordTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!<>\\\\\\\"\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.RBFKernel -C 250007 -G 0.01"

echo '1NN 400 Train Model'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train_400.arff -d train_1NN400.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first -W 1000000 -prune-rate -1.0 -I -N 0 -L -stemmer \\\"weka.core.stemmers.SnowballStemmer -S porter\\\" -M 2 -tokenizer \\\"weka.core.tokenizers.WordTokenizer -delimiters \\\\\\\" \\\\\\\\r \\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!<>\\\\\\\"\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.lazy.IBk -- -K 1 -W 0 -A "weka.core.neighboursearch.LinearNNSearch -A \"weka.core.EuclideanDistance -R first-last\""

echo '3NN 400 Train Model'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train_400.arff -d train_3NN400.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first -W 1000000 -prune-rate -1.0 -I -N 0 -L -stemmer \\\"weka.core.stemmers.SnowballStemmer -S porter\\\" -M 2 -tokenizer \\\"weka.core.tokenizers.WordTokenizer -delimiters \\\\\\\" \\\\\\\\r \\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!<>\\\\\\\"\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.lazy.IBk -- -K 3 -W 0 -A "weka.core.neighboursearch.LinearNNSearch -A \"weka.core.EuclideanDistance -R first-last\""

echo 'Random Forest 400'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train_400.arff -d train_RF400.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first -W 1000000 -prune-rate -1.0 -I -N 0 -L -stemmer \\\"weka.core.stemmers.SnowballStemmer -S porter\\\" -M 2 -tokenizer \\\"weka.core.tokenizers.WordTokenizer -delimiters \\\\\\\" \\\\\\\\r \\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!<>\\\\\\\"\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.RandomForest -- -I 10 -K 0 -S 1
