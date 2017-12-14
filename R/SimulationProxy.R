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


# url ---------------------------------------------------------------------

app_url.SimulationProxy     <- function(sim)
  paste0("http://", sim$shiny_server,":", sim$shiny_port, "/app/", sim$app)

frame_url.SimulationProxy   <- function(sim, frame)
  paste0("http://", sim$shiny_server,":", sim$shiny_port, "/", frame, "/")

# simulationLs ------------------------------------------------------------

simulationLs_get.SimulationProxy <- function(sim, containerLs) {
  mapper <- function(container, sim) {
    sim_out <- Simulation(id = sim$id,
                        app = container$name,
                        concurrency = "1",
                        srv_conf = sim$srv_conf,
                        duration = sim$duration,
                        time_monitor = sim$time_monitor,
                        shiny_server = sim$shiny_server,
                        shiny_port   = as.character(container$port))
    sim_out
  }
  lapply(containerLs, mapper, sim = sim)
}

simulationLs_run.SimulationProxy <- function(sim, containerLs) {
  simulationLs <- simulationLs_get.SimulationProxy(sim, containerLs)
  lapply(simulationLs, simulate)
}

