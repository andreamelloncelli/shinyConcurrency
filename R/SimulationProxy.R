SimulationProxy <- function(id,
                            app,
                            concurrency,
                            srv_conf,
                            duration,
                            time_monitor,
                            shiny_server,
                            shiny_port  ) {
  this <- list(id           = id,
               app          = app,
               concurrency  = concurrency,
               srv_conf     = srv_conf,
               duration     = duration,
               time_monitor = time_monitor,
               shiny_server = shiny_server,
               shiny_port   = shiny_port,
               outdir       = paste0("output_", id, "_", app,
                                     "_", concurrency, "usr_",
                                     srv_conf, "_", duration),
               # if (!dir.exists(outdir)) dir.create(outdir)
               outpath      = "~/shiny-concurrency/shiny-server-pro/4_json"
  )
  class(this) <- "SimulationProxy"
  this
}


app_url.SimulationProxy     <- function(sim)
  paste0("http://", sim$shiny_server,":", sim$shiny_port, "/app/", sim$app)

