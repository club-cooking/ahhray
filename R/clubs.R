#' Get clubs listed on RA for a region
#'
#' @param ai numeric; limit results to a specific region
#' (taken from region's URL e.g. 1 for Sydney)
#'
#' @return a list
#' @export
#'
#' @examples
#' \dontrun{
#' ra_get_clubs(ai = 10)
#' }
ra_get_clubs <- function(ai) {
  clubs <- polite_read_html(
    "https://www.residentadvisor.net/clubs.aspx",
    query = list(ai = ai)
  ) %>%
    rvest::html_nodes("#clubs a")

  club_names <- trimws(rvest::html_text(clubs))
  club_urls <- rvest::html_attr(clubs, "href")

  res <- list()

  res[["ai"]] <- ai
  res[["clubs"]] <- lapply(seq_along(clubs), function(x) {
    list(
      club_name = club_names[x],
      club_url = club_urls[x]
    )
  })

  res
}
