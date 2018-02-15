#' @title Pipe hyetographs
#'
#' @description Like dplyr, \code{erosivity} also uses the pipe function,
#' \code{\%>\%} to turn function composition into a series of imperative
#' statements.
#'
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @export
#' @param lhs,rhs A hyetograph and a function to apply to it
#' @examples
#'
#' # Instead of
#'
#' data("prec5min")
#' hyet_clear <-  hyet_remove_rep(prec5min)
#' hyet_fill <- hyet_fill(hyet_clear, time_step = 5)
#'
#' # you can write
#' prec5min %>% hyet_remove_rep() %>% hyet_fill(time_step = 5)
NULL
