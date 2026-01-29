#' Creating a clean tibble from a single object's JSON output
#' @param x Raw JSON from the API for a single object
#' @return A one row tibble
#' @export

met_tidy_object <- function(x) {
  
  #returns empty tibble if nothing was returned
  if (is.null(x)) return(tibble::tibble())
  
  #extract key fields
  tibble::tibble(
    object_id = x$objectID,
    title = x$title,
    artist_display_name = x$artistDisplayName,
    object_date = x$objectDate,
    department = x$department,
    object_begin_date = as.numeric(x$objectBeginDate),
    object_end_date = as.numeric(x$objectEndDate),
    primary_image = x$primaryImage,
    tags = if (!is.null(x$tags)) list(x$tags) else list(NA),
    constituents = if (!is.null(x$constituents)) list(x$constituents) else list(NA)
  )
}
