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
#' @export
browser_launch <- function(browser = "chromium",
                           headless = TRUE,
                           timeout = 30000,
                           user_data_dir = NULL,
                           channel = NULL,
                           user_agent = NULL) {
  browser_id <- generate_unique_id()
  launch_args <- list()

  if (!is.null(user_agent)) {
    launch_args[["user_agent"]] <- user_agent
  }
  if (!is.null(user_data_dir)) {
    launch_args[["user_data_dir"]] <- user_data_dir
  } else {
    launch_args[["user_data_dir"]] <- tempdir()
  }
  if(browser == "chromium" & !is.null(channel)){
    # "chrome", "chrome-beta", "chrome-dev", "chrome-canary", "msedge", "msedge-beta", "msedge-dev", "msedge-canary"
    launch_args[["channel"]] <- channel
  }

  launch_args_str <- paste(purrr::imap_chr(launch_args, ~paste0(.y, " = \"", .x, '"')), collapse = ", ")

  py_run(glue("{browser_id} = p.{browser}.launch_persistent_context(headless={stringr::str_to_title(headless)}, {launch_args_str})"))

  page_id <- generate_unique_id()
  py_run("{page_id} = {browser_id}.pages[0]")

  tibble::tibble(browser_id = browser_id, page_id)
}
