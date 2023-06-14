
generate_unique_id <- function(length = 10) {
  sample_id <- paste(sample(c(0:9, letters, LETTERS), length, replace = TRUE), collapse = "")
  return(paste0("id_", sample_id))
}

py_exists <- function(str) str %in% names(py)

py_run <- function(str, .envir = parent.frame()) {
  reticulate::py_run_string(glue::glue(str, .envir = .envir))
}

cbool <- stringr::str_to_title
