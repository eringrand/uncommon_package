#' @title sy_number
#' @param school_year school year in the form SY16-17 or 2016-17
#' @param before_2000 if the year is prior to 2000 and should be written as 1900 - 1901. Defaults to FALSE (i.e. 2001-02)
#' @description Takes a value in the form SY16-17 or 2016-17
#' and converts to a number representing the second/spring year.
#' @seealso \code{\link{change_school_year}} \code{\link{sy_form}} \code{\link{sy_number}}
#' @export
#' @examples
#' sy_number("SY16-17")
sy_number <- function(school_year, before_2000 = FALSE) {
  if (!before_2000) {
    2000 + as.numeric(stringr::str_sub(school_year, -2))
  }
  else {
    1900 + as.numeric(stringr::str_sub(school_year, -2))
  }
}



#' @title change_school_year
#' @description Takes a value in the form 2016-2017
#' and converts to 2016-17
#' @param school_year a school year in the full form of 20XX-20XY
#' @seealso \code{\link{change_school_year}} \code{\link{sy_form}} \code{\link{sy_number}}
#' @export
#' @examples
#' change_school_year("2014-2015")
change_school_year <- function(school_year) {
  if (stringr::str_length(school_year) < 9) stop("school_year is not in the form 20XX-20YY")

  first_year <- stringr::str_sub(school_year, 1, 4)
  second_year <- stringr::str_sub(school_year, -2, -1)
  paste0(first_year, "-", second_year)
}


#' @title sy_form
#' @param school_year school year in the form of a number
#' @param spring_year If the given year represents the Spring portion then TRUE. Defaults to TRUE
#' @description Takes a value in the form of a number (i.e. 2017)
#' and converts to 2016-17. The opposite of `sy_number` with 20 instead of SY.
#' @seealso \code{\link{change_school_year}} \code{\link{sy_form}} \code{\link{sy_number}}
#' @export
#' @examples
#' sy_form("2015")
sy_form <- function(school_year, spring_year = TRUE) {
  if (stringr::str_length(school_year) != 4) stop("school_year is not a number in the form XXXX")

  cent <- as.numeric(stringr::str_sub(school_year, 1, 2)) * 100
  school_year <- as.numeric(school_year)

  if (spring_year) {
    stringr::str_c(school_year - 1, school_year - cent, sep = "-")
  } else {
    stringr::str_c(school_year, school_year - cent + 1, sep = "-")
  }
}

#' @title school_year_from_date
#' @param date date in the form of lubridate::today()
#' @description Takes a date (in lubridate::today) format and converts to a given schools year.
#' @seealso \code{\link{change_school_year}} \code{\link{sy_form}} \code{\link{sy_number}}
#' @export
#' @examples
#' school_year_from_date()
school_year_from_date <- function(date = lubridate::today()) {
  year <- lubridate::year(date)
  month <- lubridate::month(date)

  # define where the "spring" year starts
  if (month >= 9) { # Fall year: Sep - Dec
    spring_year <- year + 1
  } else { # Spring year: Jan - Aug
    spring_year <- year
  }
  return(sy_form(spring_year))
}
