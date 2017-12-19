# DatoramaR

An interface to the [Datorama](https://datorama.com) API.  

[![Build Status](https://travis-ci.org/beigebrucewayne/datoramar.svg?branch=master)](https://travis-ci.org/beigebrucewayne/datoramar)

![logo](https://i.imgur.com/6c5kH7S.png)

&nbsp;
## Why?
Datorama has a Query API constructor under the Analyze tab, but it's tedious. It's a nice tool to graphically build your JSON request and see the results. However, this package allows for a cleaner interface. This package has two functions: `datorama_token()` and `datorama_query()`. You'll need an account with Datorama in order to authenticate yourself. After that, you are good to go. This can be a great tool to take your company's marketing data and turn it into an automated email report or Shiny dashboard.

&nbsp;
## Installation

```r
install.packages('datoramar')
```

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

Once you have your token, you can run a query using `datorama_query()`. This function will return the API's response as a tibble. Another example, using curl and JSON, can be seen [here](https://github.com/beigebrucewayne/datoramar/blob/master/curl-example.md).

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
