#' #' @export
#' pw_init <- function(){
#'   pw <- reticulate::import("playwright.sync_api")
#'   .GlobalEnv$pw___play <- pw$sync_playwright()$start()
#' }
#'
#' #' @export
#' pw_reset <- function(){
#'   pw <- reticulate::import("playwright.sync_api")
#'   try(.GlobalEnv$pw___play$stop())
#'   pw_init()
#' }
#'
#'
#' #' @export
#' new_browser <- function(name = "chromium", dev = "", headless = T, data_dir = tempfile()){
#'
#'   if(!exists("pw___play", .GlobalEnv)) pw_init()
#'
#'
#'   if(dev != ""){
#'     args <- list(c(devices$info[devices$name == dev][[1]], user_data_dir = data_dir, accept_downloads = TRUE, headless = headless))
#'   } else {
#'     args <- list(list(user_data_dir = data_dir, accept_downloads = TRUE, headless = headless))
#'   }
#'   if(name == "chrome") args[[1]]$channel <- "chrome"
#'   if(name == "msedge") args[[1]]$channel <- "msedge"
#'
#'
#'   fun <- switch(
#'     name,
#'     "chromium" = .GlobalEnv$pw___play$chromium$launch_persistent_context,
#'     "chrome" = .GlobalEnv$pw___play$chromium$launch_persistent_context,
#'     "msedge" = .GlobalEnv$pw___play$chromium$launch_persistent_context,
#'     "firefox" = .GlobalEnv$pw___play$firefox$launch_persistent_context,
#'     "webkit" = .GlobalEnv$pw___play$webkit$launch_persistent_context
#'   )
#'
#'   do.call(fun, args[[1]])
#'
#' }
