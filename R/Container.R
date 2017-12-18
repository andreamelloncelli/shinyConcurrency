# This class keeps information about a running docker container.

Container <- function(name       ,
                      hash       ,
                      port       ) {
  this <- list(name = name,
               hash = hash,
               port = port)
  class_name <- "Container"
  class(this) <- class_name
  this
}
