#' Get event regions
#'
#' Get the countries and associated regions with event listings.
#'
#' @return list
#' @export
#'
#' @examples
#' \dontrun{
#' ra_get_regions()
#' }
ra_get_regions <- function() {

  page <- polite_read_html("https://www.residentadvisor.net/events?show=all")

  regions <- rvest::html_nodes(page, ".col2.fl.mb32")

  country_names <- rvest::html_text(rvest::html_nodes(regions, "div.mr8 > h1"))

  region_lists <- rvest::html_nodes(regions, "div.mr8 > ul")

  region_attrs <- lapply(region_lists, function(x) {

    regions <- rvest::html_nodes(x, "li > a")

    region_name = rvest::html_attr(regions, "title")
    region_code = stringr::str_remove(rvest::html_attr(regions, "href"), "/events/")

    purrr::map2(region_name, region_code, ~ list(region_name = .x, region_code = .y))

  })

  purrr::map2(country_names, region_attrs, ~ list(country = .x, regions = .y))

}

# get lineup details
get_event_lineup <- function(page) {
  lineup_element <- rvest::html_nodes(page, "p.lineup > a")

  names <- rvest::html_text(lineup_element)
  ids <- stringr::str_extract(
    rvest::html_attr(lineup_element, "href"),
    "([^/]+$)"
  )

  purrr::map2(names, ids, ~ list(artist_name = .x, artist_id = .y))
}

# get event name
get_event_name <- function(page) {
  page %>%
    rvest::html_nodes("#sectionHead > h1") %>%
    rvest::html_text()
}

# get date of a event
get_event_date <- function(page) {
  date_element <- rvest::html_nodes(
    page, "#detail > ul > li:contains(Date) > a.cat-rev"
  )

  anytime::anydate(rvest::html_text(date_element))
}

# get venue name of a event
get_event_venue_name <- function(page) {
  venue_element <- rvest::html_nodes(
    page, "#detail > ul > li:contains(Venue) > a.cat-rev"
  )

  rvest::html_text(venue_element)
}

# get venue link of a event
get_event_venue_id <- function(page) {
  venue_element <- rvest::html_nodes(
    page, "#detail > ul > li:contains(Venue) > a.cat-rev"
  )

  as.numeric(
    stringr::str_extract(
      rvest::html_attr(venue_element, "href"),
      "([^=]+$)"
    )
  )
}

# get promoter of a event
get_event_promoter <- function(page) {
  promoter_element <- rvest::html_nodes(
    page, "#detail > ul > li:contains(Promoter) > div + a"
  )

  names <- rvest::html_text(promoter_element)
  ids <- as.numeric(stringr::str_extract(
    rvest::html_attr(promoter_element, "href"),
    "([^=]+$)"
  ))

  purrr::map2(names, ids, ~ list(promoter_name = .x, promoter_id = .y))
}

#' Get information about an event
#'
#' @param event_id numeric; event ID (taken from event URL)
#'
#' @return a list
#' @export
#'
#' @examples
#' ra_get_event(event_id = 1422257)
#' ra_get_event(event_id = 1421207)
#' ra_get_event(event_id = 523058)
ra_get_event <- function(event_id) {
  url <- file.path(
    "https://www.residentadvisor.net", "events", event_id
  )

  event_page <- polite_read_html(url)

  event_details <- list()

  event_details[["event_id"]] <- as.numeric(event_id)
  event_details[["event_name"]] <- get_event_name(event_page)
  event_details[["event_date"]] <- get_event_date(event_page)
  event_details[["venue_id"]] <- get_event_venue_id(event_page)
  event_details[["venue_name"]] <- get_event_venue_name(event_page)
  event_details[["artists"]] <- get_event_lineup(event_page)
  event_details[["promoters"]] <- get_event_promoter(event_page)

  event_details
}

#' Get event information for a region
#'
#' @param region_code region code (taken from \code{ra_get_regions})
#' @param start_date date of first event(s) (in ISO 8601 format e.g. "2020-10-01")
#' @param date_range date range of events to retrieve (defaults to "month")
#'
#' @return a list
#' @export
#'
#' @examples
#' \dontrun{
#' ra_get_region_events(
#' region_code = "morocco", start_date = "2020-01-01"
#' )
#'
#' ra_get_region_events(
#' region_code = "uk/manchester", start_date = "2020-09-01"
#' )
#' }
ra_get_region_events <- function(region_code, start_date,
                                 date_range = c("month", "week", "day")
                                 ) {

  date_range <- match.arg(date_range)

    url <- file.path(
      "https://www.residentadvisor.net", "events", region_code,
      date_range, start_date
    )

  event_ids <- polite_read_html(url) %>%
    rvest::html_nodes("#event-listing li a ") %>%
    rvest::html_attr("href") %>%
    stringr::str_subset("/events/\\d+$") %>%
    stringr::str_extract("([^/]+$)") %>%
    unique() %>%
    as.numeric()

  list(
    region_code = region_code,
    events = lapply(event_ids, ra_get_event)
  )
}

#' Get events for a club
#'
#' @inheritParams ra_get_club
#'
#' @return a list
#' @export
#'
#' @examples
#' \dontrun{
#' ra_get_club_events(club_id = 2587)
#' ra_get_club_events(club_id = 16687)
#' }
ra_get_club_events <- function(club_id) {

  club_home <- polite_read_html(
    "https://www.residentadvisor.net/club.aspx",
    query = list(id = club_id, show = "events")
  )

  # check if year selector is used
  year_selector <- rvest::html_nodes(club_home, "#Form1 .arrow-down")

  if (length(year_selector) == 0) {

    event_articles <- rvest::html_nodes(club_home, "article")

    if (length(event_articles) > 0) {

      events <- list()

      event_ids <- event_articles %>%
        rvest::html_nodes("a") %>%
        rvest::html_attr("href") %>%
        stringr::str_extract("([^/]+$)") %>%
        unique() %>%
        as.numeric()

      event_names <- event_articles %>%
        rvest::html_nodes("a h1") %>%
        rvest::html_text()

      event_dates <- event_articles %>%
        rvest::html_nodes(".date") %>%
        rvest::html_text() %>%
        anytime::anydate()

      events[["club_id"]] <- club_id

      events[["events"]] <- c(events[["events"]], purrr::pmap(
        list(a = event_ids, b = event_names, c = event_dates),
        function(a, b, c, d) list(event_id = a, event_name = b, event_date = c)
      ))

      return(events)

    } else {
      return(NULL)
    }

  } else {

    year <- as.numeric(format(Sys.Date(), "%Y"))

    events <- list()

    while(year > 0) {

      club_page <- polite_read_html(
        "https://www.residentadvisor.net/club.aspx",
        query = list(id = club_id, show = "events", yr = year)
      )

      event_articles <- rvest::html_nodes(club_page, "article")

      if (length(event_articles) > 0) {

        event_ids <- event_articles %>%
          rvest::html_nodes("a") %>%
          rvest::html_attr("href") %>%
          stringr::str_extract("([^/]+$)") %>%
          unique() %>%
          as.numeric()

        event_names <- event_articles %>%
          rvest::html_nodes("a h1") %>%
          rvest::html_text()

        event_dates <- event_articles %>%
          rvest::html_nodes(".date") %>%
          rvest::html_text() %>%
          anytime::anydate()

        events[["club_id"]] <- club_id

        events[["events"]] <- c(events[["events"]], purrr::pmap(
          list(a = event_ids, b = event_names, c = event_dates),
          function(a, b, c, d) list(event_id = a, event_name = b, event_date = c)
        ))

        year <- year - 1
      } else {
        break
      }
    }
  }
  events
}
