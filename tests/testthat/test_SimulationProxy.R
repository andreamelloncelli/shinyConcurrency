context("SimulationProxy")

# data --------------------------------------------------------------------

shiny_proxy <- "shiny-example.com"
#frame <- '    <iframe id="shinyframe" width="100%" src="/elated_carson/"></iframe>'

simP_1 <- SimulationProxy(id = "70",
                          app = "test_app",
                          concurrency = "2",
                          srv_conf = "100-090-40_net",
                          duration = "60sec",
                          time_monitor = 30,
                          shiny_server = shiny_proxy,
                          shiny_port   = "8080",
                          outpath      = "~/shiny-concurrency/shiny-server-pro/4_json")

appLs <- list("vigorous_einstein", "tidy_birkoff")
port_1 <- 4445L
port_2 <- 4446L

containerLs <- list(Container(name = appLs[[1]]
                              , hash = "AAAAAAAAAAAAA"
                              , port = port_1)
                    , Container(name = appLs[[2]]
                                 , hash = "AAAAAAAAAAAAA"
                                 , port = port_2))

sim_1 <- Simulation(id = "70",
                    app = "vigorous_einstein",
                    concurrency = "1",
                    srv_conf = "100-090-40_net",
                    duration = "60sec",
                    time_monitor = 30,
                    shiny_server = shiny_proxy,
                    shiny_port   = as.character(port_1),
                    outdir       = "1",
                    outpath      = "~/shiny-concurrency/shiny-server-pro/4_json")
sim_2 <- Simulation(id = "70",
                    app = "tidy_birkoff",
                    concurrency = "1",
                    srv_conf = "100-090-40_net",
                    duration = "60sec",
                    time_monitor = 30,
                    shiny_server = shiny_proxy,
                    shiny_port   = as.character(port_2),
                    outdir       = "2",
                    outpath      = "~/shiny-concurrency/shiny-server-pro/4_json")

# tests -------------------------------------------------------------------

test_that("frame_url works", {
  expect_equal(object = frame_url.SimulationProxy(simP_1, "vigorous_einstein")
               , expected = "http://shiny-example.com:8080/vigorous_einstein/")
})

# test_simulationLs -------------------------------------------------------

test_that("simulationLs_get.SimulationProxy works", {
  simulationLs <- simulationLs_get.SimulationProxy(simP_1, containerLs)

  sim <- simulationLs[[1]]
  container <- containerLs[[1]]

  expect_equal(sim$app, appLs[[1]])
  expect_equal(sim$concurrency , "1")
  expect_equal(sim$srv_conf , "100-090-40_net")
  expect_equal(sim$duration , simP_1$duration)
  expect_equal(sim$time_monitor , 30)
  expect_equal(sim$shiny_server , shiny_proxy)
  expect_equal(sim$shiny_port   , as.character(container$port))

  expect_equal(object = simulationLs
               , expected = list(sim_1, sim_2))

})
