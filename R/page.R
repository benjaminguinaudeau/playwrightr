#' Page class: Create a new page object
#'
#' The `new_page` function creates a new page object within a web browser session using the provided `browser_df` data frame.
#'
#' @param browser_df A data frame containing browser information, including the `browser_id` column.
#'   This data frame is used to identify the browser session in which the new page object will be created.
#'
#' @return A tibble (data frame) with two columns:
#'   \describe{
#'     \item{browser_id}{The `browser_id` value extracted from the `browser_df` data frame.}
#'     \item{page_id}{A newly generated unique identifier for the created page object.}
#'   }
#'
#' @examples
#' # Create a browser_df data frame
#' browser_df <- data.frame(browser_id = "my_browser")
#'
#' # Create a new page using the browser_df
#' new_page(browser_df)
#'
#' @import tibble
#'
#' @note
#'   The `generate_unique_id` function used within `new_page` is not defined in the provided code snippet.
#'   Please ensure that it is defined elsewhere in your code or available as part of a package you have loaded.
#'
#' @export
new_page <- function(browser_df) {
  browser_id <- browser_df$browser_id
  page_id <- generate_unique_id()
  py_run("{page_id} = {browser_id}.new_page()")
  tibble::tibble(browser_id = browser_id, page_id = page_id)
}

#' Page class: Close a page object
#'
#' The `close_page` function closes a page object within a web browser session using the provided `page_df` data frame.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object that needs to be closed.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Close the page using the page_df
#' close_page(page_df)
#'
#'
#' @export
close_page <- function(page_df) {
  py_run("{{page_df$page_id}}.close()")
}
