context("Simulation")

sim_1 <- Simulation(id = "30",
                  app = "shinyTest",
                  concurrency = "1",
                  srv_conf = "100-090-40_net",
                  duration = "180sec",
                  time_monitor = 30,
                  shiny_server = "ec2-52-201-221-45.compute-1.amazonaws.com",
                  shiny_port   = "3838",
                  rectest      = "../../tests/5_json/app-recording.txt")
sim_1_cmd <- paste0("cd ~/shiny-concurrency/shiny-server-pro/4_json;\n",
                    " rm -f output_30_shinyTest_1usr_100-090-40_net_180sec/*;\n",
                    " mkdir -p output_30_shinyTest_1usr_100-090-40_net_180sec;\n",
                    " ~/shiny-concurrency/proxyrec playback",
                    " --target 'http://ec2-52-201-221-45.compute-1.amazonaws.com:3838/shinyTest/'",
                    " --outdir output_30_shinyTest_1usr_100-090-40_net_180sec --concurrency 1 ",
                    " --duration '180sec' ../../tests/5_json/app-recording.txt &")
sim_1_outdir <- "~/shiny-concurrency/shiny-server-pro/4_json/output_30_shinyTest_1usr_100-090-40_net_180sec"


test_that("simulate_cmd works",{

  simulate_cmd <- simulate_cmd(sim_1)

  expect_equal(
    simulate_cmd,
    sim_1_cmd
  )

})

test_that("simulate_out works", {
  expected = list(poll       = NA,
                  outdir     = sim_1_outdir,
                  parameters = NA,
                  command    = sim_1_cmd)

  out <- simulate_out(sim_1)

  expect_equal(out$outdir, expected$outdir)
  expect_equal(out, expected)
})

