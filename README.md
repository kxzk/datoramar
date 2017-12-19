# DatoramaR

A thin wrapper around the [Datorama](https://datorama.com) API.
[![Build Status](https://travis-ci.org/beigebrucewayne/datoramar.svg?branch=master)](https://travis-ci.org/beigebrucewayne/datoramar)

![logo](https://i.imgur.com/6c5kH7S.png)

&nbsp;
## Installation

```r
devtools::install_github('beigebrucewayne/datoramar')
```

&nbsp;
## Authenticate

1. You're going to need a paying Datorama account.
2. You'll also need an account with permission to access the API.
3. Run `datorama_token()` with your email and password

&nbsp;
## Usage

Once you have your token, you can run a query using `datorama_query()`. This function will return the API's response as a tibble.

```r
myToken <- datorama_token("email@gmail.com", "password1234")

datorama_query(token = myToken,
               brandId = "271",
               dateRange = "CUSTOM",
               startDate = "2017-11-01",
               endDate = "2017-11-22",
               measurements = list(list(name = "Clicks"),
                                   list(name = "Impressions")),
               dimensions = list("Date", "Site Name")
)
```
