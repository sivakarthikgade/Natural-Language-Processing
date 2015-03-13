import sys


## result file from previous operation
res=open("hw3_outputtest.txt","r")  # sys.argv[4]

## reference file hw3_test_ref_00
ref=open("hw3_test_ref_00.txt","r") # sys.argv[2]


res1=res.readline()
ref1=ref.readline()

totalWords=0.0
totalKnown=0.0
totalUnknown=0.0
totalKnownMatch=0.0
totalKnownMismatch=0.0
totalUnknownMismatch=0.0
totalUnknownMatch=0.0

lineNum=1
while(res1!=""):
    l1=[]
    l2=[]
    for word in res1[0:-1].split(" "):
        word=word.strip(" \t\n\r")
        if word=="" or word=="\t":
            continue
        l1.append(word)

    for word in ref1[0:-1].split(" "):
        word=word.strip(" \t\n\r")
        if word=="" or word=="\t":
            continue
        l2.append(word)

    if(len(l1)!=len(l2)):
        print("Error:Mismatch of length at line:%s"%(lineNum))
        continue
    
    for i in range(0,len(l1)):
        ## result from previous op
        w1=l1[i].split("/")
        ## result from ref file
        w2=l2[i].split("/")

#        if(w1[0]!=w2[0]):
#           print("Error:Word mismatch at line:%s, result word:%s, reference word:%s"%(lineNum,w1[0],w2[0]))
#           continue

        if(l1[i]==l2[i]):
            totalKnown+=1
            totalKnownMatch+=1
        else:
            if "-UKNW" in w1[0]:
                totalUnknown+=1
                tw1=w1[0].split("-")
                if(tw1[0]==w2[0]) and (w1[1]==w2[1]):
                    totalUnknownMatch+=1
                else:
                    totalUnknownMismatch+=1
            else:
                totalKnown+=1
                totalKnownMismatch+=1

        totalWords+=1

    res1=res.readline()
    ref1=ref.readline()
    lineNum+=1



print("Total Words:%d"%(totalWords))
print("Total Known Words:%d"%(totalKnown))
print("Total Known Match:%d"%(totalKnownMatch))
print("Total Known Mismatch:%d"%(totalKnownMismatch))
print("Total Unknown Words:%d"%(totalUnknown))
print("Total Unknown Match:%d"%(totalUnknownMatch))
print("Total Unknown Mismatch:%d"%(totalUnknownMismatch))

#totalAccuracy
print("%% Accuracy (Total): %.2f"%(100*(totalKnownMatch+totalUnknownMatch)/(totalWords)))
print("%% Accuracy (Known): %.2f"%(100*(totalKnownMatch/totalKnown)))
print("%% Accuracy (Unknown): %.2f"%(100*(totalUnknownMatch/totalUnknown)))
