rankhospital <- function(state, outcome, num = "best") {
        
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Check that state is valid
        states <- unique(data$State)
        ## get state from states, if exist result should be 1
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
        
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        
        ## Determine column index for desease
        deseaseColIndex <- 0
        if(outcome == "heart attack"){
                deseaseColIndex <- 11
        }else if(outcome == "heart failure"){
                ## column 17
                deseaseColIndex <- 17
        }else{
                deseaseColIndex <- 23
        }
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
                return(hospitalOrdered[1,1])
        }
        else if(num == "worst"){
                return(hospitalOrdered[nrow(hospitalOrdered),1])
        }
        else if(num > nrow(hospitalOrdered)){
                return(NA)
        }
        else if(num > 0){
                return(hospitalOrdered[num,1])
        }
        return(hospitalOrdered)
        
}