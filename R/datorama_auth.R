#' Authenticating yourself to Datorama
#'
#' @param email A string containing the email associated with your Datorama account
#' @param password A string containing the password associated with your Datorama account
#'
#' @return A string with your our API token
#' @examples
#' \dontrun{
#' datorama_token("someEmail@gmail.com", "password1234")
#' }
#' @export
datorama_token <- function(email, password) {
  if (!is.character(email)) {
    stop("Yikes! Your email must be a string!")
  } else if (!is.character(password)) {
    stop("Whoops! Your password needs to be a string!")
  }

  tryCatch(
    token_response <- httr::POST("https://app.datorama.com/services/auth/authenticate",
                      body = list(email = email,
                                  password = password),
                      encode = "json"),
    warning = function(w) print("Something went wrong, but here's to second chances!")
  )

  token <- httr::content(token_response)$token

  return(token)
}
