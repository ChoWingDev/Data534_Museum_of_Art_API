test_that("met_search returns object_id tibble and total attribute", {
  skip_if_offline()
  
  res <- met_search("cat", has_images = TRUE)
  
  expect_s3_class(res, "tbl_df")
  expect_true("object_id" %in% names(res))

  expect_true(!is.null(attr(res, "total")))
  expect_true(is.integer(attr(res, "total")) || is.numeric(attr(res, "total")))
})
