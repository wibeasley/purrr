#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL


#' Modify a list
#'
#' @param x A list.
#' @param ... New values of a list. Use \code{NULL} to remove values.
#'   Use a formula to evaluate in the context of the list values.
#' @export
#' @examples
#' x <- list(x = 1:10, y = 4)
#' update_list(x, z = 10)
#' update_list(x, z = ~ x + y)
update_list <- function(x, ...) {
  new_values <- list(...)

  is_formula <- map_lgl(new_values, ~inherits(., "formula"))

  new_values[is_formula] <- lapply(new_values[is_formula], function(f) {
    stopifnot(length(f) == 2)
    eval(f[[2]], x, environment(f))
  })

  utils::modifyList(x, new_values)
}

as_function <- function(f) {
  if (is.function(f)) {
    f
  } else if (inherits(f, "formula")) {
    .x <- NULL # hush R CMD check NOTE

    if (length(f) != 2) {
      stop("Formula must be one sided", call. = FALSE)
    }
    make_function(alist(.x = , .y = , .z = , . = .x), f[[2]], environment(f))
  } else if (is.character(f) || is.numeric(f)) {
    function(g) .subset2(g, f)
  } else {
    stop("Don't know how to convert ", paste0(class(f), collapse = "/"),
      " into a function", call. = FALSE)
  }
}

output_hook <- function(out, x) {
  if (is.data.frame(x)) {
    if (is.null(names(out))) {
      names(out) <- names(x)
    }
    dplyr::as_data_frame(out)
  } else {
    out
  }
}

recycle_args <- function(args) {
  lengths <- lapply(args, length)
  n <- do.call("max", lengths)

  stopifnot(all(lengths %in% c(1, n)))
  to_recycle <- lengths == 1
  args[to_recycle] <- lapply(args[to_recycle], function(x) rep(x, n))
  args
}

names2 <- function(x) {
  names(x) %||% rep("", length(x))
}

"%||%" <- function(x, y) {
  if(is.null(x)) {
    y
  } else {
    x
  }
}


#' Generate random samples from a Bernoulli distribution
#'
#' @param n Number of samples
#' @param p Probability of getting \code{TRUE}
#' @return A logical vector
#' @export
#' @examples
#' rbernoulli(10)
#' rbernoulli(100, 0.1)
rbernoulli <- function(n, p = 0.5) {
  sample(c(TRUE, FALSE), n, replace = TRUE, prob = c(p, 1 - p))
}

#' Generate random samples from a discrete uniform distribution
#'
#' @param n Number of samples to draw.
#' @param a,b Range of the distribution (inclusive).
#' @export
#' @examples
#' table(rdunif(1e3, 10))
rdunif <- function(n, b, a = 1) {
  sample(b - a + 1, n, replace = TRUE) + a - 1
}

# magrittr placeholder
globalVariables(".")
