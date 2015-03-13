import nltk;
from collections import defaultdict
from random import uniform
import csv
import sys
from math import log
testFile="C:\\Users\\Vivek\\Downloads\\NLP\\hw3\\hw3_test_00.txt" #sys.argv[2]
modelFile="C:\\Users\\Vivek\\Downloads\\NLP\\hw3\\modelfile.txt" #sys.argv[4]
outputFile="C:\\Users\\Vivek\\Downloads\\NLP\\hw3\\outputtest.txt" #sys.argv[6]

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
 
    # initialize array with n colums and s rows
    delta=[[-999.99 for _ in range(n)] for _ in range(len(states))]
    gamma=[[0 for _ in range(n)] for _ in range(len(states))]
    
    for i in range(0,n):
        gamma[0][i]=0
        if states[0] in observation[Tag[i]].keys():
            delta[0][i]=observation[Tag[i]][states[0]]["logProb"]
        #print("%s %s %s\n"%(states[0],Tag[i],delta[0][i]))
    #print(delta[0])
    
    for f in range(1,len(states)):
        for i in range(0,n):
            maxj=-999.9
            prevj=-1
            for j in range(0,n):
                tmp=delta[f-1][j]
                if(delta[f-1][j]<-900):
                    pass
                    #continue
                if not((Tag[i] in transition[Tag[j]].keys()) and (states[f] in observation[Tag[i]].keys())):
                    #continue
                    pass
                else:
                    pass
                tmp=delta[f-1][j]+transition[Tag[j]][Tag[i]]["logProb"]+observation[Tag[i]][states[f]]["logProb"]
                if(maxj<=tmp):
                    maxj=tmp
                    prevj=-1
            delta[f][i]=maxj
            gamma[f][i]=prevj
    #print(delta)
    i=len(states)-2
    tag=-1

    result=[]
    while(i>0):
        cmax=-999.99
        ps=0
        if(tag==-1):
            for j in range(0,n):
                if(delta[i][j]!=0.0)and (delta[i][j]>cmax):
                    cmax=delta[i][j]
                    ps=j
        else:
            cmax=delta[i][tag]
            ps=gamma[i][tag]
        if(cmax!=-999.99):
            if states[i] in POS.keys():
                result.append(states[i]+"/"+Tag[ps])
                tag=gamma[i][j]
            else:
                pTag=""
                if(len(result)>=1):
                    pTemp=result[-1].split("/")
                    pTag=unknownGuess(pTemp[1])
                else:
                    pTag=unknownGuess("")
                result.append(states[i]+"/"+pTag+"-UKNW")
                tag=-1
        else:
            pTag=""
            if(len(result)>=1):
                pTemp=result[-1].split("/")
                pTag=unknownGuess(pTemp[1])
            else:
                pTag=unknownGuess("")
            result.append(states[i]+"/"+pTag+"-UKNW")
            tag=-1

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

print(len(transition))
print(len(observation))
print(len(POS))
#print(Tag)
lineNo=0
for l in testFile:
    lineNo+=1
    #print("Processing Line:%s"%lineNo)
    l1="<s> "+l[:-1]+" <e>"
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
