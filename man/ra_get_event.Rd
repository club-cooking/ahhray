% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/events.R
\name{ra_get_event}
\alias{ra_get_event}
\title{Get information about an event}
\usage{
ra_get_event(event_id)
}
\arguments{
\item{event_id}{numeric; event ID (taken from event URL)}
}
\value{
a list
}
\description{
Get information about an event
}
\examples{
ra_get_event(event_id = 1422257)
ra_get_event(event_id = 1421207)
}
