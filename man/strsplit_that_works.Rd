% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/strsplit_that_works.R
\name{strsplit_that_works}
\alias{strsplit_that_works}
\title{strsplit_that_works}
\usage{
strsplit_that_works(cell, entity_requested, split = "_")
}
\arguments{
\item{cell}{the string you want to split}

\item{entity_requested}{a number representing the}

\item{split}{split used in strsplit Default: '_'}
}
\description{
We got tired of having to work with splitting strings in weird ways.
}
\details{
Returns only the part of a string as designated by entity_requested
}
\examples{
\dontrun{
try <- ("1_2_3_4")
strsplit_that_works(try, 1, split = "_")

library(tidyverse)
tidyr::table3 \%>\%
  mutate(map_chr(rate, first_part = strsplit_that_works, 1, split = "/"))
}
}
