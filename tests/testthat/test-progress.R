test_that("The progress bar works", {
  f <- tempfile()
  on.exit(unlink(f))

  withr::with_envvar(c("VROOM_PROGRESS_SHOW_AFTER" = "0", "VROOM_PROGRESS_UPDATE_INTERVAL" = "0", "VROOM_PROGRESS_THREAD_SLEEP" = ".25"), {
    withr::with_message_sink(f,
      vroom("abc\n123\n", col_types = list(), progress = TRUE)
    )
  })
  output <- glue::glue_collapse(readLines(f), "\n")

  expect_true(grepl("indexing", output))
  expect_true(grepl("/s", output))
  expect_true(grepl("eta:", output))
})
