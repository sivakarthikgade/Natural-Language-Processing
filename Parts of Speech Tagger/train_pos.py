import nltk;
from collections import defaultdict
import sys
from math import log
trainfile =open('hw3_train.txt',"r")
modelFile=open('hw3_modelfile.txt',"w")

# Initialization of data structures 
# POS tags for a word tag  pair
POS=defaultdict(list)
#transition (Tag2(Tag1 count probs))
transition=defaultdict(lambda: defaultdict(lambda: defaultdict(int)))
#observation
observation=defaultdict(lambda: defaultdict(lambda: defaultdict(int)))


wordPairCount=0
words = list()
# Calculation for transitional and observation probabilities 
for line in trainfile:
    nextPair=""
    previous=tuple("<s>/ST".split("/"))
    words.append(previous[1])

    lineWithStart=line
    for pair in lineWithStart.split(" "):
        pair=pair.strip(' \t\n\r')
        if pair=="" or pair=="\t":
            continue       
        wordPairCount+=1
        current=tuple(pair.split("/"))
        words.append(current[1])
        if previous!=None:
            # transition T2 T1
            transition[previous[1]][current[1]]["count"]+=1
            transition[previous[1]]["#totalCount#"]["count"]+=1
        
        # observation w1 T1
        observation[current[1]][current[0]]["count"]+=1
        observation[current[1]]["#totalCount#"]["count"]+=1

        # add the possible POS tags for a pair
        if current[1] not in POS[current[0]]:
            POS[current[0]].append(current[1])

        previous=current
        nextPair=pair
#print(wordPairCount)
N=len(words) 
#print(words)                                                                                                                                                                                                               
temp=1.0                                                                                                                            
unigram_count = {}  
for i,word in enumerate(words):
    if i<len(words):
        word=words[i]
        if word in unigram_count:
            unigram_count[word]+=1
        else:
            unigram_count[word]=1

unigram_probability = {}

for k,v in unigram_count.items():
    temp=(float(v)/float(N))    
    unigram_probability[k]=temp
bigram= {}
for i,word in enumerate(words):
    if i<len(words)-1:
        if words[i+1]=='ST':
            continue
        k=(words[i+1],words[i])
        if k in bigram:
            bigram[k]+=1
        else:
            bigram[k]=1

bigram = sorted(bigram.items(), key=lambda k:k[0], reverse=False)
temp = ""
count=0
save_bigram={}                                                         
bigram_probability ={}
alpha = {}   
for k,v in bigram:
    bigram_probability[k]=float(v)/float(unigram_count[k[0]])
'''
	if temp!=k[0]:
        if (count==0) and (temp!=""):
            for e,file in save_bigram.items():
                bigram_probability[e]=float(file)*0.999/float(unigram_count[e[0]])
        if temp!="":
            sum_bigram=0.0
            sum_unigram=0.0
            for e,file in save_bigram.items():
                sum_bigram = sum_bigram + bigram_probability[e]
                sum_unigram = sum_unigram + unigram_probability[e[1]]
            alpha[temp] = (1  - sum_bigram)/(1-sum_unigram)
        temp=k[0]
        if v==1:
            count=1
        count=0
        save_bigram={}
    if temp==k[0]:
        save_bigram[k]=v
        if v==1:
            count=1
if (count==0) and (temp!=""):
    for e,file in save_bigram.items():
        bigram_probability[e]=float(file)*0.999/float(unigram_count[e[0]])
sum_bigram=0.0
sum_unigram=0.0
for e,file in save_bigram.items():
    sum_bigram = sum_bigram + bigram_probability[e]
    sum_unigram = sum_unigram + unigram_probability[e[1]]
alpha[temp] = (1  - sum_bigram)/(1-sum_unigram)
unigram_count = sorted(unigram_count.items(), key=lambda k:k[0], reverse=False)
alpha['<e>']=0
# probability calculations 
'''

for key,value in transition.items():
    for key1,value1 in value.items():
        if (key1=="#totalCount#"):
            continue
        probT2T1ml=float(value1["count"])/float(value["#totalCount#"]["count"])
#        probT2ml = float(value["#totalCount#"]["count"])/wordPairCount
#        prob =alpha[key]*probT2T1ml + (1-alpha[key])*probT2ml
        prob = probT2T1ml
        transition[key][key1]["prob"]=prob
        transition[key][key1]["logProb"]=log(prob,2)
        #print(transition.items())


for key,value in observation.items():
    for key1,value1 in value.items():
        if (key1=="#totalCount#"):
            continue
        prob=float(value1["count"])/float(value["#totalCount#"]["count"])
        observation[key][key1]["prob"]=prob
        observation[key][key1]["logProb"]=log(prob,2)




## start writing to model file
modelFile.write("#wordPOS#"+"\t\n")


# write
for key,value in POS.items():
    modelFile.write(key)
    for posTag in value:
        modelFile.write("\t"+posTag)
    modelFile.write("\n")


modelFile.write("#transProb#"+"\t\n")

for key,value in transition.items():
    for key1,value1 in value.items():
        if(key1=="#totalCount#"):
            continue
        modelFile.write("%s\t%s\t%f\t%f\n"%(key,key1,value1["prob"],value1["logProb"]))

modelFile.write("#obsProb#\t\n")
for key,value in observation.items():
    for key1,value1 in value.items():
        if(key1=="#totalCount#"):
            continue
        modelFile.write("%s\t%s\t%f\t%f\n"%(key,key1,value1["prob"],value1["logProb"]))


print("model created ")
modelFile.close()