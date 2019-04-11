#Helen Kettle, Jan 2019
#requires stagePop package
#simulates interactions of 2 hopper species and 4 parasitoid species and an egg predator
#continuous time formulation

rm(list = ls())
#graphics.off()
#install.packages('stagePop')

library(stagePop)

expt.num=3  #choose from : 1 (BPH), 2 (GLH), or 3 (Mixed)

exptNames=c('BPH','GLH','Mix')
Expt=exptNames[expt.num] 

source('rateFuncs1.R')
source('setup.R')

gama=2.25 #parasitism efficiency

#linear relations for PfT and alphaM, with gamma
PfT.mat=rbind(c(14.95,-1.097),c(29.30,-4.04),c(12.93,-0.28))
dimnames(PfT.mat)=list(exptNames,c('intercept','coef'))
Pftot=PfT.mat[Expt,'intercept']+PfT.mat[Expt,'coef']*gama

alphaM.mat=rbind(c(50.73,-12.11),c(41.12,-11.47),c(47.3,-6.47))
dimnames(alphaM.mat)=list(exptNames,c('intercept','coef'))
alphaM=alphaM.mat[Expt,'intercept']+alphaM.mat[Expt,'coef']*gama


KpPref = 10 #parasitoid affinity for preferred host
Kp=cbind(BPH=c(KpPref, KpPref, 255, 926),GLH=c(6145, 1042, KpPref, KpPref)) #all parasitoid affinities
Km = 30 #mirid affinity

numStrains = c(2, 4)#2 strains of hopper, 4 strains of parasitoid

out1 = popModel(
    numSpecies = 2,
    speciesNames = c('Hoppers', 'Parasitoids'),
    numStages = c(3, 2),
    stageNames = list(c('Eggs', 'Nymphs', 'Adults'), c('Eggs', 'Adults')),
    numStrains = numStrains,
    timeVec = seq(0, 19, 0.1),
    rateFunctions = rateFunctions,
    timeDependLoss = rep(TRUE, 2),
    timeDependDuration = rep(FALSE, 2),
    ICs = list(hopperIC, parasitoidIC),
    solverOptions =  list('DDEsolver' = 'PBS', 'tol' = 1e-5, 'hbsize' = 1e5, 'dt' = 0.2),
    sumOverStrains = FALSE,
    plotStrainsFig = TRUE,
    plotFig = TRUE,
    checkForNegs = TRUE
)


