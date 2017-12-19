#' A query constructor for the Datorama API
#'
#' @param token A string containing your token for authentication. Get in \code{datorama_auth}
#' @param brandId A string containing the Brand ID
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
#' datorama_query(token = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
#'                brandId = "271",
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
datorama_query <- function(token = NULL,
                              brandId = NULL,
                              dateRange = c("CUSTOM",
                                            "CUSTOM_ON_GOING",
                                            "YESTERDAY",
                                            "WEEK_TO_DATE",
                                            "BI_WEEK_TO_DATE",
                                            "MONTH_TO_DATE",
                                            "QUARTER_TO_DATE",
                                            "YEAR_TO_DATE",
                                            "WEEK_TO_DATE_CUSTOM",
                                            "BI_WEEK_TO_DATE_CUSTOM",
                                            "MONTH_TO_DATE_CUSTOM",
                                            "QUARTER_TO_DATE_CUSTOM",
                                            "YEAR_TO_DATE_CUSTOM",
                                            "PREV_WEEK",
                                            "PREV_BI_WEEK",
                                            "PREV_MONTH",
                                            "PREV_QUARTER",
                                            "PREV_YEAR",
                                            "PREV_WEEK_CUSTOM",
                                            "PREV_BI_WEEK_CUSTOM",
                                            "PREV_MONTH_CUSTOM",
                                            "PREV_QUARTER_CUSTOM",
                                            "PREV_YEAR_CUSTOM",
                                            "LAST_WEEK",
                                            "LAST_BI_WEEK",
                                            "LAST_MONTH",
                                            "LAST_3_MONTHS",
                                            "THIS_WEEK",
                                            "THIS_BI_WEEK",
                                            "THIS_MONTH",
                                            "THIS_QUARTER",
                                            "THIS_YEAR",
                                            "THIS_WEEK_CUSTOM",
                                            "THIS_BI_WEEK_CUSTOM",
                                            "THIS_MONTH_CUSTOM",
                                            "THIS_QUARTER_CUSTOM",
                                            "THIS_YEAR_CUSTOM"),
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
    response <- httr::POST(paste("https://app.datorama.com/services/query/execQuery?token=",
                     token,
                     sep = ""),
               body = list(
                 brandId = brandId,
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
    query_warning = function(w) print("Query failed...so sad. Try again!\nAt a minimum you need a brandId, dateRange, measurement and dimension in order to get a successful result.\nAdditionally, make sure you have a token generated from dataorama_auth()")
  )

  response_to_text <- jsonlite::fromJSON(httr::content(response, "text"))
  text_to_tibble <- tibble::as_tibble(response_to_text$queryResponseData$rows)

  if (nrow(text_to_tibble) == 0) {
    warning("Hmmm...no rows returned. There might be a problem.")
  }

  return(text_to_tibble)
}
