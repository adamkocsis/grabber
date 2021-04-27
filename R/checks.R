# Standard argument checking.

# The number of ht
Check_n<- function(n){
	if(length(n) != 1 |  any(n%%1!=0) | any(n==0)) stop("Please provide one positive integer for 'n'. ")
}

# The standard rounding argument
Check_round <- function(n, round){
	if(length(round)==1) {
		round <- rep(round,2)
	}else{
		# do a check, make sure the length is ok
		if(length(round)!=n) stop("Incorrect number of rounding values.")
	}
}
