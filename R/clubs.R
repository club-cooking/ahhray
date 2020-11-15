#' Get information about a club
#'
#' @param club_id numeric; club ID (taken from club URL)
#'
#' @return a list
#' @export
#'
#' @examples
#' \dontrun{
#' ra_get_club(club_id = 106730)
#' ra_get_club(club_id = 175569)
#' }
ra_get_club <- function(club_id){

  club_info <- list()

  club_page <- polite_read_html(
    "https://www.residentadvisor.net/club.aspx",
    query = list(id = club_id)
  )

  club_info[["club_name"]] <- club_page %>%
    rvest::html_nodes("#sectionHead span[itemprop='name']") %>%
    rvest::html_text()

  club_info[["club_id"]] <- as.numeric(club_id)

  club_info[["club_address"]] <- club_page %>%
    rvest::html_nodes("#detail span[itemprop='address']") %>%
    rvest::html_text()

  club_info[["club_capacity"]] <- club_page %>%
    rvest::html_nodes("#detail ul > li:nth-child(2)") %>%
    rvest::html_text() %>%
    stringr::str_remove("Capacity /") %>%
    as.numeric()

  club_info
}

# get features of a club
get_club_attrs <- function(x, status = c("open", "closed")) {

  status <- match.arg(status)

  clubs <- rvest::html_nodes(x, "#clubs a")

  club_names <- trimws(rvest::html_text(clubs))
  club_addresses <- rvest::html_text(
    rvest::html_nodes(x, "#clubs .mobile-off")
  )
  club_ids <- as.numeric(
    stringr::str_extract(rvest::html_attr(clubs, "href"), "([^=]+$)")
  )
  club_statuses <- rep(status, length(club_ids))

  purrr::pmap(
    list(a = club_names, b = club_addresses, c = club_ids, d = club_statuses),
    function(a, b, c, d) list(club_name = a, club_address = b, club_id = c, club_status = d)
  )
}

#' Get clubs listed on RA for a region
#'
#' @param ai numeric; limit results to a specific region
#' (taken from region's URL e.g. 1 for Sydney)
#' @param include_closed logical; include clubs that are
#' now closed in the results?
#'
#' @return a list
#' @export
#'
#' @examples
#' \dontrun{
#' ra_get_region_clubs(ai = 13)
#' ra_get_region_clubs(ai = 13, include_closed = TRUE)
#' }
ra_get_region_clubs <- function(ai, include_closed = FALSE) {
  page <- polite_read_html(
    "https://www.residentadvisor.net/clubs.aspx",
    query = list(ai = ai)
  )

  # get regions clubs
  clubs <- get_club_attrs(page)

  # get closed clubs in region
  if (include_closed) {

    closed_page <- polite_read_html(
      "https://www.residentadvisor.net/clubs.aspx",
      query = list(ai = ai, status = "closed")
    )

    closed_clubs <- get_club_attrs(closed_page, status = "closed")

    clubs <- c(clubs, closed_clubs)
  }

  list(ai = ai, clubs = clubs)
}
