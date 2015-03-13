import nltk;
from collections import defaultdict
from random import uniform
import csv
import sys
from math import log
testFile="hw3_test_00.txt" #sys.argv[2]
modelFile="hw3_modelfile.txt" #sys.argv[4]
outputFile="hw3_outputtest.txt" #sys.argv[6]

model=csv.reader(open(modelFile,"r"), delimiter="\t")
testFile=open(testFile,"r")
resultFile=open(outputFile,"w")
#POS tags for a word
POS=defaultdict(list)
#transition probs dict
transition=defaultdict(lambda: defaultdict(lambda: defaultdict(int)))
#obs probs dict
observation=defaultdict(lambda: defaultdict(lambda: defaultdict(int)))


#delta=None
#gamma=None
Tag=None

def unknownGuess(prevState):
	cState=""
	cProb=-999.99
	for k,v in transition[prevState].items():
		if v["logProb"]<cProb:
			cProb=v["logProb"]
			cState=k
	#print("%s %s"%(prevState,cState))
	if cState=="":
		g=int(uniform(0,len(Tag)-1))
		cState=Tag[g]
	return cState


def Viterbi(states):
	n=len(Tag)

	delta=[[-999.99 for _ in range(n)] for _ in range(len(states))]
	gamma=[[0 for _ in range(n)] for _ in range(len(states))]
	delta[0][0] = 1.0;

	for f in range(1,len(states)):
		for i in range(1,n):
			maxj=-999.9
			prevj=-1
			for j in range(0,n):
				tmp=delta[f-1][j]
				if(delta[f-1][j]==-999.9):
					pass
				if((Tag[j] in transition.keys())) and ((Tag[i] in transition[Tag[j]].keys())):
					tmp=delta[f-1][j]*transition[Tag[j]][Tag[i]]["prob"]
					if(maxj<tmp):
						maxj=tmp
						prevj=j
			delta[f][i]=maxj
			gamma[f][i]=prevj
			if(states[f] in observation[Tag[i]].keys()):
				delta[f][i]=delta[f][i]*observation[Tag[i]][states[f]]["prob"]
			else:
				if(states[f] in POS.keys()):
					delta[f][i]=0;
				else:
					delta[f][i]=delta[f][i]*.00001;
					states[f] = states[f]+"-UKNW";
	#print(delta)
#	print(len(states))
#	for p in range(0,len(states)):
#		print(states[p]+", ");

	i=len(states)-1
	tag=-1

	result=[]
	while(i>1):
		cmax=-999.99
		if(tag==-1):
			for j in range(0,n):
				if(delta[i][j]>cmax):
					cmax=delta[i][j]
					tag = j
			result.append(states[i]+"/"+Tag[tag])
			result.append(states[i-1]+"/"+Tag[gamma[i][tag]])
			tag = gamma[i][tag]
		else:
			result.append(states[i-1]+"/"+Tag[gamma[i][tag]])
			tag = gamma[i][tag]
		i-=1

	return result


mode=""
for row in model:
	if(row[0]=="#wordPOS#"):
		mode="POS"
		continue
	if(row[0]=="#transProb#"):
		mode="trans"
		continue
	if(row[0]=="#obsProb#"):
		mode="obs"
		continue

	if(mode=="POS"):
		newList=[]
		for p in row[1:]:
			newList.append(p)
		POS[row[0]]=newList

	elif(mode=="trans"):
		transition[row[0]][row[1]]["prob"]=float(row[2])
		transition[row[0]][row[1]]["logProb"]=float(row[3])
		#if transition[row[0]][row[1]]["logProb"]==0.0:
		#    transition[row[0]][row[1]]["logProb"]=-.00000001

	elif(mode=="obs"):
		observation[row[0]][row[1]]["prob"]=float(row[2])
		observation[row[0]][row[1]]["logProb"]=float(row[3])
		#if observation[row[0]][row[1]]["logProb"]==0.0:
		#    observation[row[0]][row[1]]["logProb"]=-.00000001

Tag=list(transition.keys())

#print(len(transition))
#print(len(observation))
#print(len(POS))
print(len(Tag))
Tag.remove("ST")
print(len(Tag))
Tag.insert(0,"ST")
print(len(Tag))
print(Tag[0])
lineNo=0
for l in testFile:
	lineNo+=1
	#print("Processing Line:%s"%lineNo)
	l1="<s> "+l
	l2=[]
	for w in l1.split(" "):
		w=w.strip(" \t\n\r")
		if w=="" or w=="\t":
			continue
		l2.append(w)
	tags=Viterbi(l2)
	resultFile.write(tags[-1])
	for tg in range(len(tags)-2,-1,-1):
		resultFile.write(" "+tags[tg])
	resultFile.write("\n")
	#break



resultFile.close()
