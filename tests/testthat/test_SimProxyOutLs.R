context("SimProxyOutLs")

# data --------------------------------------------------------------------


simOut1 <- SimOut(poll       = NA,
                  outdir     = "/dir/to/outdir",
                  parameters = NA,
                  command    = "ls a b c")

simOut2 <- SimOut(poll       = NA,
                  outdir     = "/dir/to/outdir2",
                  parameters = NA,
                  command    = "ls a2 b2 c2")

simOutLs <- list(simOut1, simOut2)


# constructor -------------------------------------------------------------

test_that("SimProxyOutLs build the right object", {
  simProxyOutLs <- SimProxyOutLs(simOutLs)

  expect_s3_class(simProxyOutLs, "SimProxyOutLs")
})
test_that("SimProxyOutLs has the original object inside", {
  simProxyOutLs <- SimProxyOutLs(simOutLs)

  expect_equal(simProxyOutLs$simOutLs
               , simOutLs)
})

# toSimOut ----------------------------------------------------------------

test_that("toSimOut produce a single SimOut", {
  simProxyOutLs <- SimProxyOutLs(simOutLs)

  simOut <- ToSimOut.SimProxyOutLs(simProxyOutLs)

  expect_s3_class(simOut, "SimOut")
})

test_that("toSimOut produce a right SimOut", {
  simProxyOutLs <- SimProxyOutLs(simOutLs)

  simOut <- ToSimOut.SimProxyOutLs(simProxyOutLs)

  expect_equal(simOut$poll, NA)
  # expect_equal(simOut$command, simOut1$command)
  expect_equal(simOut$parameters, NA)
  expect_equal(simOut$command, simOut1$command)
})
