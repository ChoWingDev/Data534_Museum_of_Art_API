#' List The Met departments
#'
#' Returns all departments available in The Met Collection API.
#'
#' @return A tibble with columns:
#' \describe{
#'   \item{department_id}{Integer department ID}
#'   \item{display_name}{Department display name}
#' }
#' @examples
#' \dontrun{
#' met_departments()
#' }
#' @export
met_departments <- function() {
  res <- met_get("departments")
  
  # Defensive checks
  if (is.null(res$departments) || length(res$departments) == 0) {
    return(tibble::tibble(department_id = integer(), display_name = character()))
  }
  
  tibble::tibble(
    department_id = vapply(res$departments, function(x) x$departmentId, integer(1)),
    display_name  = vapply(res$departments, function(x) x$displayName,  character(1))
  )
}
