
#Seemed like the best way for this was to use the url patter, we can get country and regions
#from this page.
get_event_regions <- function() {

  urls <- polite_read_html("https://www.residentadvisor.net/events?show=all") %>%
    rvest::html_nodes("div.mr8 a") %>%
    rvest::html_attr("href")

  stringr::str_extract(urls, "([^/]+$)")
}

# get events for a region
#Not sure how to make this simple yet but hey ho, for example lets look at london events
#If we do it monthly, it only requires 12 calls a year?
get_event_urls <- function(region, year, month) {

  url <- file.path(
    "https://www.residentadvisor.net", "events", region, "month",
    as.Date(paste(year, month, "01", sep = "-"))
    )

  events <- polite_read_html(url) %>%
    rvest::html_nodes("#event-listing li a ") %>%
    rvest::html_attr("href") %>%
    stringr::str_subset("/events/\\d+$")

  stringr::str_extract(events, "([^/]+$)")
}

# get lineup details
get_event_lineup <- function(page){

  lineup_element <- rvest::html_nodes(page, "p.lineup.large > a")

  names <- rvest::html_text(lineup_element)
  links <- rvest::html_attr(lineup_element, "href")

  purrr::map2(names, links, ~list(artist_name = .x, artist_page = .y))
}

# get event name
get_event_name <- function(page){

  page %>%
    rvest::html_nodes("#sectionHead > h1") %>%
    rvest::html_text()
}

# get date of a event
get_event_date <- function(page){

  date_element <- rvest::html_nodes(
    page, "#detail > ul:nth-child(1) > li:nth-child(1) > a"
    )

  anytime::anydate(rvest::html_text(date_element))
}

# get venue of a event
get_event_venue <- function(page){

  venue_element <- rvest::html_nodes(
    page, "#detail > ul:nth-child(1) > li:nth-child(2) > a.cat-rev"
    )

  names <- rvest::html_text(venue_element)
  links <- rvest::html_attr(venue_element, "href")

  purrr::map2(names, links, ~list(venue_name = .x, venue_page = .y))
}

# get promoter of a event
get_event_promoter <- function(page){

  promoter_element <- rvest::html_nodes(
    page, "#detail > ul:nth-child(1) > li:nth-child(4) > a"
  )

  names <- rvest::html_text(promoter_element)
  links <- rvest::html_attr(promoter_element, "href")

  purrr::map2(names, links, ~list(promoter_name = .x, promoter_page = .y))
}

#' get_event_info
#' Get various info from an even page url returns list
#' @param event_id numeric; event ID (taken from event URL)
#'
#' @return a list
#' @export
#'
#' @examples
#' ra_get_event_info(event_id = 1422257)
ra_get_event_info <- function(event_id){

  url <- file.path(
    "https://www.residentadvisor.net", "events", event_id
  )

  event_page <- polite_read_html(url)

  event_details <- list()

  event_details[["event_name"]] <- get_event_name(event_page)

  event_details[["event_date"]] <- get_event_date(event_page)

  event_details[["venue"]] <- get_event_venue(event_page)

  event_details[["artist"]] <- get_event_lineup(event_page)

  event_details[["promoter"]] <- get_event_promoter(event_page)

  event_details
}
