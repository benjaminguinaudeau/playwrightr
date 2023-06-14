#' Page class: Capture a screenshot
#'
#' The `screenshot` function captures a screenshot of the current page within a web browser session and saves it to the specified `path`.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object for which the screenshot should be captured.
#'
#' @param path A character string representing the path where the screenshot should be saved.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Capture a screenshot using the page_df and save it to the specified path
#' screenshot(page_df, "path/to/save/screenshot.png")
#'
#'
#' @export
screenshot <- function(page_df, path) {
  py_run(glue("{{page_df$page_id}}.screenshot(path='{{path}}')"))
  page_df
}

#' Page class: Get the current page URL
#'
#' The `get_url` function retrieves the current URL of the page object within a web browser session.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object from which the URL should be retrieved.
#'
#' @return A character string representing the current URL of the page.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Get the current page URL using the page_df
#' get_url(page_df)
#'
#'
#' @export
get_url <- function(page_df) {
  py_run(glue("url = {{page_df$page_id}}.url"))
  py$url
}

#' Page class: Get the page title
#'
#' The `get_title` function retrieves the title of the page object within a web browser session.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object from which the title should be retrieved.
#'
#' @return A character string representing the title of the page.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Get the page title using the page_df
#' get_title(page_df)
#'

#'
#' @export
get_title <- function(page_df) {
  title <- py_run(glue("{{page_df$page_id}}.title()"))
  title
}

#' Page class: Execute JavaScript code on the page
#'
#' The `execute_script` function executes the specified JavaScript code on the page object within a web browser session.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object on which the JavaScript code should be executed.
#'
#' @param script A character string representing the JavaScript code to execute on the page.
#'
#' @return The result of executing the JavaScript code on the page.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Execute JavaScript code on the page using the page_df
#' execute_script(page_df, "alert('Hello, World!');")
#'
#'
#' @export
execute_script <- function(page_df, script) {
  result <- py_run(glue("{{page_df$page_id}}.execute_script('{{script}}')"))
  result
}

#' Page class: Get the page content
#'
#' The `get_content` function retrieves the content of the page object within a web browser session.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object from which the content should be retrieved.
#'
#' @return An XML document representing the content of the page.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Get the page content using the page_df
#' get_content(page_df)
#'

#' @import xml2
#'
#' @export
get_content <- function(page_df) {
  py_run(glue("content  = {{page_df$page_id}}.content()"))
  xml2::read_html(py$content)
}
