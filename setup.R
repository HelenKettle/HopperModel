#Parameters--------------------------------------------------------------------

phi<<-c(0.047, 0.438, 0.189, 0.326)#parasitoid fraction of population 
ajmax<<-c(5.63,1.43,1.43,1.23) #maximum attack rate

#Reproduction rates (from field data)
if (Expt == 'Mix') {
    H.repro <<- c(23.8, 13.5)
} else{
    H.repro <<- c(28.3, 14.1)
}

#natural death rates
He.nat.death <<- c(0, 0)
Hn.nat.death <<- c(0, 0)
Pe.nat.death <<- 0
Pa.nat.death <<- 0

#female fraction of hoppers
femFracH <<- 1

#Stage durations:
durHE <<- 8 #hopper eggs
durHN <<- 18#hopper nymphs
durPE <<- c(11, 12.5, 12, 9.5) #parasitoid eggs
  
#INITIAL CONDITIONS-------------------------------------------------------------------
parasitoidIC <<- matrix(0, nrow = 2, ncol = 4)

hopperIC <<- matrix(0,nrow=3,2)
#number of hopper adult strains changes with experiment:
if (Expt=='BPH'){hopperIC[3,]=c(4,0)}
if (Expt=='GLH'){hopperIC[3,]=c(0,4)}  
if (Expt=='Mix'){hopperIC[3,]=c(2,2)}

#----------------------------------------------------------------------------------------------
  
timeExposureSt <<- 2
timeExposureEnd <<- 5

rapidEmRate <<- 100 

 #----------------------------------------------------------------------------------------------
 



