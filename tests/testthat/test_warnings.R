library(baRcodeR)

context("Input warnings")

test_that("input errors are produced", {
  expect_error(label_maker(string="example", level="hi"), "level is not a string of numbers")
  expect_error(label_maker(string="example", level=1:300, digits=2), "Max value of levels is greater than number of digits. Increase digits value")
  expect_error(label_hier_maker(hierarchy = c("a",3,6)), "hierarchy is not in list format")
  expect_error(label_hier_maker(hierarchy = list(c("a",3,6), c("b",1))), "hierarchy entries are not of equal length. Each element should have a string, a beginning value and an end value.")
  expect_error(create_PDF(), "Labels do not exist. Please pass in Labels")
})
