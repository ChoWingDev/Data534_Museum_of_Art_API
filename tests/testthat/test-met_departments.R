test_that("met_departments returns department_id and display_name", {
  skip_if_offline()
  
  res <- met_departments()
  
  expect_s3_class(res, "tbl_df")
  expect_true(all(c("department_id", "display_name") %in% names(res)))
  expect_true(nrow(res) > 0)
})
