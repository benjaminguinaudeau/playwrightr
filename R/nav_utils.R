#' Page class: Go to a URL
#'
#' The `goto` function navigates the page object within a web browser session to the specified URL.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the navigation will occur.
#'
#' @param url A character string representing the URL to navigate to.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Navigate to a URL using the page_df
#' goto(page_df, "https://www.example.com")
#'
#'
#' @export
goto <- function(page_df, url) {
  py_run(glue("rqs = {{page_df$page_id}}.goto('{url}')"))
  page_df
}

#' Page class: Reload the current page
#'
#' The `reload` function reloads the current page within a web browser session.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object that needs to be reloaded.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Reload the page using the page_df
#' reload(page_df)
#'
#'
#' @export
reload <- function(page_df) {
  py_run(glue("{{page_df$page_id}}.reload()"))
  page_df
}

#' Page class: Go back in browser history
#'
#' The `go_back` function navigates the page object within a web browser session to the previous page in the browser history.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object for which the navigation should occur.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Go back in browser history using the page_df
#' go_back(page_df)
#'
#'
#' @export
go_back <- function(page_df) {
  py_run(glue("{{page_df$page_id}}.go_back()"))
  page_df
}

#' Page class: Go forward in browser history
#'
#' The `go_forward` function navigates the page object within a web browser session to the next page in the browser history.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object for which the navigation should occur.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Go forward in browser history using the page_df
#' go_forward(page_df)
#'
#'
#' @export
go_forward <- function(page_df) {
  py_run(glue("{{page_df$page_id}}.go_forward()"))
  page_df
}
