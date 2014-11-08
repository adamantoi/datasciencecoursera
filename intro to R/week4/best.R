best <- function(state, outcome){
        
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Check that state is valid
        states <- unique(data$State)
        nstate <- which(states == state)
        if(length(nstate) == 0){
                stop("invalid state")
        }
        
        ## Check that outcome / cause of death are valid
        cod <- c("heart attack", "heart failure", "pneumonia")
        noutcome <- which(cod == outcome)
        if(length(noutcome) == 0){
                stop("invalid outcome")
        }
        ## get hopitals name in the state
        hospitals <- data[data$State == state,]
        
        ##
        ## Return hospital name in that state with lowest 30-day death rate
        ##
        
        ## Determine column index for desease
        deseaseColIndex <- 0
        if(outcome == "heart attack"){
                deseaseColIndex <- 13
        }else if(outcome == "heart failure"){
                deseaseColIndex <- 19
        }else{
                deseaseColIndex <- 25
        }
        ## Change value to numeric type
        hospitals[,deseaseColIndex] <- as.numeric(hospitals[,deseaseColIndex])
        
        ## Get lowest value, remove NA
        lowestMortality <- min(hospitals[,deseaseColIndex], na.rm = TRUE)
        
        ## Get hospital names with lowest mortality on the desease
        bestHospitals <- hospitals[which(hospitals[deseaseColIndex] == lowestMortality),]
        
        ## Return only one name based on alphabetic order using Min
        return(min(bestHospitals$Hospital.Name))
}