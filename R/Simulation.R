Simulation <- function(id,
                       app,
                       concurrency,
                       srv_conf,
                       duration,
                       time_monitor,
                       shiny_server,
                       shiny_port,
                       outdir       = paste0("output_", id, "_", app,
                                             "_", concurrency, "usr_",
                                             srv_conf, "_", duration),
                       outpath      = "~/shiny-concurrency/shiny-server-pro/4_json") {
  this <- list(id           = id,
               app          = app,
               concurrency  = concurrency,
               srv_conf     = srv_conf,
               duration     = duration,
               time_monitor = time_monitor,
               shiny_server = shiny_server,
               shiny_port   = shiny_port,
               outdir       = outdir,
               # if (!dir.exists(outdir)) dir.create(outdir)
               outpath      = outpath
  )
  class(this) <- "Simulation"
  this
}

# functions ---------------------------------------------------------------

app_url     <- function(sim)
  paste0("http://", sim$shiny_server,":", sim$shiny_port, "/", sim$app)

simulate_cmd <- function(p) {
    paste0("cd ", p$outpath, ";\n ",
           "rm -f ", p$outdir, "/*;\n ",
           "mkdir -p ", p$outdir, ";\n ",
           "~/shiny-concurrency/proxyrec playback ",
           "--target '", app_url(p), "/' ",
           "--outdir ", p$outdir,
           " --concurrency ", p$concurrency, "  --duration '", p$duration, "' ",
           "../../tests/4_json/app-recording.txt &")
}

simulate_out <- function(sim) {
  list(poll       = NA,
       outdir     = file.path(sim$outpath, sim$outdir),
       parameters = NA, #parameters,
       command    = simulate_cmd(sim))
}

# side-effect-functions ---------------------------------------------------

simulate <- function(sim) {
  command <- simulate_cmd(sim)
  message("running: ", command)
  none <-
    system(command, inter = FALSE)
  simulate_out(sim)
}

simulate_polling <- function(p) {
  sim_out <- simulate(p)
  message("polling..")
  df <-
    shinyloadtest::poll(
      servers = paste0(p$shiny_server,":", p$shiny_port),
      appName = 'shinyTest',
      duration_sec = p$time_monitor,
      platform = 'ssp'
    )
  SimOut(poll         = df
         , outdir     = sim_out$outdir
         , parameters = sim_out$parameters
         , command    = sim_out$command)
}



