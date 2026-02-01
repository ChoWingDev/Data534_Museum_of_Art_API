test_that("met_objects returns a tibble with expected columns", {
  skip_if_offline()
  
  s <- met_search("monet", has_images = TRUE)
  ids <- head(s$object_id, 3)
  
  skip_if(length(ids) == 0, "No object IDs returned from API search.")
  
  res <- met_objects(ids)
  
  expect_s3_class(res, "tbl_df")
  expect_true(all(c("object_id", "title", "department") %in% names(res)))
})
