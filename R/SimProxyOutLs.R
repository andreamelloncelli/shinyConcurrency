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
  this <- SimOutLs
  class_name <- "SimProxyOutLs"
  class(this) <- class_name
  this
}

# SimOut ------------------------------------------------------------------

ToSimOut.SimProxyOutLs <- function() {}
