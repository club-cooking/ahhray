
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

#' get_event_lineup
#'
#' Function to get lineup details
#' @param event_id
#'
#' @return
#' @export
#'
#' @examples
#' get_event_lineup(1422257)
get_event_lineup <- function(event_id){

  url <- file.path(
    "https://www.residentadvisor.net", "events", event_id
    )

  lineup <- polite_read_html(url) %>%
    rvest::html_nodes("p.lineup") %>%
    rvest::html_text()

  unlist(stringr::str_split(lineup, pattern = "\n"))
}


#' get_event_name
#' Function to get event name
#' @param event_id
#'
#' @return
#' @export
#'
#' @examples
get_event_name <- function(event_id){

  url <- file.path(
    "https://www.residentadvisor.net", "events", event_id
  )

  polite_read_html(url) %>%
    rvest::html_nodes("#sectionHead > h1") %>%
    rvest::html_text()

}

#' get_event_date_and_venue
#' Function to get date and venue of a event
#' @param event_id
#'
#' @return
#' @export
#'
#' @examples
get_event_date_and_venue <- function(event_id){

  url <- file.path(
    "https://www.residentadvisor.net", "events", event_id
  )

  polite_read_html(url) %>%
    rvest::html_nodes("a.cat-rev") %>%
    rvest::html_attr("href")
}



#' get_promoter_url
#' Get promoter url
#' @param event_id
#'
#' @return
#' @export
#'
#' @examples
get_promoter_url <- function(event_id){

  url <- file.path(
    "https://www.residentadvisor.net", "events", event_id
  )

  polite_read_html(url) %>%
    rvest::html_nodes("div a") %>%
    rvest::html_attr("href") %>%
    stringr::str_subset("/promoter.aspx?")

}

#' get_promoter_or_club_name
#' get a promoter or club name form their url page
#' @param promoter_club_url
#'
#' @return
#' @export
#'
#' @examples
get_promoter_or_club_name <- function(promoter_club_url){

  promoter_club_name <-
    polite_read_html(paste0("https://www.residentadvisor.net", promoter_club_url))  %>%
    rvest::html_nodes("h1") %>%
    rvest::html_text() %>%
    head(1)

}

#' find_event_promoter
#' From en event url find the promoter name
#' @param event_page_url
#'
#' @return
#' @export
#'
#' get_promoter_or_club_name
find_event_promoter <- function(event_page_url){

  promoter_url <- get_promoter_url(event_page_url)

  promoter_name <- get_promoter_name(promoter_url)

}




#' get_event_info
#' Get various info from an even page url returns list
#' @param event_page_url
#'
#' @return
#' @export
#'
#' get_event_info(event_listing_urls[1])
get_event_info <- function(event_page_url){


  event_details <- list()

  date_regex <- "([12]\\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01]))"


  event_details[["event_name"]] <- get_event_name(event_page_url)

  event_date_and_venue <- get_event_date_and_venue(event_page_url)

  event_date <- anytime::anydate(stringr::str_extract(event_date_and_venue[1], date_regex))

  event_details[["event_date"]] <- event_date[1]

  event_details[["event_location"]] <- get_promoter_or_club_name(event_date_and_venue[2])


  event_details[["artist"]] <- get_event_lineup(event_page_url)


  event_details[["promoter"]] <- find_event_promoter(event_page_url)


  event_details


}



