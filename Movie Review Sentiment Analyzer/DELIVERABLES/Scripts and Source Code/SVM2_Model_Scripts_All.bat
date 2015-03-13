echo 'Train: SMO2 - Unigram - TFIDF - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_111.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -I -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Unigram - TFIDF - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_112.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -I -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Bigram - TFIDF - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_211.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -I -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Bigram - TFIDF - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_212.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -I -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Unigram - TF - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_121.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Unigram - TF - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_122.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Bigram - TF - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_221.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Bigram - TF - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_222.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -T -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Unigram - PNP - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_131.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Unigram - PNP - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_132.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 1 -min 1\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Bigram - PNP - EXCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_231.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -N 0 -L -S -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


echo 'Train: SMO2 - Bigram - PNP - INCL SW'
java -classpath %classpath% weka.classifiers.meta.FilteredClassifier -t train.arff -d train_SMO2_232.model -c 2 -x 3 -v -o -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.StringToWordVector -R first-last -W 1000000 -prune-rate -1.0 -N 0 -L -stemmer weka.core.stemmers.SnowballStemmer -M 1 -stopwords \\\"E:\\\\\\\\Higher Studies\\\\\\\\STUDY\\\\\\\\Semester3\\\\\\\\NLP\\\\\\\\Project\\\\\\\\MODEL_GEN\\\\\\\\stopwords.txt\\\" -tokenizer \\\"weka.core.tokenizers.NGramTokenizer -delimiters \\\\\\\" \\\\\\\\r\\\\\\\\n\\\\\\\\t.,;:\\\\\\\\\\\\\\\'\\\\\\\\\\\\\\\"()?!\\\\\\\" -max 2 -min 2\\\"\" -F \"weka.filters.supervised.attribute.AttributeSelection -E \\\"weka.attributeSelection.InfoGainAttributeEval \\\" -S \\\"weka.attributeSelection.Ranker -T 0.0 -N -1\\\"\"" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 2.0"


pause
