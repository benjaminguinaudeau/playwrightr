#' get_browser_endpoint
#' @export
get_browser_endpoint <- function(debug_port = 9222){
  jsonlite::fromJSON(rawToChar(httr::GET(glue::glue('http://localhost:{debug_port}/json/version'))[["content"]]))[["webSocketDebuggerUrl"]]
}

#' launch_chrome_mac
#' @export
launch_chrome_mac <- function(debug_port = 9222, data_dir = here::here()){
  system(glue::glue("/Applications/Google\\\ Chrome.app/Contents/MacOS/Google\\\ Chrome --remote-debugging-port={debug_port} --no-first-run --no-default-browser-check --user-data-dir={data_dir} &"))
}

#' launch_chrome_linux
#' @export
launch_chrome_linux <- function(debug_port = 9222, data_dir = here::here(), headless = T){
  headless <- ifelse(headless, " --headless ", " ")
  system(glue::glue("google-chrome --remote-debugging-port={debug_port} --no-first-run --no-default-browser-check --user-data-dir={data_dir}{}headless}&"))
}

#' get_tabs
#' @export
get_tabs <- function(debug_port = 9222){
  jsonlite::fromJSON(rawToChar(httr::GET(glue::glue('http://localhost:{debug_port}/json'))[["content"]]))
}

#' browser
#' @export
browser <- R6::R6Class(
  "browser",
  public = list(
    debug_port = NULL,
    endpoint = NULL,
    pages = NULL,
    initialize = function(debug_port = 9222){
      reticulate::source_python("https://raw.githubusercontent.com/benjaminguinaudeau/playwrightr/master/page.py")
      self$debug_port = debug_port
      self$endpoint <- get_browser_endpoint(debug_port = debug_port)
    },
    list_tabs = function(){
      get_tabs(debug_port = self$debug_port) %>%
        dplyr::filter(type == "page") %>%
        .[c("title", "url")]
    },
    execute = function(title = "", script = ""){
      title %>%
        purrr::map(~{
          out <- py$page(endpoint = self$endpoint, title = .x, script = script)
          if(!"source" %in% names(out)) "Page not found, verify endpoint and tab title"
          out$source
        })
    }
  )
)
