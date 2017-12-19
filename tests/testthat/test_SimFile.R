context("SimFile")


wd <- "~/shiny-concurrency/shiny-server-pro/4_json/output_10_mysql_001usr_4thr_100-090-40_2min_net"

inFile1  <- paste0(wd, "/1/profile_0_0.txt")
outFile1 <- paste0(wd, "/proxy/profile_1_0.txt")


inFile2  <- paste0(wd, "/2/profile_0_3.txt")
outFile2 <- paste0(wd, "/proxy/profile_2_3.txt")


# public ------------------------------------------------------------------

test_that("SimFile read file1 path correctly", {
  sf <- SimFile(inFile1)

  expect_s3_class(sf, "SimFile")
  expect_equal(sf$path     , wd)
  expect_equal(sf$id_thread, "1")
  expect_equal(sf$id_rep   , "0")
})
test_that("SimFile read file2 path correctly", {
  sf <- SimFile(inFile2)

  expect_s3_class(sf, "SimFile")
  expect_equal(sf$path     , wd)
  expect_equal(sf$id_thread, "2")
  expect_equal(sf$id_rep   , "3")
})
test_that("SimFile contains the old full path", {
  sf <- SimFile(inFile2)

  expect_equal(sf$old_path   , inFile2)
})

test_that("inFile1 moving", {
  simFile <- SimFile(inFile2)

  expect_equal(getOutFile.SimFile(simFile)
               , outFile2)
})

# mv ----------------------------------------------------------------------

test_that("mv works", {
  simFile <- SimFile(inFile2)

  with_mock(
    `base::file.rename` = fake_file.rename <- function(from, to) {
      cond <- any((from == inFile1) && (to == outFile1)
                  , (from == inFile2) && (to == outFile2))
      if (! cond) stop("file.rename error in mock")
      TRUE
    }
    , moveFile.SimFile(simFile)
  )
})
# private -----------------------------------------------------------------


