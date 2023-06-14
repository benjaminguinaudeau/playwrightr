library(testthat)

test_that("pw_init initializes Playwright with XVFB when use_xvfb is TRUE", {
  # Clean up any existing vdisplay and p objects
  if (exists("vdisplay")) {
    vdisplay$stop()
    rm(vdisplay)
  }
  if (py_exists("p")) {
    p$stop()
    rm(p)
  }

  # Call pw_init with use_xvfb = TRUE
  pw_init(use_xvfb = TRUE)

  # Check if vdisplay and p objects are created
  expect_true(exists("vdisplay"))
  expect_true(py_exists("p"))
})

test_that("pw_init initializes Playwright without XVFB when use_xvfb is FALSE", {
  # Clean up any existing vdisplay and p objects
  if (exists("vdisplay")) {
    vdisplay$stop()
    rm(vdisplay)
  }
  if (exists("p")) {
    p$stop()
    rm(p)
  }

  # Call pw_init with use_xvfb = FALSE
  pw_init(use_xvfb = FALSE)

  # Check if vdisplay and p objects are created
  expect_false(exists("vdisplay"))
  expect_true(exists("p"))
})

test_that("pw_init does not start XVFB multiple times when use_xvfb is TRUE", {
  # Clean up any existing vdisplay and p objects
  if (exists("vdisplay")) {
    vdisplay$stop()
    rm(vdisplay)
  }
  if (exists("p")) {
    p$stop()
    rm(p)
  }

  # Start XVFB manually
  xlib <- import("xvfbwrapper")
  vdisplay <- xlib$Xvfb()
  vdisplay$start()

  # Call pw_init with use_xvfb = TRUE
  pw_init(use_xvfb = TRUE)

  # Check if vdisplay and p objects are created
  expect_true(exists("vdisplay"))
  expect_true(exists("p"))
})

test_that("pw_init initializes Playwright without XVFB when use_xvfb is FALSE and XVFB is already started", {
  # Clean up any existing vdisplay and p objects
  if (exists("vdisplay")) {
    vdisplay$stop()
    rm(vdisplay)
  }
  if (exists("p")) {
    p$stop()
    rm(p)
  }

  # Start XVFB manually
  xlib <- import("xvfbwrapper")
  vdisplay <- xlib$Xvfb()
  vdisplay$start()

  # Call pw_init with use_xvfb = FALSE
  pw_init(use_xvfb = FALSE)

  # Check if vdisplay and p objects are created
  expect_false(exists("vdisplay"))
  expect_true(exists("p"))
})
