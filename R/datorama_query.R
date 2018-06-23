#' A query constructor for the Datorama Query API
#'
#' Refer to Datorama's Developer portal for futher information. In
#' order to use this package your account will have to have access
#' to the Datorama Query API, which is a paid feature.
#'
#' @param access_token Authorization string that is found within the Datorama platform
#' @param workspaceId A string containing the workspaceId
#' @param dateRange A string containing date range for query
#' @param startDate A string -> format YYYY-MM-DD
#' @param endDate A string -> format YYYY-MM-DD
#' @param measurements A list of lists including attributes to include -> list(list(name = "Investment"))
#' @param dimensions A list of dimensions to be included -> list("Day", "Site Name")
#' @param groupDimensionFilters A list of lists including dimension, operator -> "IN", "NOT IN", and vals for filtering
#' @param stringDimensionFilters A list of lists including dimension, operator -> "EQUALS", "NOT_EQUALS", "NOT_EQUALS_CASE_SENSITIVE", "CONTAINS", "NOT_CONTAINS", "STARTS_WITH", "ENDS_WITH", "IS_EMPTY", "IS_NOT_EMPTY", and val for filtering
#' @param stringDimensionFiltersOperator A string for string dimension filtering -> "AND", "OR"
#' @param numberMeasurementFilter A list of lists including filedName (measurement name), operator -> "EQUALS", "NOT_EQUALS", "GREATER", "GREATER_EQUALS", "LESS", "LESS_EQUALS", "IS_NULL", "IS_NOT_NULL", "IS_NAN", "IS_NOT_NAN" and val for filtering
#' @param sortBy A string including name of dimension/measurement to sort by
#' @param sortOrder A string containing the order of the sort -> "ASC", "DESC"
#' @param topResults A string containing the number of results to return
#' @param groupOthers Boolean determining whether to group all results not in topResults
#' @param topPerDimension Boolean determining whether to return topResults per dimension
#'
#' @examples
#' \dontrun{
#' datorama_query(acces_token = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
#'                workspaceId = "271",
#'                dateRange = "CUSTOM",
#'                startDate = "2017-11-01",
#'                endDate = "2017-11-20",
#'                measurements = list(list(name = "Clicks"),
#'                               list(name = "Impressions")),
#'                dimensions = list("Day", "Site Name")
#' )
#' }
#' @return A tibble with the query's response
#' @export
datorama_query <- function(access_token = NULL,
                           workspaceId = NULL,
                           dateRange = NULL,
                           startDate = NULL,
                           endDate = NULL,
                           measurements = NULL,
                           dimensions = NULL,
                           groupDimensionFilters = NULL,
                           stringDimensionFilters = NULL,
                           stringDimensionFiltersOperator = NULL,
                           numberMeasurementFilter = NULL,
                           sortBy = NULL,
                           sortOrder = NULL,
                           topResults = NULL,
                           groupOthers = NULL,
                           topPerDimension = NULL) {

  tryCatch(
    response <- httr::POST("https://api.datorama.com/v1/query", httr::add_headers(Authorization = access_token),
               body = list(
                 workspaceId = workspaceId,
                 dateRange = dateRange,
                 startDate = startDate,
                 endDate = endDate,
                 measurements = measurements,
                 dimensions = dimensions,
                 groupDimensionFilters = groupDimensionFilters,
                 stringDimensionFilters = stringDimensionFilters,
                 stringDimensionFiltersOperator = stringDimensionFiltersOperator,
                 numberMeasurementFilter = numberMeasurementFilter,
                 sortBy = sortBy,
                 sortOrder = sortOrder,
                 topResults = topResults,
                 groupOthers = groupOthers,
                 topPerDimension = topPerDimension
               ),
               encode = "json"
    ),
    query_warning = function(w) print("Query Failure:\nAt a minimum you need a workspaceId, dateRange, measurement and dimension in order to get a successful result.\nAlso, a proper access_token.")
  )

  response_to_text <- jsonlite::fromJSON(httr::content(response, "text"))
  tibble_headers <- response_to_text$queryResponseData$headers
  text_to_tibble <- tibble::as_tibble(response_to_text$queryResponseData$rows)
  names(text_to_tibble) <- tibble_headers

  if (nrow(text_to_tibble) == 0) {
    warning("Error: no rows were returned.")
  }

  return(text_to_tibble)
}
