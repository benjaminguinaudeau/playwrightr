get_by_generic <- function(page_df, attr, method = "get_by_role") {

  page_df <- page_df %>%
    distinct(browser_id, page_id)

  elem_id <- generate_unique_id()
  py_run(glue("{elem_id} = {page_df$page_id}.{method}('{attr}').all()"))

  if(length(py[[elem_id]])){
    page_df %>%
      get_elem_ids(elem_id, ids = 1:length(py[[elem_id]]))
  } else {
    page_df %>%
      mutate(elem_id = elem_id,
             id = NA_real_)
  }
}

get_elem_ids <- function(page_df, elem_id, ids = NULL){
  if(is.null(ids)){
    py_run(glue("list_index = []\nfor a, b in enumerate({elem_id}.all()):\n  list_index.append(a)"))
    ids <- py$list_index
  }

  page_df %>%
    dplyr::mutate(elem_id = elem_id,
                  id = list(ids)) %>%
    tidyr::unnest(id)
}


#' Page class: Get element by role
#'
#' The `get_by_role` function retrieves an element with the specified role from the page object within a web browser session.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object from which the element should be retrieved.
#'
#' @param role A character string representing the role of the element to retrieve.
#'
#' @return The updated `page_df` data frame with an additional `elem_id` column containing the identifier of the retrieved element.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Retrieve an element by role using the page_df
#' get_by_role(page_df, "button")
#'
#' @importFrom dplyr mutate
#'
#' @export
get_by_role <- function(page_df, role) get_by_generic(page_df = page_df, attr = role, method = "get_by_role")


#' Page class: Get element by text
#'
#' The `get_by_text` function retrieves an element with the specified text from the page object within a web browser session.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object from which the element should be retrieved.
#'
#' @param text A character string representing the text of the element to retrieve.
#'
#' @return The updated `page_df` data frame with an additional `elem_id` column containing the identifier of the retrieved element.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Retrieve an element by text using the page_df
#' get_by_text(page_df, "Click Me")
#'
#' @importFrom dplyr mutate
#'
#' @export
get_by_text <- function(page_df, text) get_by_generic(page_df = page_df, attr = text, method = "get_by_text")


#' Page class: Get element by label
#'
#' The `get_by_label` function retrieves an element with the specified label from the page object within a web browser session.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object from which the element should be retrieved.
#'
#' @param label A character string representing the label of the element to retrieve.
#'
#' @return The updated `page_df` data frame with an additional `elem_id` column containing the identifier of the retrieved element.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Retrieve an element by label using the page_df
#' get_by_label(page_df, "Email")
#'
#' @importFrom dplyr mutate
#'
#' @export
get_by_label <- function(page_df, label) get_by_generic(page_df = page_df, attr = label, method = "get_by_label")

#' @export
get_by_alt_text <- function(page_df, text) get_by_generic(page_df = page_df, attr = text, method = "get_by_alt_text")

#' @export
get_by_placeholder <- function(page_df, text) get_by_generic(page_df = page_df, attr = text, method = "get_by_placeholder")

#' @export
get_by_test_id <- function(page_df, test_id) get_by_generic(page_df = page_df, attr = test_id, method = "get_by_test_id")

#' @export
get_by_title <- function(page_df, text) get_by_generic(page_df = page_df, attr = text, method = "get_by_title")


#' Page class: Get element by CSS selector
#'
#' The `get_by_selector` function retrieves an element with the specified CSS selector from the page object within a web browser session.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object from which the element should be retrieved.
#'
#' @param selector A character string representing the CSS selector of the element to retrieve.
#'
#' @return The updated `page_df` data frame with an additional `elem_id` column containing the identifier of the retrieved element.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Retrieve an element by CSS selector using the page_df
#' get_by_selector(page_df, "#myElement")
#'
#' @importFrom dplyr mutate
#'
#' @export
get_by_selector <- function(page_df, selector) {
  page_df <- page_df %>% distinct(browser_id, page_id)

  elem_id <- generate_unique_id()
  py_run(glue("{elem_id} = {page_df$page_id}.query_selector_all('{selector}')"))
  if(length(py[[elem_id]])){
    page_df %>%
      get_elem_ids(elem_id, ids = 1:length(py[[elem_id]]))
  } else {
    page_df %>%
      mutate(elem_id = elem_id,
             id = NA_real_)
  }
}








