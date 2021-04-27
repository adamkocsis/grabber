buffer <- NULL

#' Grab a matrix based on interactively input coordinates
#' 
#' The function constructs a function call to create a matrix based on
#' clicks of the mouse
#' 
#' This is a wrapper to the locator() function, quickening the
#' definition of matrices based on plots.
#' @param n \code{numeric} Positive integer, the number of coordinates to be located
#' @param round \code{numeric} Positive integer, the number of digits to conserve.
#' @param ... Arguments passed to the locator() function.
#' @return The function returns a numeric matrix when assigned to an object.
#' @export
grab_matrix <- function(n=2, round=2,...){

	# defend for n
	Check_n(n)
	
	# Check the use of round
	Check_round(n, round)
	
	# use the buffer
	buffer$xs <- NULL
	buffer$ys <- NULL

	# grab the points one by one
	for(i in 1:n){
		cat("Click on  point no. ",i,":				\r")
		point <- graphics::locator(1,...)
		buffer$xs <- c(buffer$xs, point$x)
		buffer$ys <- c(buffer$ys, point$y)
		flush.console()
		
	}
	
	# clean the console
	cat("					               					\r")
	flush.console()
		
	# results
	res <- NULL
	
	
	# display output
	cat("mat <- matrix(c(", "\n")
	
	if(!is.null(round)) xs<-round(buffer$xs, round)
	if(!is.null(round)) ys<-round(buffer$ys, round)
	for(i in 1:n){
		if(i!=n){
			cat(paste("	", deparse(xs[i]),", ", deparse(ys[i]), ",\n", sep=""))
		}else{
			cat(paste("	", deparse(xs[i]),", ", deparse(ys[i]), "\n", sep=""))
		}
		
	}
		
	cat("), ncol=2, byrow=TRUE)", "\n")
	res <- matrix(c(xs, ys), ncol=2)

	invisible(res)
	
}



grab_lims(round=2,...){
	if(length(round)==1) round <- rep(round,2)
}
		

