## ---- echo = FALSE, message = FALSE--------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
library(stubthat)

## ------------------------------------------------------------------------
jedi_or_sith <- function(x) return('No one')
jedi_or_sith_stub <- stub(jedi_or_sith)

## ------------------------------------------------------------------------
jedi_or_sith_stub$withArgs(x = 'Luke')$returns('Jedi')

## ----results='asis'------------------------------------------------------
jedi_or_sith_stub <- jedi_or_sith_stub$build()

## ------------------------------------------------------------------------
jedi_or_sith('Luke')
jedi_or_sith_stub('Luke')

## ------------------------------------------------------------------------
library('httr')

check_api_endpoint_status <- function(url) {
  response <- GET(url)
  response_status <- status_code(response)
  ifelse(response_status == 200, 'up', 'down')
}

## ------------------------------------------------------------------------
stub_of_get <- stub(GET)
stub_of_get$withArgs(url = 'good url')$returns('good response')
stub_of_get$withArgs(url = 'bad url')$returns('bad response')
stub_of_get <- stub_of_get$build()

stub_of_status_code <- stub(status_code)
stub_of_status_code$withArgs(x = 'good response')$returns(200)
stub_of_status_code$withArgs(x = 'bad response')$returns(400)
stub_of_status_code <- stub_of_status_code$build()

library('testthat')
with_mock(GET = stub_of_get, status_code = stub_of_status_code,
          expect_equal(check_api_endpoint_status('good url'), 'up'))

with_mock(GET = stub_of_get, status_code = stub_of_status_code,
          expect_equal(check_api_endpoint_status('bad url'), 'down'))

