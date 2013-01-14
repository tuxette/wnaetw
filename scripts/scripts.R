WhatMyTeacherWants <-
function(x){
	res <- c(
		round(mean(x, na.rm=TRUE), digits=2),
		round(median(x, na.rm=TRUE), digits=2),
		round(min(x, na.rm=TRUE), digits=2),
		max(x, na.rm=TRUE),
		max(x, na.rm=TRUE)-min(x, na.rm=TRUE),
		round(sd(x, na.rm=TRUE)),
		round(kurtosis(x, type=1,na.rm=TRUE), digits=2),
		round(skewness(x, type=1, na.rm=TRUE), digits=2),
		round(sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE), digits=2),
		round(quantile(x,probs=c(0.25,0.75), na.rm=TRUE), digits=2),
		round(ineq(x[!is.na(x)]),2))
	names(res) <- c("mean","median","min","max","range","sd","kurtosis","skewness","variation","Q1","Q3","gini")
	res
}

apply.wmtw <- function(df) {
  res <- NULL
  error <- NULL
  # Select numerical variables
  numVar <- sapply(1:ncol(df),function(x){is.numeric(df[,x])})
	if (sum(numVar)==0) {
		error <- "No numerical variables in the data: nothing to do...!"
	} else {
		# Run 'WhatMyTeacherWants' on numerical variables
		res <- apply(df[,numVar],2,WhatMyTeacherWants)
	}
  list("res"=res,"error"=error)
}