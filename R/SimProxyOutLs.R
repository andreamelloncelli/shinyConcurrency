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
  # list(c("profile_0_0.txt", "profile_0_1.txt", "profile_0_2.txt", "profile_0_3.txt")
  #      , c("profile_0_0.txt", "profile_0_1.txt", "profile_0_2.txt"))
  list_files_from <- function(simOut) {list.files(simOut$outdir)}
  fileList <- map(this$simOutLs, list_files_from  )
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
