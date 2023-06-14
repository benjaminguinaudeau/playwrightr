#' Initialize Playwright with optional XVFB
#'
#' The `pw_init` function initializes Playwright and optionally starts XVFB if it has not been started already.
#'
#' @param use_xvfb A boolean value indicating whether to start XVFB using XVFBWrapper.
#'   If set to TRUE and XVFB has not been started already, XVFB will be started before initializing Playwright.
#'   If set to FALSE or if XVFB has already been started, XVFB will not be started.
#'
#' @importFrom reticulate import
#' @importFrom reticulate py_run_string
#'
#' @examples
#' # Initialize Playwright without XVFB
#' pw_init(use_xvfb = FALSE)
#'
#' # Initialize Playwright with XVFB
#' pw_init(use_xvfb = TRUE)
#'
#' @export
pw_init <- function(use_xvfb = TRUE) {
  if (use_xvfb && !exists("vdisplay")) {
    xlib <- import("xvfbwrapper")
    vdisplay <- xlib$Xvfb()
    vdisplay$start()
  }

  if (!py_exists("p")) {
    reticulate::py_run_string("from playwright.sync_api import sync_playwright")
    reticulate::py_run_string("p = sync_playwright().start()")
  }
}
