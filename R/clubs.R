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
#' ra_get_region_clubs(ai = 10)
#' ra_get_region_clubs(ai = 13, include_closed = TRUE)
#' }
ra_get_region_clubs <- function(ai, include_closed = FALSE) {
  page <- polite_read_html(
    "https://www.residentadvisor.net/clubs.aspx",
    query = list(ai = ai)
  )

  clubs <- rvest::html_nodes(page, "#clubs a")

  club_names <- trimws(rvest::html_text(clubs))
  club_addresses <- rvest::html_text(
    rvest::html_nodes(page, "#clubs .mobile-off")
  )
  club_ids <- as.numeric(
    stringr::str_extract(rvest::html_attr(clubs, "href"), "([^=]+$)")
  )
  club_statuses <- rep("open", length(club_ids))

  if (include_closed) {

    closed_page <- polite_read_html(
      "https://www.residentadvisor.net/clubs.aspx",
      query = list(ai = ai, status = "closed")
    )

    closed_clubs <- rvest::html_nodes(closed_page, "#clubs a")

    closed_club_names <- trimws(rvest::html_text(closed_clubs))
    closed_club_addresses <- rvest::html_text(
      rvest::html_nodes(closed_page, "#clubs .mobile-off")
    )
    closed_club_ids <- as.numeric(
      stringr::str_extract(rvest::html_attr(closed_clubs, "href"), "([^=]+$)")
    )
    closed_club_statuses <- rep("closed", length(closed_club_ids))

    club_names <- c(club_names, closed_club_names)
    club_addresses <- c(club_addresses, closed_club_addresses)
    club_ids <- c(club_ids, closed_club_ids)
    club_statuses <- c(club_statuses, closed_club_statuses)
  }

  res <- list()

  res[["ai"]] <- ai
  res[["clubs"]] <- purrr::pmap(
    list(a = club_names, b = club_addresses, c = club_ids, d = club_statuses),
    function(a, b, c, d) list(club_name = a, club_address = b, club_id = c, club_status = d)
  )

  res
}


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
    rvest::html_nodes("#detail ul:nth-child(1) > li:nth-child(2)") %>%
    rvest::html_text() %>%
    stringr::str_remove("Capacity /") %>%
    as.numeric()

  club_info
}
