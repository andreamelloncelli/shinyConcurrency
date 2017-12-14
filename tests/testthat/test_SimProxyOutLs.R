context("SimulationProxy")

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

test_that("toSimOut produce a single SimOut", {

})
