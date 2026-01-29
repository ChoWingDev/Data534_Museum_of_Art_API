#' Retrieves multiple pieces of art from the collection
#' @param object_ids A vector of object IDs
#' @return Tibble with one row per object or an empty if no objects are found
#' @export

met_objects <- function(object_ids) {
  
  #check that there was at least one ID given 
  if (length(object_ids) == 0) {
    stop("No object IDs provided")
  }
  
  #empty list to fill with results
  results_list <- list()
  
  #loop for every ID
  for (i in seq_along(object_ids)) {
    #get a single object with the met_object() function
    results_list[[i]] <- met_object(object_ids[i])
  }
  
  #return the tibble of all of the results
  results <- dplyr::bind_rows(results_list)
  return(results)
}
