#' Search The Met collection
#'
#' Searches The Met Collection API and returns matching object IDs.
#'
#' @param q Character. Search query keyword(s).
#' @param has_images Logical. If TRUE, return only objects with images.
#' @param department_id Integer or NULL. Filter by department ID.
#' @param is_on_view Logical or NULL. Filter objects currently on view.
#' @param artist_or_culture Logical or NULL. If TRUE, search artistOrCulture field.
#' @return A tibble with columns:
#' \describe{
#'   \item{total}{Total number of matches}
#'   \item{object_id}{Integer object IDs (one per row)}
#' }
#' @examples
#' \dontrun{
#' met_search("monet", has_images = TRUE)
#' }
#' @export
met_search <- function(q,
                       has_images = TRUE,
                       department_id = NULL,
                       is_on_view = NULL,
                       artist_or_culture = NULL) {
  
  if (missing(q) || !is.character(q) || length(q) != 1 || nchar(q) == 0) {
    stop("`q` must be a non-empty single string.", call. = FALSE)
  }
  
  query <- list(q = q, hasImages = has_images)
  
  if (!is.null(department_id)) query$departmentId <- department_id
  if (!is.null(is_on_view)) query$isOnView <- is_on_view
  if (!is.null(artist_or_culture)) query$artistOrCulture <- artist_or_culture
  
  res <- met_get("search", query = query)
  
  total <- if (!is.null(res$total)) as.integer(res$total) else 0L
  ids <- if (!is.null(res$objectIDs)) as.integer(res$objectIDs) else integer()
  
  out <- tibble::tibble(object_id = ids)
  attr(out, "total") <- total
  out
  
}
