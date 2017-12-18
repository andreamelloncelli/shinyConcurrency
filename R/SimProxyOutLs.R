#' SimProxyOutLs
#'
#' SimProxyOutLs contains a list of SimOut resulting from a `simulation` of `simulationShiny`'
#' @param SimOutLs list of SimOut objects
#'
#' @return a SimProxyOutLs object
#' @export
#'
#' @examples
SimProxyOutLs <- function(SimOutLs) {
  this <- list(simOutLs = SimOutLs
               , finalSimOut = NULL)
  class_name <- "SimProxyOutLs"
  class(this) <- class_name
  this
}

# SimOut ------------------------------------------------------------------

ToSimOut.SimProxyOutLs <- function(this) {
  firstSim <- this$simOutLs[[1]]

  simOut <- SimOut(poll         = NA
                   , outdir     = ""
                   , parameters = NA
                   , command    = firstSim$command)
  simOut
}
