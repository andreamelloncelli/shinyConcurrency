Simulation <- function(id,
                      app,
                      concurrency,
                      srv_conf,
                      duration,
                      time_monitor) {
  this <- list(id           = id,
               app          = app,
               concurrency  = concurrency,
               srv_conf     = srv_conf,
               duration     = duration,
               time_monitor = time_monitor)
  class(this) <- "Simulation"
  this
}

simulate_cmd <- function(p) {
  outdir <- paste0("output_", p$id, "_", p$app, "_", p$concurrency, "usr_", p$srv_conf, "_", p$duration)
  # if (!dir.exists(outdir)) dir.create(outdir)
  outpath <- "~/shiny-concurrency/shiny-server-pro/4_json"
  command <- paste0("cd ", outpath, "; ",
                    "rm -f ", outdir, "/*; ",
                    "mkdir -p ", outdir, "; ",
                    "~/shiny-concurrency/proxyrec playback ",
                    "--target 'http://ec2-52-201-221-45.compute-1.amazonaws.com:3838/", p$app, "/' ",
                    "--outdir ", outdir,
                    " --concurrency ", p$concurrency, "  --duration '", p$duration, "' ",
                    "../../tests/4_json/app-recording.txt &")
}
