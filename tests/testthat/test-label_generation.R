context("Label Generation")

test_that("labels are generated properly", {
  expect_identical(
    uniqID_maker(string="example", level=1:2), 
    data.frame(label = c("example001", "example002"), ind_string = c("example", "example"), ind_number = c("001", "002")))
  expect_identical(
    uniqID_maker(string="example", level=c(3,1)), 
    data.frame(label = c("example003", "example001"), ind_string = c("example", "example"), ind_number = c("003", "001")))
  expect_identical(
    uniqID_maker(string="example", level=1:2, digits = 1), 
    data.frame(label = c("example1", "example2"), ind_string = c("example", "example"), ind_number = c("1", "2")))
  expect_identical(
    uniqID_maker(string="example", level=9:10, digits = 1), 
    data.frame(label = c("example09", "example10"), ind_string = c("example", "example"), ind_number = c("09", "10")))
  
})

test_that("are rasters generated?", {
  expect_s3_class(code_128_make("test"), "rastergrob")
  expect_s3_class(qrcode_make("test", "H"), "rastergrob")
})