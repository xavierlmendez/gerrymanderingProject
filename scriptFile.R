#create a seperate data set to maniputlate and narrow set down for ease of coding
#load data workspace from MIT website it will be set named to x
dataset<-x
dataset<-filter(dataset, state== "Texas",year == 2016, party != "NA")
#dataset %>% glimpse() 
#introduces variable to shorted data due to only needed to view winning party
dataset$win = NA
#introduces variable to be used to quantify gerrymandering
dataset$margin = NA
#tranverses dataset seting margin to difference in lost votes
i=0
numRow<-nrow(dataset)
#for loop fills in "win" variable for dataset
for(i in 1:numRow){
  if(dataset[i,"candidatevotes"]< (dataset[i,"totalvotes"]/2)){
    dataset[i,"win"]<-"no"
  }
  else{
    dataset[i,"win"]<-"yes"
  }
  i=i+1
}
#filter out the no win rows we will only need the wins for visualization
dataset<-filter(dataset, win=="yes")
numRow<-nrow(dataset)
#set the "margin" variable for each row
for(i in 1:numRow){
  margin<-(dataset[i,"totalvotes"]-dataset[i,'candidatevotes'])
  dataset[i,"margin"]<-margin
  i=i+1
}
#get average margin for both parties
republicanMargin<-0
republicanCounties<-0
democratMargin<-0
democratCounties<-0
numRow<-nrow(dataset)
numRow<-nrow(dataset)
for(i in 1:numRow){
  if((dataset[i,"party"]=="republican")==TRUE){
    republicanMargin=(republicanMargin+dataset[i,"margin"])
    republicanCounties=(republicanCounties+1)
  }
  else{
    democratMargin=(democratMargin+dataset[i,"margin"])
    democratCounties= (democratCounties+1)
  }
  i=i+1
}
#finds average margin of whice a party won
republicanAverage<-(republicanMargin/republicanCounties)
democratAverage<-(democratMargin/democratCounties)
#for the this dataset the result is a
#small average win margin for republicans: 7142
#large average win margin for democrats: 63787

#this tells us that democratic texans are largely condensed
#and that republicans are more likey to benefit from gerrymandering

#factoring in the votes given to each county
