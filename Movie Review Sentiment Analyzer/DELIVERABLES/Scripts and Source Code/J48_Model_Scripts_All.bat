echo 'Train: DT - Unigram - TFIDF - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_111.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -I -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Unigram - TFIDF - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_112.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -I -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Bigram - TFIDF - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_211.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -I -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Bigram - TFIDF - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_212.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -I -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Unigram - TF - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_121.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Unigram - TF - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_122.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Bigram - TF - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_221.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Bigram - TF - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_222.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Unigram - PNP - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_121.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Unigram - PNP - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_122.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Bigram - PNP - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_231.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


echo 'Train: DT - Bigram - PNP - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_DT_232.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.trees.J48 -- -C 0.25 -M 2


pause
