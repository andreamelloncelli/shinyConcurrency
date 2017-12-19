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

.getProxyOutFilename <- function(filename) {

}

.buildFinalSimOutLs <- function(simOutLs) {

}

# listSimOutFiles ---------------------------------------------------------

listSimOutFiles.SimProxyOutLs <- function(this) {
  list_files_from <- function(simOut) {list.files(simOut$outdir, full.names = TRUE)}
  fileList <- map(this$simOutLs, list_files_from  )
}

## not tested
moveFiles.SimProxyOutLs <- function(this) {
  simFileLs <- listSimOutFiles.SimProxyOutLs(this)
  map(.x = simFileLs
      , .f = moveFile.SimFile)
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
