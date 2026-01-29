#' Retrieves one piece of art from the collection
#' @param object_id ID of a single object (piece of art)
#' @return A one-row tibble or an empty tibble if nothing is found
#' @export

met_object <- function(object_id) {
  
  #to check if it's actually only one ID
  if (length(object_id) > 1) stop("Please provide only one object_id")
  if (length(object_id) == 0) stop("No object_id entered. Please try again")
  
  
  #try to get info from the API or return null
  result <- tryCatch(
    met_get(paste0("objects/", object_id)),
    error = function(e) NULL
  )
  
  #empty tibble if nothing is found
  if (is.null(result)) {
    return(tibble::tibble())
  }
  
  #simple tibble using the helper
  met_tidy_object(result)
}


