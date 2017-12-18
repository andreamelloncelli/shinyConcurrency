context("SimProxyOutLs")

# data --------------------------------------------------------------------


simOut1 <- SimOut(poll       = NA,
                  outdir     = "~/shiny-concurrency/shiny-server-pro/4_json/output_10_mysql_001usr_4thr_100-090-40_2min_net/",
                  parameters = NA,
                  command    = "ls a b c")
fileList1 <- c("profile_0_0.txt", "profile_0_1.txt", "profile_0_2.txt", "profile_0_3.txt")


simOut2 <- SimOut(poll       = NA,
                  outdir     = "/dir/to/outdir2",
                  parameters = NA,
                  command    = "ls a2 b2 c2")
fileList2 <- c("profile_0_0.txt", "profile_0_1.txt", "profile_0_2.txt")

simOutLs <- list(simOut1, simOut2)

simOutResult <- SimOut(poll       = NA,
                       outdir     = "~/shiny-concurrency/shiny-server-pro/4_json/output_10_mysql_001usr_4thr_100-090-40_2min_net/proxy/",
                       parameters = NA,
                       command    = "ls a2 b2 c2")
fileListResult <- c("profile_0_0.txt", "profile_0_1.txt", "profile_0_2.txt", "profile_0_3.txt"
                    , "profile_1_0.txt", "profile_1_1.txt", "profile_1_2.txt")


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
# test_that(".getProxyOutFilename return the right pattern", {
#   simProxyOutLs <- SimProxyOutLs(simOutLs)
#   local({
#     list.files <- function(dir) {
#       "aaa"
#     }
#     list.files(simProxyOutLs$simOutLs[[1]]$outdir)
#   })
#   list.files(simProxyOutLs$simOutLs[[1]]$outdir)
#   expect
# })
# test_that(".buildFinalSimOutLs(simOutLs) works", {
#   simOutFinal.buildFinalSimOutLs(simOutLs)
#
#   expect
# })


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
