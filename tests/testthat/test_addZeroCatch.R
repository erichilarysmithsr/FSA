context("addZeroCatch() tests")

## simulate data set
df1 <- data.frame(net=c(1,1,1,2,2,3),
                  eff=c(1,1,1,1,1,1),
                  species=c("BKT","LKT","RBT","BKT","LKT","RBT"),
                  catch=c(3,4,5,5,4,3))

# Same as example 1 but with no ancillary data specific to the net number
df2 <- df1[,-2]

# Example Data #3 (All nets have same species ... no zeroes needed)
df3 <- data.frame(net=c(1,1,1,2,2,2,3,3,3),
                 eff=c(1,1,1,1,1,1,1,1,1),
                 species=c("BKT","LKT","RBT","BKT","LKT","RBT","BKT","LKT","RBT"),
                 catch=c(3,4,5,5,4,3,3,2,7))

## Example Data #4 (another variable that needs zeroes)
df4 <- df1
df4$recaps <- c(0,0,0,1,2,1)

test_that("addZeroCatch() messages",{
  expect_error(addZeroCatch(df1,"net","species"))
  expect_error(addZeroCatch(df1,"net","species",idvar="eff",zerovar=c("catch","eff")))
  expect_warning(addZeroCatch(df3,"net","species",zerovar="catch"))
  expect_error(addZeroCatch(df1,"net","species",idvar=c("catch","eff")))
})

test_that("addZeroCatch() results",{
  df1mod1 <- addZeroCatch(df1,"net","species",zerovar="catch")
  df1mod1
  expect_true(all(xtabs(~net,data=df1mod1)==3))
  tmp <- xtabs(~net+species,data=df1mod1)
  expect_true(all(tmp==1))
  expect_equivalent(nrow(tmp),3)
  expect_equivalent(ncol(tmp),3)
  expect_equivalent(colnames(tmp),c("BKT","LKT","RBT"))
  
  df1mod2 <- addZeroCatch(df2,"net","species",zerovar="catch")
  tmp <- xtabs(~net+species,data=df1mod2)
  expect_true(all(tmp==1))
  
  df3mod1 <- addZeroCatch(df3,"net","species",zerovar="catch")
  suppressWarnings(tmp <- xtabs(~net+species,data=df3mod1))
  expect_true(all(tmp==1))
  
  df4mod1 <- addZeroCatch(df4,"net","species",zerovar=c("catch","recaps"))
  tmp <- xtabs(~net+species,data=df4mod1)
  expect_true(all(tmp==1))
})