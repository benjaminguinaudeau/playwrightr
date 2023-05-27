library(testthat)
devtools::load_all()


test_that("browser_launch launches browser instance", {
  browser <- browser_launch()

  # Check if the browser ID is generated and assigned
  expect_true(!is.null(browser$browser_id))

  # Check if the browser instance is launched successfully
  expect_true(py_exists(browser$browser_id))
})

test_that("browser_launch sets headless mode correctly", {
  # Launch browser in headless mode
  browser_headless <- browser_launch(headless = TRUE)

  # Check if the browser instance is headless
  expect_true(py_run(glue("{browser_headless$browser_id}.browser.is_headless()")))

  # Launch browser in non-headless mode
  browser_non_headless <- browser_launch(headless = FALSE)

  # Check if the browser instance is non-headless
  expect_false(py_run(glue("{browser_non_headless$browser_id}.browser.is_headless()")))
})

test_that("browser_launch sets executable path correctly", {
  executable_path <- "/path/to/chromium"
  browser <- browser_launch(executable_path = executable_path)

  # Check if the browser instance is launched with the specified executable path
  expect_equal(py_run(glue("{browser$browser_id}.browser.process.executablePath")), executable_path)
})

test_that("browser_launch sets additional arguments correctly", {
  args <- list("--no-sandbox", "--disable-gpu")
  browser <- browser_launch(args = args)

  # Check if the browser instance is launched with the specified additional arguments
  expect_equal(py_run(glue("{browser$browser_id}.browser.process.args")), args)
})

test_that("browser_launch sets proxy correctly", {
  proxy <- list(server = "http://myproxy.com:3128", bypass = ".com,chromium.org,.domain.com")
  browser <- browser_launch(proxy = proxy)

  # Check if the browser instance is launched with the specified proxy settings
  expect_equal(py_run(glue("{browser$browser_id}.browser.context._browser.options.proxy")), proxy)
})

test_that("browser_launch sets slowMo correctly", {
  slow_mo <- 1000
  browser <- browser_launch(slow_mo = slow_mo)

  # Check if the browser instance is launched with the specified slowMo value
  expect_equal(py_run(glue("{browser$browser_id}.browser._options.slowMo")), slow_mo)
})

test_that("browser_launch sets timeout correctly", {
  timeout <- 60000
  browser <- browser_launch(timeout = timeout)

  # Check if the browser instance is launched with the specified timeout value
  expect_equal(py_run(glue("{browser$browser_id}.browser._options.timeout")), timeout)
})


