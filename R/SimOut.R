SimOut <- function(poll       ,
                   outdir     ,
                   parameters ,
                   command    ) {
  this <- as.list(match.call())
  class_name <- this[[1]]
  this[[1]]  <- NULL # remove the function name
  class(this) <- class_name
  this
}

report_gen <- function(sim) {
  report_path = '~/shiny-concurrency/reports/shiny-server-pro'
  report_template_name = "report.Rmd"
  report_tmp = file.path(report_path, "report.html")
  #createLoadTestReport(dir = report_path, name = report_template_name)
  report_template <- file.path(report_path, report_template_name)
  directory   = sim$outdir #'~/shiny-concurrency/shiny-server-pro/4_json/output_10_mysql_001usr_4thr_100-090-40_2min_net/'
  output = strsplit(directory, split = "/")[[1]][5]
  report_file = file.path( report_path, paste0('report_', output, '.html') )

  rmarkdown::render(report_template,
                    params = list(directory = directory))
  file.rename(report_tmp, report_file)
  list(file = file.path(report_file),
       simulatio = sim)
}

