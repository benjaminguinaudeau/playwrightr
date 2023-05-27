
generate_unique_id <- function(length = 10) {
  sample_id <- paste(sample(c(0:9, letters, LETTERS), length, replace = TRUE), collapse = "")
  return(paste0("id_", sample_id))
}


py_run <- function(str, .envir = parent.frame()) {
  reticulate::py_run_string(glue::glue(str, .envir = .envir))
}

#' Launches a Playwright browser instance
#'
#' This function launches a Playwright browser instance and returns a tibble
#' containing the ID of the browser. The browser instance can be used to create
#' new browser contexts and perform various actions.
#'
#' @param headless Whether to run the browser in headless mode. Default is \code{TRUE}.
#' @param executable_path Path to a browser executable to run instead of the bundled one. If \code{NULL},
#'   the bundled browser will be used. Default is \code{NULL}.
#' @param args Additional arguments to pass to the browser instance. Default is \code{NULL}.
#' @param proxy Proxy settings for all requests. Default is \code{NULL}.
#' @param slow_mo Slows down Playwright operations by the specified amount of milliseconds. Useful for debugging.
#'   Default is \code{NULL}.
#' @param timeout Maximum time in milliseconds to wait for the browser instance to start. Default is 30000 (30 seconds).
#'   Pass 0 to disable timeout.
#'
#' @return A tibble containing the ID of the launched browser.
#'
#' @examples
#' browser <- browser_launch()
#'
#' @importFrom glue glue
#' @importFrom purrr map_chr
#' @importFrom tibble tibble
#'
browser_launch <- function(headless = TRUE, executable_path = NULL, args = NULL, proxy = NULL, slow_mo = NULL, timeout = 30000) {
  browser_id <- generate_unique_id()
  launch_args <- list()

  if (!is.null(args)) {
    launch_args[["args"]] <- args
  }

  if (!is.null(executable_path)) {
    launch_args[["executablePath"]] <- executable_path
  }

  if (!is.null(proxy)) {
    launch_args[["proxy"]] <- proxy
  }

  if (!is.null(slow_mo)) {
    launch_args[["slowMo"]] <- slow_mo
  }

  launch_args_str <- paste(purrr::map_chr(launch_args, .f = ~paste0(.x[1], "=", .x[2])), collapse = ", ")

  py_run(glue("{browser_id} = p.chromium.launch(headless={to_title_string(headless)}, {launch_args_str})"))
  tibble::tibble(browser_id = browser_id)
}
