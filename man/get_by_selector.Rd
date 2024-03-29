% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_utils.R
\name{get_by_selector}
\alias{get_by_selector}
\title{Page class: Get element by CSS selector}
\usage{
get_by_selector(page_df, selector)
}
\arguments{
\item{page_df}{A data frame containing page information, including the \code{page_id} column.
This data frame is used to identify the page object from which the element should be retrieved.}

\item{selector}{A character string representing the CSS selector of the element to retrieve.}
}
\value{
The updated \code{page_df} data frame with an additional \code{elem_id} column containing the identifier of the retrieved element.
}
\description{
The \code{get_by_selector} function retrieves an element with the specified CSS selector from the page object within a web browser session.
}
\examples{
# Create a page_df data frame
page_df <- data.frame(page_id = "my_page")

# Retrieve an element by CSS selector using the page_df
get_by_selector(page_df, "#myElement")

}
