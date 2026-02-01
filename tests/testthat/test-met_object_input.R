test_that("met_object validates input length", {
  expect_error(met_object(integer()), regexp = "No object_id", ignore.case = TRUE)
  expect_error(met_object(c(1, 2)), regexp = "only one", ignore.case = TRUE)
})
