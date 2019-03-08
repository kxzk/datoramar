# DatoramaR

An interface to the [Datorama](https://datorama.com) Query & Platform API.  

[![Build Status](https://travis-ci.org/kadekillary/datoramar.svg?branch=master)](https://travis-ci.org/kadekillary/datoramar) [![CRAN status](http://www.r-pkg.org/badges/version/datoramar)](http://www.r-pkg.org/badges/version/datoramar)

![logo](https://i.imgur.com/6c5kH7S.png)

&nbsp;
## Overview
Datorama has two APIs: the Query API and the Platform API. This package interfaces with both. The Query API is for retrieving data out of Datorama. The Platform API is for interacting with the platform directly.

As of right now, only the Query API and Data Stream Processing endpoints are supported.

&nbsp;
## Installation

Install from Github
```r
devtools::install_github('kadekillary/datoramar')
```

&nbsp;
## Authentication

All API requests must authenticate using your personal API access token. The token can be found inside the Datorama platform under "My Profile" below your email address.

Conversely, create an `.Renviron` file and specify your `ACCESS_TOKEN` in there. Now you can call it via R using `Sys.getenv("ACCESS_TOKEN")`.

&nbsp;
## Usage

Once you have your token, you can run a query using `datorama_query()`. This function will return the Query API's response as a tibble.

`datorama_query()`
```r
datorama_query(access_token = "dato-api-31i9a14b-b41d-323h-2f79-379nxhfdf8123",
               workspaceId = "999999",
               dateRange = "CUSTOM",
               startDate = "2017-11-01",
               endDate = "2017-11-22",
               measurements = list(list(name = "Clicks"),
                                   list(name = "Impressions")),
               dimensions = list("Date", "Site Name")
)
```

You can also use this API wrapper to automate the processing of particular Data Streams. You will need to specify the Data Stream by it's ID and specify a time window.

`datorama_process()`
```r
datorama_process(acces_token = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
                 dataStreamIds = list(348937, 34289),
                 startDate = "2018-01-01",
                 endDate = "2018-01-20"
)
```
