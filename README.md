
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ahhray

A [Resident Advisor](https://www.residentadvisor.net/) scraper, written
in R.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("club-cooking/ahhray")
```

## Use

``` r
library(ahhray)
```

### Events

Get information about a particular event:

``` r
ra_get_event(event_id = 1422257)
#> $event_id
#> [1] 1422257
#> 
#> $event_name
#> [1] "Percolate presents Bradley Zero, Bryce's Brother & Aletha"
#> 
#> $event_date
#> [1] "2020-09-10"
#> 
#> $venue_id
#> [1] 183928
#> 
#> $venue_name
#> [1] "The Brixton Courtyard"
#> 
#> $artists
#> $artists[[1]]
#> $artists[[1]]$artist_name
#> [1] "Bradley Zero"
#> 
#> $artists[[1]]$artist_id
#> [1] "bradleyzero"
#> 
#> 
#> 
#> $promoters
#> $promoters[[1]]
#> $promoters[[1]]$promoter_name
#> [1] "JNA Events"
#> 
#> $promoters[[1]]$promoter_id
#> [1] 83061
#> 
#> 
#> $promoters[[2]]
#> $promoters[[2]]$promoter_name
#> [1] "The Brixton Courtyard"
#> 
#> $promoters[[2]]$promoter_id
#> [1] 98479
```

Get listed event regions (and associated countries):

``` r
regions <- ra_get_regions()

head(regions)
#> [[1]]
#> [[1]]$country
#> [1] "Albania"
#> 
#> [[1]]$regions
#> [[1]]$regions[[1]]
#> [[1]]$regions[[1]]$region_name
#> [1] "All, Albania"
#> 
#> [[1]]$regions[[1]]$region_code
#> [1] "albania"
#> 
#> 
#> 
#> 
#> [[2]]
#> [[2]]$country
#> [1] "Algeria"
#> 
#> [[2]]$regions
#> [[2]]$regions[[1]]
#> [[2]]$regions[[1]]$region_name
#> [1] "All, Algeria"
#> 
#> [[2]]$regions[[1]]$region_code
#> [1] "algeria"
#> 
#> 
#> 
#> 
#> [[3]]
#> [[3]]$country
#> [1] "Andorra"
#> 
#> [[3]]$regions
#> [[3]]$regions[[1]]
#> [[3]]$regions[[1]]$region_name
#> [1] "All, Andorra"
#> 
#> [[3]]$regions[[1]]$region_code
#> [1] "andorra"
#> 
#> 
#> 
#> 
#> [[4]]
#> [[4]]$country
#> [1] "Angola"
#> 
#> [[4]]$regions
#> [[4]]$regions[[1]]
#> [[4]]$regions[[1]]$region_name
#> [1] "All, Angola"
#> 
#> [[4]]$regions[[1]]$region_code
#> [1] "angola"
#> 
#> 
#> 
#> 
#> [[5]]
#> [[5]]$country
#> [1] "Antigua and Barbuda"
#> 
#> [[5]]$regions
#> [[5]]$regions[[1]]
#> [[5]]$regions[[1]]$region_name
#> [1] "All, Antigua and Barbuda"
#> 
#> [[5]]$regions[[1]]$region_code
#> [1] "antiguaandbarbuda"
#> 
#> 
#> 
#> 
#> [[6]]
#> [[6]]$country
#> [1] "Argentina"
#> 
#> [[6]]$regions
#> [[6]]$regions[[1]]
#> [[6]]$regions[[1]]$region_name
#> [1] "All, Argentina"
#> 
#> [[6]]$regions[[1]]$region_code
#> [1] "argentina"
#> 
#> 
#> [[6]]$regions[[2]]
#> [[6]]$regions[[2]]$region_name
#> [1] "Buenos Aires, Argentina"
#> 
#> [[6]]$regions[[2]]$region_code
#> [1] "ar/buenosaires"
```

Get events that took place in a region, within a particular month:

``` r
morocco_events <- ra_get_region_events(region_code = "morocco", start_date = "2020-01-01")

head(morocco_events$events)
#> [[1]]
#> [[1]]$event_id
#> [1] 1364274
#> 
#> [[1]]$event_name
#> [1] "Main Room X Tajine Surprises"
#> 
#> [[1]]$event_date
#> [1] "2020-01-11"
#> 
#> [[1]]$venue_id
#> [1] 76498
#> 
#> [[1]]$venue_name
#> [1] "5eme Avenue"
#> 
#> [[1]]$artists
#> [[1]]$artists[[1]]
#> [[1]]$artists[[1]]$artist_name
#> [1] "Anass"
#> 
#> [[1]]$artists[[1]]$artist_id
#> [1] "anass"
#> 
#> 
#> 
#> [[1]]$promoters
#> list()
#> 
#> 
#> [[2]]
#> [[2]]$event_id
#> [1] 1368422
#> 
#> [[2]]$event_name
#> [1] "Keep The Magic Alive with Acid Pauli"
#> 
#> [[2]]$event_date
#> [1] "2020-01-16"
#> 
#> [[2]]$venue_id
#> [1] 124741
#> 
#> [[2]]$venue_name
#> [1] "Cabestan Ocean View"
#> 
#> [[2]]$artists
#> [[2]]$artists[[1]]
#> [[2]]$artists[[1]]$artist_name
#> [1] "Acid Pauli"
#> 
#> [[2]]$artists[[1]]$artist_id
#> [1] "acidpauli"
#> 
#> 
#> [[2]]$artists[[2]]
#> [[2]]$artists[[2]]$artist_name
#> [1] "Mr ID"
#> 
#> [[2]]$artists[[2]]$artist_id
#> [1] "mrid"
#> 
#> 
#> 
#> [[2]]$promoters
#> list()
#> 
#> 
#> [[3]]
#> [[3]]$event_id
#> [1] 1368763
#> 
#> [[3]]$event_name
#> [1] "RHYTMICS with Evan Baggs"
#> 
#> [[3]]$event_date
#> [1] "2020-01-17"
#> 
#> [[3]]$venue_id
#> [1] 100731
#> 
#> [[3]]$venue_name
#> [1] "Le Dhow"
#> 
#> [[3]]$artists
#> [[3]]$artists[[1]]
#> [[3]]$artists[[1]]$artist_name
#> [1] "Evan Baggs"
#> 
#> [[3]]$artists[[1]]$artist_id
#> [1] "evanbaggs"
#> 
#> 
#> [[3]]$artists[[2]]
#> [[3]]$artists[[2]]$artist_name
#> [1] "Chaou.B"
#> 
#> [[3]]$artists[[2]]$artist_id
#> [1] "chaoub"
#> 
#> 
#> 
#> [[3]]$promoters
#> list()
#> 
#> 
#> [[4]]
#> [[4]]$event_id
#> [1] 1375080
#> 
#> [[4]]$event_name
#> [1] "Apéros Électro Hors Séries: NAWFAL MYM ● Live"
#> 
#> [[4]]$event_date
#> [1] "2020-01-17"
#> 
#> [[4]]$venue_id
#> [1] 175778
#> 
#> [[4]]$venue_name
#> [1] "Jefferson Club"
#> 
#> [[4]]$artists
#> [[4]]$artists[[1]]
#> [[4]]$artists[[1]]$artist_name
#> [1] "NAWFAL"
#> 
#> [[4]]$artists[[1]]$artist_id
#> [1] "nawfal"
#> 
#> 
#> 
#> [[4]]$promoters
#> list()
#> 
#> 
#> [[5]]
#> [[5]]$event_id
#> [1] 1371582
#> 
#> [[5]]$event_name
#> [1] "Soul Sundays"
#> 
#> [[5]]$event_date
#> [1] "2020-01-19"
#> 
#> [[5]]$venue_id
#> [1] 167397
#> 
#> [[5]]$venue_name
#> [1] "La Ferme El Dar"
#> 
#> [[5]]$artists
#> list()
#> 
#> [[5]]$promoters
#> list()
#> 
#> 
#> [[6]]
#> [[6]]$event_id
#> [1] 1370216
#> 
#> [[6]]$event_name
#> [1] "Souktronic - Pablo Fierro"
#> 
#> [[6]]$event_date
#> [1] "2020-01-24"
#> 
#> [[6]]$venue_id
#> [1] 165965
#> 
#> [[6]]$venue_name
#> [1] "Comptoir Darna"
#> 
#> [[6]]$artists
#> [[6]]$artists[[1]]
#> [[6]]$artists[[1]]$artist_name
#> [1] "Pablo Fierro"
#> 
#> [[6]]$artists[[1]]$artist_id
#> [1] "pablofierro"
#> 
#> 
#> [[6]]$artists[[2]]
#> [[6]]$artists[[2]]$artist_name
#> [1] "Cee ElAssaad"
#> 
#> [[6]]$artists[[2]]$artist_id
#> [1] "ceeelassaad"
#> 
#> 
#> [[6]]$artists[[3]]
#> [[6]]$artists[[3]]$artist_name
#> [1] "FNX Omar"
#> 
#> [[6]]$artists[[3]]$artist_id
#> [1] "fnxomar"
#> 
#> 
#> 
#> [[6]]$promoters
#> list()
```

Get all events that took place in a specific club:

``` r
west_india_centre_events <- ra_get_club_events(club_id = 16687)

head(west_india_centre_events$events)
#> [[1]]
#> [[1]]$event_id
#> [1] 1381037
#> 
#> [[1]]$event_name
#> [1] "S.P.Y Dubplate Style with Guests TBA"
#> 
#> [[1]]$event_date
#> [1] "2020-05-01"
#> 
#> 
#> [[2]]
#> [[2]]$event_id
#> [1] 1339329
#> 
#> [[2]]$event_name
#> [1] "#Fckboris - Register N Rave"
#> 
#> [[2]]$event_date
#> [1] "2019-11-16"
#> 
#> 
#> [[3]]
#> [[3]]$event_id
#> [1] 1328515
#> 
#> [[3]]$event_name
#> [1] "SUBDUB - Iration Steppas, King Alpha, Oneness Sound System Paradox, Dj Storm & Kid Drama"
#> 
#> [[3]]$event_date
#> [1] "2019-10-19"
#> 
#> 
#> [[4]]
#> [[4]]$event_id
#> [1] 1283977
#> 
#> [[4]]$event_name
#> [1] "SUBDUB - 21st Birthday Part 2 / Deep Medi"
#> 
#> [[4]]$event_date
#> [1] "2019-09-28"
#> 
#> 
#> [[5]]
#> [[5]]$event_id
#> [1] 1214355
#> 
#> [[5]]$event_name
#> [1] "SUBDUB - Iration Steppas, Youngsta, Om Unit"
#> 
#> [[5]]$event_date
#> [1] "2019-02-08"
#> 
#> 
#> [[6]]
#> [[6]]$event_id
#> [1] 1164951
#> 
#> [[6]]$event_name
#> [1] "Subdub - Leeds West Indian Centre"
#> 
#> [[6]]$event_date
#> [1] "2018-10-06"
```
