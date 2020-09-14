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
#' }
ra_get_region_clubs <- function(ai) {
  clubs <- polite_read_html(
    "https://www.residentadvisor.net/clubs.aspx",
    query = list(ai = ai)
  ) %>%
    rvest::html_nodes("#clubs a")

  club_names <- trimws(rvest::html_text(clubs))
  club_ids <- as.numeric(
    stringr::str_extract(rvest::html_attr(clubs, "href"), "([^=]+$)")
    )

  res <- list()

  res[["ai"]] <- ai
  res[["clubs"]] <- lapply(seq_along(clubs), function(x) {
    list(
      club_name = club_names[x],
      club_id = club_ids[x]
    )
  })

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
