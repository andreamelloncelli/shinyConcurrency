context("SimProxyOutLs")

# data --------------------------------------------------------------------

wd <- "~/shiny-concurrency/shiny-server-pro/4_json/output_10_mysql_001usr_4thr_100-090-40_2min_net"

simOut1 <- SimOut(poll       = NA,
                  outdir     = "~/shiny-concurrency/shiny-server-pro/4_json/output_10_mysql_001usr_4thr_100-090-40_2min_net/1",
                  parameters = NA,
                  command    = "ls a b c")
fileList1 <- paste(sep = "/"
                   , simOut1$outdir
                   , c("profile_0_0.txt", "profile_0_1.txt", "profile_0_2.txt", "profile_0_3.txt"))

simOut2 <- SimOut(poll       = NA,
                  outdir     = "~/shiny-concurrency/shiny-server-pro/4_json/output_10_mysql_001usr_4thr_100-090-40_2min_net/2",
                  parameters = NA,
                  command    = "ls a2 b2 c2")
fileList2 <- paste(sep = "/"
                   , simOut2$outdir
                   , c("profile_0_0.txt", "profile_0_1.txt", "profile_0_2.txt", "profile_0_3.txt"
                       , "profile_0_4.txt", "profile_0_5.txt", "profile_0_6.txt"))

simOutLs <- list(simOut1, simOut2)

fileListToParse <- list(fileList1, fileList2)
fileListToParseFlat <- flatten(fileListToParse)

simOutResult <- SimOut(poll       = NA,
                       outdir     = "~/shiny-concurrency/shiny-server-pro/4_json/output_10_mysql_001usr_4thr_100-090-40_2min_net/proxy",
                       parameters = NA,
                       command    = "ls a b c")
fileListResult <- paste(sep = "/"
                        , simOutResult$outdir
                        , c("profile_0_0.txt", "profile_0_1.txt", "profile_0_2.txt", "profile_0_3.txt"
                            , "profile_1_0.txt", "profile_1_1.txt", "profile_1_2.txt", "profile_1_3.txt"
                            , "profile_1_4.txt", "profile_1_5.txt", "profile_1_6.txt"))

# mock --------------------------------------------------------------------

fake_list.files <- function(path, ..., full.names) {
  if (full.names != TRUE)   stop("mock error")
  if (path== simOut1$outdir) return(fileList1)
  if (path== simOut2$outdir) return(fileList2)
  if (path== simOut3$outdir) return(fileListResult)
  stop("mock error")
}

fake_file.rename <- function(from, to) {
  class(from)
  if (all(any(from %in% fileList1
              , from %in% fileList2)
          , to %in% fileListResult)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

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

test_that("listSimOutFiles return the right list", {
  simProxyOutLs <- SimProxyOutLs(simOutLs)

  with_mock(
    `base::list.files` = fake_list.files
    , files <- listSimOutFiles.SimProxyOutLs(simProxyOutLs)
  )
  expect_equal(files
               , fileListToParseFlat)
})

test_that("moveFiles satisfy mocks", {
  simProxyOutLs <- SimProxyOutLs(simOutLs)
  # simFileLs     <- map(fileListToParseFlat, SimFile)

  with_mock(
    `base::list.files`    = fake_list.files
    , `base::file.rename` = fake_file.rename
    , files <- moveFiles.SimProxyOutLs(simProxyOutLs)
  )
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
  expect_equal(simOut$outdir, simOutResult$outdir)
  expect_equal(simOut$parameters, NA)
  expect_equal(simOut$command, simOutResult$command)
})
