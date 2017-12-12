context("Simulation")


test_that("simulate_cmd works",{
  sim <- Simulation(id = "30",
                    app = "shinyTest",
                    concurrency = "1",
                    srv_conf = "100-090-40_net",
                    duration = "180sec",
                    time_monitor = 30)

  simulate_cmd = simulate_cmd(sim)

  expect_equal(
    simulate_cmd,
    paste0(
      "cd ~/shiny-concurrency/shiny-server-pro/4_json;",
      " rm -f output_30_shinyTest_1usr_100-090-40_net_180sec/*;",
      " mkdir -p output_30_shinyTest_1usr_100-090-40_net_180sec;",
      " ~/shiny-concurrency/proxyrec playback",
      " --target 'http://ec2-52-201-221-45.compute-1.amazonaws.com:3838/shinyTest/'",
      " --outdir output_30_shinyTest_1usr_100-090-40_net_180sec --concurrency 1 ",
      " --duration '180sec' ../../tests/4_json/app-recording.txt &"
    )
  )

})
