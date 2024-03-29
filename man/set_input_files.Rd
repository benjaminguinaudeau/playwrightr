% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/actions.R
\name{set_input_files}
\alias{set_input_files}
\title{Page class: Set input files}
\usage{
set_input_files(page_df, files, selector = NULL)
}
\arguments{
\item{page_df}{A data frame containing page information, including the \code{page_id} column.
This data frame is used to identify the page object where the input files should be set.}

\item{files}{A character vector representing the file paths to upload.}

\item{selector}{(Optional) A character string representing the selector of the element.
If provided, the element will be located using the selector. If not provided, the \code{elem_id} column from \code{page_df} will be used to reference a previously located element.}
}
\value{
The updated \code{page_df} data frame.
}
\description{
The \code{set_input_files} function sets the files to upload for an input type "file" element. It can either locate the element using a provided selector or by referencing an element previously located.
}
\examples{
# Create a page_df data frame
page_df <- data.frame(page_id = "my_page")

# Set input files using a selector
set_input_files(page_df, c("path/to/file1.txt", "path/to/file2.txt"), selector = "#myFileInput")

# Set input files using a previously located element
page_df <- get_by_role(page_df, "file")
set_input_files(page_df, c("path/to/file1.txt", "path/to/file2.txt"))

}
