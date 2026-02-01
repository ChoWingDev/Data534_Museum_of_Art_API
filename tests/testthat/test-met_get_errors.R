test_that("met_get errors on invalid endpoint", {
  skip_if_offline()
  
  expect_error(
    met_get("this-endpoint-should-not-exist"),
    regexp = "HTTP|404|not found|error",
    ignore.case = TRUE
  )
})
