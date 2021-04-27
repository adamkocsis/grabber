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
	round <- Check_round(n, round)
	
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

#' Grab plotting limites based on two interactively input coordinates
#' 
#' The function constructs xlim and ylim expressions that chan be used in a call to
#' the plot function based on clicks of the mouse.
#' 
#' This is a wrapper to the locator() function, quickening the
#' definition of limits on plots.
#' @param round \code{numeric} One or two positive integers, the number of digits to conserve.
#' @param ... Arguments passed to the locator() function.
#' @return The function has no return value.
#' @export 
grab_lims <- function(round=2,...){
	# basic defense of round
	round <- Check_round(n=2, round=round)
	
	# use the buffer
	buffer$xs <- NULL
	buffer$ys <- NULL

	cat("Click in bottom-left corner:		\r")
	p1 <- graphics::locator(1, ...)
	buffer$xs <- c(buffer$xs, p1$x)
	buffer$ys <- c(buffer$ys, p1$y)
	flush.console()
			
	cat("Click in top-right corner:			\r")
	p2 <- graphics::locator(1,...)
	buffer$xs <- c(buffer$xs, p2$x)
	buffer$ys <- c(buffer$ys, p2$y)
	flush.console()

	# do the rounding
	buffer$xs <- round(buffer$xs, round[1])
	buffer$ys <- round(buffer$ys, round[2])
	
	# display the output
	cat(paste(
		"xlim=c(",deparse(buffer$xs[1]),", ", deparse(buffer$xs[2]),
		"), ylim=c(", deparse(buffer$ys[1]),", ", deparse(buffer$ys[2]), ")", sep=""), "\n")
}
		

