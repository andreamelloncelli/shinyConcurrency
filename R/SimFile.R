
# constructor -------------------------------------------------------------

SimFile <- function(inFile) {

  this <- .getFileStructure(inFile)
  class(this) <- "SimFile"
  this

}


# outFile -----------------------------------------------------------------

getOutFile.SimFile <- function(this) {

  paste0(this$path, "/proxy/profile_", this$id_thread, "_", this$id_rep, ".txt")
}

.getFileStructure  <- function(file) {
  pattern <- "(.*)/([^/]*)/profile_([[:digit:]]*)_([[:digit:]]*).txt"

  id_fake <- gsub(pattern
                  , replacement = "\\3"
                  , x = file)
  if (id_fake != "0") stop("id_fake != '0'")


  list(path        = gsub(pattern
                          , replacement = "\\1"
                          , x = file)
       , id_thread = gsub(pattern
                          , replacement = "\\2"
                          , x = file)
       , id_rep    = gsub(pattern
                          , replacement = "\\4"
                          , x = file)
       , old_path  = file)
}


# mv ----------------------------------------------------------------------

moveFile.SimFile <- function(this) {
  file.rename(from = this$old_path
              , to = getOutFile.SimFile(this))

}

