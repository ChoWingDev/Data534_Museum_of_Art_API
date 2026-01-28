#' Internal request helper for The Met Collection API
#'
#' @param path Character. Endpoint path, e.g. "departments", "search", "objects/123".
#' @param query Named list. Query parameters.
#' @param timeout Numeric. Request timeout in seconds.
#' @return A parsed R object (usually a list) from JSON.
#' @keywords internal
met_get <- function(path, query = list(), timeout = 10) {
  base_url <- "https://collectionapi.metmuseum.org/public/collection/v1/"
  
  # Build URL
  url <- paste0(base_url, path)
  
  # Make request (use base R to avoid dependencies for now)
  resp <- tryCatch(
    {
      utils::URLencode(url, reserved = TRUE) # ensure safe URL
      httr::GET(url, query = query, httr::timeout(timeout))
    },
    error = function(e) {
      stop("Request failed: ", conditionMessage(e), call. = FALSE)
    }
  )
  
  # Handle HTTP errors
  status <- httr::status_code(resp)
  if (status >= 400) {
    msg <- tryCatch(httr::content(resp, as = "text", encoding = "UTF-8"), error = function(e) "")
    stop("API request failed (HTTP ", status, "). ", msg, call. = FALSE)
  }
  
  # Parse JSON
  out <- httr::content(resp, as = "text", encoding = "UTF-8")
  jsonlite::fromJSON(out, simplifyVector = FALSE)
}
