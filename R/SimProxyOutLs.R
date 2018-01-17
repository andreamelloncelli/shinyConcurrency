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
  purrr::flatten(fileList)
}

## not tested
moveFiles.SimProxyOutLs <- function(this) {
  fileLs <- listSimOutFiles.SimProxyOutLs(this)
  simFileLs <- map(.x = fileLs
                   , .f = SimFile)
  map(.x = simFileLs
      , .f = moveFile.SimFile)
}

# toSimOut ------------------------------------------------------------------

ToSimOut.SimProxyOutLs <- function(this) {
  firstSim <- this$simOutLs[[1]]

  outdir = gsub(pattern = "/1$"
                , replacement = "/proxy"
                , x = firstSim$outdir)

  simOut <- SimOut(poll         = NA
                   , outdir     = outdir
                   , parameters = NA
                   , command    = firstSim$command)
  simOut
}
