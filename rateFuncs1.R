rateFunctions<-list(

    reproFunc=function(x,time,species,strain){

          #reproduction (eggs/time)
        reprod=0
        tmp=0
        
        if (species==1){#Hoppers
            if (time<=timeExposureSt){
                reprod=femFracH*H.repro[strain]*x$Hoppers['Adults',strain]
            }
        }
        
        if (species==2){#parasitoids
            if (time>=timeExposureSt & time<=timeExposureEnd){
                tmp=0*seq(1,numStrains[1])
                for (k in 1:numStrains[1]){#multiple hosts (hoppers)
                        tmp[k]=ajmax[strain]*phi[strain]*Pftot*x$Hoppers['Eggs',k]/
                            (Kp[strain,k]*(1+x$Hoppers['Eggs',1]/Kp[strain,1]+x$Hoppers['Eggs',2]/Kp[strain,2]))
                }
                reprod=sum(tmp)#sum over multiple hosts (hoppers)
                }
        }
        return(max(0,reprod))
    },
#--------------------------------------------------------------------------------------------------------
    deathFunc=function(stage,x,time,species,strain){
                                        #per capita death rate (/time)
        death=0
        natural=0
        if (species==1){#Hoppers
            if (stage==1){
                natural=He.nat.death[strain]
                if (time>=timeExposureSt & time<=timeExposureEnd){
                    tmp.p=0*seq(1,numStrains[2])
                    for (k in 1:numStrains[2]){#specific death due to para attack
                        tmp.p[k]=gama*ajmax[k]*phi[k]*Pftot/
                            (Kp[k,strain]*(1+x$Hoppers['Eggs',1]/Kp[k,strain]+x$Hoppers['Eggs',2]/Kp[k,strain]))
                    }
                    death.p=sum(tmp.p)
                    
                    #specific death due to mirid attack
                    death.m=alphaM/(sum(x$Parasitoids['Eggs',])+sum(x$Hoppers['Eggs',])+Km)
                    
                    death=death.m+death.p
                }
            }
            
            if (stage==2){
                natural=Hn.nat.death[strain]
            }
        }               
        
        if (species==2){#parasitoids
            if (stage==1){
                natural=Pe.nat.death
                if (time>=timeExposureSt & time<=timeExposureEnd){
                    #specific death due to mirid attack 
                    death=alphaM/(sum(x$Parasitoids['Eggs',])+sum(x$Hoppers['Eggs',])+Km)
                }
            }
            
            if (stage==2){natural=Pa.nat.death}
        }
        return(max(0,death+natural))
    },
#--------------------------------------------------------------------------------------------------------
    durationFunc=function(stage,x,time,species,strain){
        if (species==1){# Hoppers
            if (stage==1){v=durHE}
            if (stage==2){v=durHN}
        }
        if (species==2){#Parasitoids
            if (stage==1){
                v=durPE[strain]
            }
        }
        return(max(0,v))
    },
#--------------------------------------------------------------------------------------------------------
    immigrationFunc=function(stage,x,time,species,strain){
        #density/time
        v=0
        return(v)
    },
#--------------------------------------------------------------------------------------------------------
    emigrationFunc=function(stage,x,time,species,strain){
                                        #per capita rate (/time)
        v=0
        if (species==1 & stage==3 & time>=timeExposureSt){v=rapidEmRate}
        if (species==2 & stage==2 & time>=timeExposureEnd & time<(timeExposureEnd+2)){v=rapidEmRate}
        return(v)
    }
)
#--------------------------------------------------------------------------------------------------------

