context("lencat() tests")

test_that("lencat() messages",{
  ## simulate data set
  df1 <- data.frame(len=round(runif(50,0.1,9.9),1),
                    fish=sample(c("A","B","C"),50,replace=TRUE))
  # wrong type of variable
  expect_error(lencat(~fish,data=df1),"must be numeric")
  # too many variables
  expect_error(lencat(~len+fish,data=df1),"only one variable")
  # bad width values
  expect_error(lencat(~len,data=df1,w=-1),"must be positive")
  expect_error(lencat(~len,data=df1,w=c(0.5,1)),"of length 1")
  # bad startcats
  expect_error(lencat(~len,data=df1,startcat=c(0.5,1)),"of length 1")
  # all NA values in the vector
  expect_warning(lencat(as.numeric(rep(NA,3))),"were missing")
  # use.names but not names given in breaks
  expect_warning(lencat(~len,data=df1,breaks=seq(0,10,1),use.names=TRUE),"Used default labels")
})

test_that("lencat() messages",{
  ## simulate data set
  vals <- 1:5
  freq <- 11:15
  tmp <- rep(vals,freq)
  tmp <- tmp+round(runif(length(tmp),0,0.9),1)
  df2 <- data.frame(len1=tmp,
                    len0.1=tmp/10,
                    len0.01=tmp/100,
                    len10=tmp*10,
                    fish=rep(c("A","B","C"),c(30,20,15)))
  ## Simple examples (same width as that created)
  tmp <- lencat(~len1,data=df2,w=1)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freq)
  tmp <- lencat(~len0.1,data=df2,w=0.1)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freq)
  tmp <- lencat(~len0.01,data=df2,w=0.01)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freq)
  tmp <- lencat(~len10,data=df2,w=10)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freq)
  ## Different widths (don't control startcat)
  freqtmp <- c(0,freq[c(2,4)])+freq[c(1,3,5)]
  tmp <- lencat(~len1,data=df2,w=2)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp)
  tmp <- lencat(~len0.1,data=df2,w=0.2)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp)
  tmp <- lencat(~len10,data=df2,w=20)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp)
  ## Different widths (control startcat)
  freqtmp <- freq[c(1,3,5)]+c(freq[c(2,4)],0)
  tmp <- lencat(~len1,data=df2,w=2,startcat=1)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp)
  tmp <- lencat(~len0.1,data=df2,w=0.2,startcat=0.1)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp)
  tmp <- lencat(~len10,data=df2,w=20,startcat=10)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp)
  ## Using breaks
  freqtmp <- freq[c(1,2,4)]+c(0,freq[c(3,5)])
  tmp <- lencat(~len1,data=df2,breaks=c(1,2,4))
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp)
  tmp <- lencat(~len0.1,data=df2,breaks=c(1,2,4)/10)
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp)
  ## using named breaks
  # but don't use names
  tmp <- lencat(~len1,data=df2,breaks=c(one=1,two=2,four=4))
  expect_is(tmp$LCat,"numeric")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp)
  # but do use names
  tmp <- lencat(~len1,data=df2,breaks=c(one=1,two=2,four=4),use.names=TRUE)
  expect_is(tmp$LCat,"factor")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp)
  # use names but don't return as a factor
  tmp <- lencat(~len1,data=df2,breaks=c(one=1,two=2,four=4),use.names=TRUE,as.fact=FALSE)
  expect_is(tmp$LCat,"character")
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),freqtmp[c(3,1,2)])
  # Don't need an automatic larger break
  tmp <- lencat(~len1,data=df2,breaks=c(one=1,two=2,four=4,six=6),use.names=TRUE)
  expect_equal(as.numeric(xtabs(~LCat,data=tmp)),c(freqtmp,0))
})