context("Container")

cont_1 <- Container(name = "vigorous_einstein"
                    , hash = "AAAAAAAAAAAAA"
                    , port = 4449L)

test_that("Container works",{

  expected <-     list(name = "vigorous_einstein"
                       , hash = "AAAAAAAAAAAAA"
                       , port = 4449L)
  class(expected) <- "Container"

  expect_equal(
    as.list(cont_1)
    , expected
  )
})
