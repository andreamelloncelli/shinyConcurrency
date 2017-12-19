
wd <- "~/shiny-concurrency/shiny-proxy-tests-for-code"
setwd(wd)
system("make clean && make do")
outDir    <- file.path(wd, "out")

create_simOut <- function(n) {
  SimOut(poll       = NA,
         outdir     = file.path(outDir, as.character(n)),
         parameters = NA,
         command    = "ls a b c")
}


simOutLs  <- map(.x = 1:10
                 , .f = create_simOut)

proxyOutLs <- SimProxyOutLs(simOutLs)

print(listSimOutFiles.SimProxyOutLs(proxyOutLs))
moveFiles.SimProxyOutLs(proxyOutLs)
system("ls -l out")
system("ls -l out/*")
