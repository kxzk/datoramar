#' Process Data Streams
#'
#' Process all the data streams listed in `dataStreamIds` between the dates
#' `startDate` and `endDate` (format YYYY-MM-DD). The optional field `create`
#' determines whether it's the first time the data streams are being processed.
#' Default value is false. Data streams being processed for the first time
#' (i.e. create: true) will also have a SmartLenses dashboard created for them.
#' This is designed to allow flexibility when creating complex setups via API.
#' It is the API user's responsibility to determine if they want processed data
#' streams to trigger SmartLenses creation.
#'
#' Note: Used for API streams only.
#'
#' @param access_token Authorization string that is found within the Datorama platform
#' @param dataStreamIds A list of integers relationg to Data Stream IDs to process
#' @param startDate A string -> format YYYY-MM-DD
#' @param endDate A string -> format YYYY-MM-DD
#' @param create A boolean indicating whether to create a new stream or not
#'
#' @return A list containing the processing request's results
#' @export
#'
#' @examples
#' \dontrun{
#' datorama_process(acces_token = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
#'                  dataStreamIds = list(348937, 34289),
#'                  startDate = "2018-01-01",
#'                  endDate = "2018-01-20",
#' )
#' }
datorama_process <- function(access_token = NULL,
                             dataStreamIds = NULL,
                             startDate = NULL,
                             endDate = NULL,
                             create = FALSE) {

  tryCatch(
    response <- httr::POST("https://api.datorama.com/v1/data-streams/process", httr::add_headers(Authorization = access_token),
                           body = list(
                             dataStreamIds = dataStreamIds,
                             dateRange = dateRange,
                             startDate = startDate,
                             create = create
                           ),
                           encode = "json"
    ),
    query_warning = function(w) print("Query Failure: Make sure all fields are entered correctly.")
  )

  response_to_text <- jsonlite::fromJSON(httr::content(response, "text"))

  return(response_to_text)
}
