#' Page class: Click on an element
#'
#' The `click` function simulates a click on an element. It can either locate the element using a provided selector or by referencing an element previously located.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the click should be performed.
#'
#' @param selector (Optional) A character string representing the selector of the element.
#'   If provided, the element will be located using the selector. If not provided, the `elem_id` column from `page_df` will be used to reference a previously located element.
#'
#' @param button (Optional) A character string representing the button to use for the click.
#'   Possible values are "left", "right", or "middle". Defaults to "left".
#'
#' @param click_count (Optional) An integer representing the number of clicks to perform. Defaults to 1.
#'
#' @param delay (Optional) A float value representing the time to wait between mousedown and mouseup in milliseconds. Defaults to 0.
#'
#' @param force (Optional) A boolean value indicating whether to bypass the actionability checks. Defaults to false.
#'
#' @param modifiers (Optional) A list of modifier keys to press during the click.
#'   Possible values are "Alt", "Control", "Meta", and "Shift". If not specified, the currently pressed modifiers are used.
#'
#' @param no_wait_after (Optional) A boolean value indicating whether to wait for any subsequent navigations to happen.
#'   If set to true, it bypasses the waiting. Defaults to false.
#'
#' @param position (Optional) A dictionary specifying the x and y coordinates of the click relative to the top-left corner of the element's padding box.
#'   If not specified, some visible point of the element is used.
#'
#' @param timeout (Optional) A float value representing the maximum time in milliseconds for the click operation. Defaults to 30000 (30 seconds).
#'   Pass 0 to disable the timeout.
#'
#' @param trial (Optional) A boolean value indicating whether to perform the action or only perform the actionability checks without actually clicking.
#'   Defaults to false.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Perform a click using a selector
#' click(page_df, selector = "#myElement", button = "left", click_count = 2, delay = 100, force = TRUE, modifiers = c("Control", "Shift"), no_wait_after = TRUE, position = list(x = 10, y = 10), timeout = 5000, trial = TRUE)
#'
#' # Perform a click using a previously located element
#' page_df <- get_by_text(page_df, "Click Me")
#' click(page_df, button = "right")
#'
#' @importFrom dplyr mutate
#'
#' @export
click <- function(page_df, selector = NULL, index = 1, button = "left", click_count = 1, delay = 0, force = FALSE, modifiers = NULL, no_wait_after = FALSE, position = NULL, timeout = 30000, trial = FALSE) {
  if (is.null(selector)) {
    py_run(glue("{page_df$elem_id}[{page_df$id-1}].click(button='{button}', click_count={click_count}, delay={delay}, force={cbool(force)}, timeout={timeout})"))
  } else {
    py_run(glue("{page_df$page_id}.click('{selector}', button='{button}', click_count={click_count}, delay={delay}, force={cbool(force)}, timeout={timeout})"))
  }
  page_df
}


#' Page class: Fill input field
#'
#' The `fill` function fills an input field with the specified text. It can either locate the input field using a provided selector or by referencing an element previously located.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the input field should be filled.
#'
#' @param text A character string representing the text to fill in the input field.
#'
#' @param selector (Optional) A character string representing the selector of the input field.
#'   If provided, the input field will be located using the selector. If not provided, the `elem_id` column from `page_df` will be used to reference a previously located element.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Fill an input field using a selector
#' fill(page_df, "Hello, World!", selector = "#myInput")
#'
#' # Fill an input field using a previously located element
#' page_df <- get_by_role(page_df, "textbox")
#' fill(page_df, "Hello, World!")
#' %>%
#' @importFrom dplyr mutate
#'
#' @export
fill <- function(page_df, text, selector = NULL) {
  if (!is.null(selector)) {
    py_run(glue("{page_df$page_id}.fill('{selector}', '{text}')"))
  } else if ("elem_id" %in% names(page_df)) {
    py_run(glue("{page_df$elem_id}[[{page_df$id-1}}].fill('{text}')"))
  } else {
    stop("Error: An element must be located before using the fill() method or a selector must be provided")
  }
  page_df
}

#' Page class: Check a checkbox
#'
#' The `check` function checks a checkbox element. It can either locate the checkbox using a provided selector or by referencing an element previously located.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the checkbox should be checked.
#'
#' @param selector (Optional) A character string representing the selector of the checkbox.
#'   If provided, the checkbox will be located using the selector. If not provided, the `elem_id` column from `page_df` will be used to reference a previously located element.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Check a checkbox using a selector
#' check(page_df, selector = "#myCheckbox")
#'
#' # Check a checkbox using a previously located element
#' page_df <- get_by_role(page_df, "checkbox")
#' check(page_df)
#'
#' @importFrom dplyr mutate
#'
#' @export
check <- function(page_df, selector = NULL) {
  if (!is.null(selector)) {
    py_run(glue("{page_df$page_id}.check('{selector}')"))
  } else if ("elem_id" %in% names(page_df)) {
    py_run(glue("{page_df$elem_id}[[{page_df$id-1}}].check()"))
  } else {
    stop("Error: An element must be located before using the check() method or a selector must be provided")
  }
  page_df
}

#' Page class: Select an option from a dropdown
#'
#' The `select_option` function selects an option from a dropdown element. It can either locate the dropdown using a provided selector or by referencing an element previously located.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the dropdown should be selected.
#'
#' @param option A character string representing the option to select from the dropdown.
#'
#' @param selector (Optional) A character string representing the selector of the dropdown.
#'   If provided, the dropdown will be located using the selector. If not provided, the `elem_id` column from `page_df` will be used to reference a previously located element.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Select an option from a dropdown using a selector
#' select_option(page_df, "Option 1", selector = "#myDropdown")
#'
#' # Select an option from a dropdown using a previously located element
#' page_df <- get_by_role(page_df, "combobox")
#' select_option(page_df, "Option 2")
#'
#' @importFrom dplyr mutate
#'
#' @export
select_option <- function(page_df, option, selector = NULL) {
  if (!is.null(selector)) {
    py_run(glue("{page_df$page_id}.select_option('{selector}', '{option}')"))
  } else if ("elem_id" %in% names(page_df)) {
    py_run(glue("{page_df$elem_id}[[{page_df$id-1}}].select_option('{option}')"))
  } else {
    stop("Error: An element must be located before using the select_option() method or a selector must be provided")
  }
  page_df
}

#' Page class: Double-click an element
#'
#' The `dblclick` function performs a double click on an element. It can either locate the element using a provided selector or by referencing an element previously located.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the element should be double-clicked.
#'
#' @param selector (Optional) A character string representing the selector of the element.
#'   If provided, the element will be located using the selector. If not provided, the `elem_id` column from `page_df` will be used to reference a previously located element.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Double-click an element using a selector
#' dblclick(page_df, selector = "#myElement")
#'
#' # Double-click an element using a previously located element
#' page_df <- get_by_text(page_df, "Click Me")
#' dblclick(page_df)
#'
#' @importFrom dplyr mutate
#'
#' @export
dblclick <- function(page_df, selector = NULL) {
  if (!is.null(selector)) {
    py_run(glue("{page_df$page_id}.dblclick('{selector}')"))
  } else if ("elem_id" %in% names(page_df)) {
    py_run(glue("{page_df$elem_id}[[{page_df$id-1}}].dblclick()"))
  } else {
    stop("Error: An element must be located before using the dblclick() method or a selector must be provided")
  }
  page_df
}

#' Page class: Type text into an element
#'
#' The `type` function types text into an element. It can either locate the element using a provided selector or by referencing an element previously located.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the text should be typed.
#'
#' @param text A character string representing the text to type.
#'
#' @param selector (Optional) A character string representing the selector of the element.
#'   If provided, the element will be located using the selector. If not provided, the `elem_id` column from `page_df` will be used to reference a previously located element.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Type text into an element using a selector
#' type(page_df, "Hello, World!", selector = "#myElement")
#'
#' # Type text into an element using a previously located element
#' page_df <- get_by_role(page_df, "textbox")
#' type(page_df, "Hello, World!")
#'
#' @importFrom dplyr mutate
#'
#' @export
type <- function(page_df, text, selector = NULL) {
  if (!is.null(selector)) {
    py_run(glue("{page_df$page_id}.type('{selector}', '{text}')"))
  } else if ("elem_id" %in% names(page_df)) {
    py_run(glue("{page_df$elem_id}[{page_df$id - 1}].type('{text}')"))
  } else {
    stop("Error: An element must be located before using the type() method or a selector must be provided")
  }
  page_df
}

#' Page class: Press a key
#'
#' The `press` function simulates pressing a key on the keyboard. It can either locate the element using a provided selector or by referencing an element previously located.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the key press should be simulated.
#'
#' @param key A character string representing the key to press.
#'
#' @param selector (Optional) A character string representing the selector of the element.
#'   If provided, the element will be located using the selector. If not provided, the `elem_id` column from `page_df` will be used to reference a previously located element.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Press a key using a selector
#' press(page_df, "Enter", selector = "#myElement")
#'
#' # Press a key using a previously located element
#' page_df <- get_by_role(page_df, "textbox")
#' press(page_df, "Enter")
#'
#' @importFrom dplyr mutate
#'
#' @export
press <- function(page_df, key, selector = NULL) {
  if (!is.null(selector)) {
    py_run(glue("{page_df$page_id}.press('{selector}', '{key}')"))
  } else if ("elem_id" %in% names(page_df)) {
    py_run(glue("{page_df$elem_id}[{page_df$id - 1}].press('{key}')"))
  } else {
    stop("Error: An element must be located before using the press() method or a selector must be provided")
  }
  page_df
}

#' Page class: Set input files
#'
#' The `set_input_files` function sets the files to upload for an input type "file" element. It can either locate the element using a provided selector or by referencing an element previously located.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the input files should be set.
#'
#' @param files A character vector representing the file paths to upload.
#'
#' @param selector (Optional) A character string representing the selector of the element.
#'   If provided, the element will be located using the selector. If not provided, the `elem_id` column from `page_df` will be used to reference a previously located element.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Set input files using a selector
#' set_input_files(page_df, c("path/to/file1.txt", "path/to/file2.txt"), selector = "#myFileInput")
#'
#' # Set input files using a previously located element
#' page_df <- get_by_role(page_df, "file")
#' set_input_files(page_df, c("path/to/file1.txt", "path/to/file2.txt"))
#'
#' @importFrom dplyr mutate
#'
#' @export
set_input_files <- function(page_df, files, selector = NULL) {
  files <- paste(files, collapse = "', '")
  if (!is.null(selector)) {
    py_run(glue("{page_df$page_id}.set_input_files('{selector}', ['{files}'])"))
  } else if ("elem_id" %in% names(page_df)) {
    py_run(glue("{page_df$elem_id}[[{page_df$id-1}}].set_input_files(['{files}'])"))
  } else {
    stop("Error: An element must be located before using the set_input_files() method or a selector must be provided")
  }
  page_df
}

#' Page class: Set focus on an element
#'
#' The `focus` function sets focus on an element. It can either locate the element using a provided selector or by referencing an element previously located.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the focus should be set.
#'
#' @param selector (Optional) A character string representing the selector of the element.
#'   If provided, the element will be located using the selector. If not provided, the `elem_id` column from `page_df` will be used to reference a previously located element.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Set focus on an element using a selector
#' focus(page_df, selector = "#myElement")
#'
#' # Set focus on an element using a previously located element
#' page_df <- get_by_role(page_df, "textbox")
#' focus(page_df)
#'
#' @importFrom dplyr mutate
#'
#' @export
focus <- function(page_df, selector = NULL) {
  if (!is.null(selector)) {
    py_run(glue("{page_df$page_id}.focus('{selector}')"))
  } else if ("elem_id" %in% names(page_df)) {
    py_run(glue("{page_df$elem_id}[[{page_df$id-1}}].focus()"))
  } else {
    stop("Error: An element must be located before using the focus() method or a selector must be provided")
  }
  page_df
}

#' Page class: Drag and drop an element
#'
#' The `drag_to` function performs a drag and drop operation from the source element to the target element. It can either locate the elements using provided selectors or by referencing elements previously located.
#'
#' @param page_df A data frame containing page information, including the `page_id` column.
#'   This data frame is used to identify the page object where the drag and drop operation should be performed.
#'
#' @param to_elem_id A character string representing the `elem_id` of the target element.
#'
#' @param selector (Optional) A character string representing the selector of the source element.
#'   If provided, the source element will be located using the selector. If not provided, the `elem_id` column from `page_df` will be used to reference a previously located element.
#'
#' @return The updated `page_df` data frame.
#'
#' @examples
#' # Create a page_df data frame
#' page_df <- data.frame(page_id = "my_page")
#'
#' # Drag and drop an element using selectors
#' drag_to(page_df, to_elem_id = "myTargetElement", selector = "#mySourceElement")
#'
#' # Drag and drop an element using previously located elements
#' page_df <- get_by_text(page_df, "Drag Me")
#' page_df <- get_by_text(page_df, "Drop Here")
#' drag_to(page_df, to_elem_id = page_df$elem_id[2])
#'
#' @importFrom dplyr mutate
#'
#' @export
drag_to <- function(page_df, to_elem_id, selector = NULL) {
  if (!is.null(selector)) {
    py_run(glue("{page_df$page_id}.locator('{selector}').drag_to({page_df$page_id}.locator('{to_elem_id}'))"))
  } else if ("elem_id" %in% names(page_df)) {
    py_run(glue("{page_df$elem_id}[[{page_df$id-1}}].drag_to({page_df$page_id}.locator('{to_elem_id}'))"))
  } else {
    stop("Error: An element must be located before using the drag_to() method or a selector must be provided")
  }
  page_df
}

#' @export
wait_for <- function(page_df, selector, state = c("attached", "detached", "visible", "hidden")) {

  if ("elem_id" %in% names(page_df)) {
    py_run(glue("{page_df$elem_id}[{page_df$id-1}].wait_for('{state}')"))
  } else {
    stop("Error: An element must be located before using the drag_to() method or a selector must be provided")
  }
  page_df
}

#' @export
get_all_attributes <- function(page_df) {

  if ("elem_id" %in% names(page_df)) {
    py_run(glue("el_attrs = {page_df$elem_id}[{page_df$id-1}].evaluate('el => el.getAttributeNames()');attr = [{page_df$elem_id}[{page_df$id-1}].get_attribute(name) for name in el_attrs]\n"))
  } else {
    stop("Error: An element must be located before using the drag_to() method or a selector must be provided")
  }
  attrs <- py$attr
  names(attrs) <- py$el_attrs

  bind_cols(page_df %>% rename(elem_index = id), as_tibble(as.list(attrs)))
}
