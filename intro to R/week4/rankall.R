rankall <- function(outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Check that outcome / cause of death are valid
        cod <- c("heart attack", "heart failure", "pneumonia")
        noutcome <- which(cod == outcome)
        if(length(noutcome) == 0){
                stop("invalid outcome")
        }

        ## For each state, find the hospital of the given rank
        
        ## get states in lex order
        states <- unique(data$State)
        states <- states[order(states)]
        
        ## Determine column index for desease
        deseaseColIndex <- 0
        if(outcome == "heart attack"){
                deseaseColIndex <- 11
        }else if(outcome == "heart failure"){
                ## column 17
                deseaseColIndex <- 17
        }else{ ## pneumonia
                deseaseColIndex <- 23
        }
        rankAllHospital <- data.frame("hospital" = character(),"state" = character(), stringsAsFactors = FALSE)
   
        for(i in 1:54){
                ## get hopitals name in the state
                hospitals <- data[data$State == states[i],]
                ## Change value to numeric type
                hospitals[,deseaseColIndex] <- as.numeric(hospitals[,deseaseColIndex])
                hospitalsPahe <- hospitals[,c(2,deseaseColIndex)]
                ## order ascending berdasarkan 2 kolom, kolom rate dulu baru nama rs
                rank <- with(hospitalsPahe, order(hospitalsPahe[,2],hospitalsPahe[,1]))
                hospitalOrdered <- hospitalsPahe[rank,]
                ## remove NA
                hospitalOrdered <- subset(hospitalOrdered, !is.na(hospitalOrdered[,2]))
                ## return value base on num variable
                if(num == "best"){
                        rankAllHospital[i,] <- c(hospitalOrdered[1,1],states[i])
                }
                else if(num == "worst"){
                        rankAllHospital[i,] <- c(hospitalOrdered[nrow(hospitalOrdered),1],states[i])
                }
                else if(num > nrow(hospitalOrdered)){
                        rankAllHospital[i,] <- c(NA, states[i])
                }
                else if(num > 0){
                        rankAllHospital[i,] <- c(hospitalOrdered[num,1],states[i])
                }
        }
        
        invisible(rankAllHospital)
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
}