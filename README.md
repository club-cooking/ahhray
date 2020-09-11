
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ahhray

…

## Installation

You can install the released version of ahhray from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("ahhray")
```

And the development version from [GitHub](https://github.com/) with:

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
#> [1] "The Brixton Courtyard"
#> 
#> $promoters[[1]]$promoter_id
#> [1] 98479
```

Get event regions listed:

``` r
ra_get_regions()
#>   [1] "albania"                      "algeria"                     
#>   [3] "andorra"                      "angola"                      
#>   [5] "antiguaandbarbuda"            "argentina"                   
#>   [7] "buenosaires"                  "armenia"                     
#>   [9] "australiancapitalterritory"   "canberra"                    
#>  [11] "newsouthwales"                "sydney"                      
#>  [13] "northernterritory"            "darwin"                      
#>  [15] "queensland"                   "brisbane"                    
#>  [17] "southaustralia"               "adelaide"                    
#>  [19] "tasmania"                     "hobart"                      
#>  [21] "victoria"                     "melbourne"                   
#>  [23] "westernaustralia"             "perth"                       
#>  [25] "austria"                      "vienna"                      
#>  [27] "azerbaijan"                   "bahamas"                     
#>  [29] "bahrain"                      "bangladesh"                  
#>  [31] "barbados"                     "belarus"                     
#>  [33] "belgium"                      "antwerp"                     
#>  [35] "brussels"                     "belize"                      
#>  [37] "benin"                        "bermuda"                     
#>  [39] "bhutan"                       "bolivia"                     
#>  [41] "bosniaandherzegovina"         "botswana"                    
#>  [43] "brazil"                       "riodejaneiro"                
#>  [45] "saopaulo"                     "bulgaria"                    
#>  [47] "burkinafaso"                  "cambodia"                    
#>  [49] "cameroon"                     "atlanticprovinces"           
#>  [51] "calgary"                      "edmonton"                    
#>  [53] "montreal"                     "ottawa"                      
#>  [55] "prairies"                     "quebec"                      
#>  [57] "toronto"                      "vancouver"                   
#>  [59] "windsor"                      "caymanislands"               
#>  [61] "chile"                        "santiago"                    
#>  [63] "beijing"                      "changsha"                    
#>  [65] "chengdu"                      "chongqing"                   
#>  [67] "guangzhou"                    "hangzhou"                    
#>  [69] "hongkong"                     "jinan"                       
#>  [71] "kunming"                      "macau"                       
#>  [73] "nanjing"                      "qingdao"                     
#>  [75] "quanzhou"                     "shanghai"                    
#>  [77] "shenyang"                     "shenzhen"                    
#>  [79] "suzhou"                       "tianjin"                     
#>  [81] "wuhan"                        "Xian"                        
#>  [83] "xiamen"                       "colombia"                    
#>  [85] "bogota"                       "cali"                        
#>  [87] "Medellin"                     "costarica"                   
#>  [89] "cotedIvoire"                  "croatia"                     
#>  [91] "cuba"                         "curacao"                     
#>  [93] "cyprus"                       "czechrepublic"               
#>  [95] "prague"                       "democraticrepublicofthecongo"
#>  [97] "denmark"                      "aarhus"                      
#>  [99] "copenhagen"                   "dominicanrepublic"           
#> [101] "ecuador"                      "egypt"                       
#> [103] "elsalvador"                   "estonia"                     
#> [105] "ethiopia"                     "fiji"                        
#> [107] "finland"                      "helsinki"                    
#> [109] "central"                      "east"                        
#> [111] "frenchriviera"                "north"                       
#> [113] "paris"                        "southeast"                   
#> [115] "lyon"                         "marseille"                   
#> [117] "montpellier"                  "southwest"                   
#> [119] "frenchwestindies"             "west"                        
#> [121] "gambia"                       "georgia"                     
#> [123] "batumi"                       "tbilisi"                     
#> [125] "badenwurttemberg"             "freiburg"                    
#> [127] "heidelberg"                   "karlsruhe"                   
#> [129] "mannheim"                     "stuttgart"                   
#> [131] "bavaria"                      "augsburg"                    
#> [133] "munich"                       "nurnberg"                    
#> [135] "regensburg"                   "berlin"                      
#> [137] "brandenburg"                  "bremen"                      
#> [139] "hamburg"                      "hesse"                       
#> [141] "darmstadt"                    "frankfurt"                   
#> [143] "kassel"                       "lowersaxony"                 
#> [145] "hannover"                     "mecklenburgvorpommern"       
#> [147] "northrhinewestphalia"         "bielefeld"                   
#> [149] "bochum"                       "cologne"                     
#> [151] "dortmundessen"                "dusseldorf"                  
#> [153] "munster"                      "rhinelandpalatinate"         
#> [155] "saarland"                     "saxony"                      
#> [157] "chemnitz"                     "dresden"                     
#> [159] "leipzig"                      "saxonyanhalt"                
#> [161] "schleswigholstein"            "thuringia"                   
#> [163] "erfurt"                       "jena"                        
#> [165] "ghana"                        "gibraltar"                   
#> [167] "greece"                       "guam"                        
#> [169] "guatemala"                    "honduras"                    
#> [171] "hungary"                      "budapest"                    
#> [173] "iceland"                      "bangalore"                   
#> [175] "chennai"                      "delhi"                       
#> [177] "goa"                          "hyderabad"                   
#> [179] "kolkata"                      "mumbai"                      
#> [181] "otherregions"                 "pune"                        
#> [183] "indonesia"                    "iran"                        
#> [185] "ireland"                      "cork"                        
#> [187] "dublin"                       "galway"                      
#> [189] "limerick"                     "israel"                      
#> [191] "telaviv"                      "central"                     
#> [193] "florence"                     "rome"                        
#> [195] "north"                        "bologna"                     
#> [197] "milan"                        "turin"                       
#> [199] "venice"                       "sicily"                      
#> [201] "south"                        "naples"                      
#> [203] "jamaica"                      "chubu"                       
#> [205] "chugoku"                      "hokkaido"                    
#> [207] "kansai"                       "kanto"                       
#> [209] "kyushu"                       "okinawa"                     
#> [211] "shikoku"                      "tohoku"                      
#> [213] "tokyo"                        "jordan"                      
#> [215] "kazakhstan"                   "kenya"                       
#> [217] "kosovo"                       "kuwait"                      
#> [219] "laos"                         "latvia"                      
#> [221] "lebanon"                      "lithuania"                   
#> [223] "luxembourg"                   "macedonia"                   
#> [225] "madagascar"                   "malawi"                      
#> [227] "kualalumpur"                  "maldives"                    
#> [229] "malta"                        "mauritius"                   
#> [231] "center"                       "mexicocity"                  
#> [233] "north"                        "south"                       
#> [235] "moldova"                      "monaco"                      
#> [237] "mongolia"                     "montenegro"                  
#> [239] "morocco"                      "mozambique"                  
#> [241] "myanmar"                      "nepal"                       
#> [243] "amsterdam"                    "eindhoven"                   
#> [245] "otherregions"                 "rotterdam"                   
#> [247] "thehague"                     "utrecht"                     
#> [249] "newzealand"                   "nicaragua"                   
#> [251] "nigeria"                      "norway"                      
#> [253] "bergen"                       "oslo"                        
#> [255] "oman"                         "pakistan"                    
#> [257] "palestine"                    "panama"                      
#> [259] "paraguay"                     "peru"                        
#> [261] "philippines"                  "poland"                      
#> [263] "krakow"                       "warsaw"                      
#> [265] "algarve"                      "lisbon"                      
#> [267] "other"                        "porto"                       
#> [269] "puertorico"                   "qatar"                       
#> [271] "romania"                      "bucharest"                   
#> [273] "cluj-napoca"                  "iasi"                        
#> [275] "krasnodar"                    "moscow"                      
#> [277] "restofrussia"                 "saintpetersburg"             
#> [279] "rwanda"                       "saintkittsandnevis"          
#> [281] "saintlucia"                   "saintmartin"                 
#> [283] "samoa"                        "saudiarabia"                 
#> [285] "senegal"                      "serbia"                      
#> [287] "seychelles"                   "singapore"                   
#> [289] "slovakia"                     "slovenia"                    
#> [291] "somalia"                      "capetown"                    
#> [293] "durban"                       "johannesburg"                
#> [295] "otherregions"                 "southkorea"                  
#> [297] "southsudan"                   "barcelona"                   
#> [299] "canaryislands"                "east"                        
#> [301] "ibiza"                        "madrid"                      
#> [303] "north"                        "south"                       
#> [305] "srilanka"                     "streamland"                  
#> [307] "sudan"                        "sweden"                      
#> [309] "othenburg"                    "malmo"                       
#> [311] "stockholm"                    "switzerland"                 
#> [313] "basel"                        "bern"                        
#> [315] "geneva"                       "lausanne"                    
#> [317] "zurich"                       "taiwan"                      
#> [319] "taipei"                       "all"                         
#> [321] "tanzania"                     "thailand"                    
#> [323] "bangkok"                      "trinidadandtobago"           
#> [325] "tunisia"                      "turkey"                      
#> [327] "ankara"                       "istanbul"                    
#> [329] "izmir"                        "uganda"                      
#> [331] "ukraine"                      "abudhabi"                    
#> [333] "dubai"                        "london"                      
#> [335] "midlands"                     "north"                       
#> [337] "leeds"                        "liverpool"                   
#> [339] "manchester"                   "newcastle"                   
#> [341] "northernireland"              "scotland"                    
#> [343] "aberdeen"                     "edinburgh"                   
#> [345] "glasgow"                      "southeast"                   
#> [347] "westwales"                    "bristol"                     
#> [349] "alabama"                      "alaska"                      
#> [351] "arizona"                      "arkansas"                    
#> [353] "california"                   "losangeles"                  
#> [355] "sacramento"                   "sandiego"                    
#> [357] "sanfrancisco"                 "colorado"                    
#> [359] "connecticut"                  "delaware"                    
#> [361] "florida"                      "jacksonville"                
#> [363] "miami"                        "orlando"                     
#> [365] "tampabay"                     "georgia"                     
#> [367] "hawaii"                       "idaho"                       
#> [369] "illinois"                     "chicago"                     
#> [371] "indiana"                      "iowa"                        
#> [373] "kansas"                       "kentucky"                    
#> [375] "louisiana"                    "maine"                       
#> [377] "maryland"                     "massachusetts"               
#> [379] "michigan"                     "detroit"                     
#> [381] "minnesota"                    "mississippi"                 
#> [383] "missouri"                     "montana"                     
#> [385] "nebraska"                     "nevada"                      
#> [387] "newhampshire"                 "newjersey"                   
#> [389] "newmexico"                    "newyork"                     
#> [391] "buffalorochester"             "northcarolina"               
#> [393] "northdakota"                  "ohio"                        
#> [395] "oklahoma"                     "oregon"                      
#> [397] "portland"                     "pennsylvania"                
#> [399] "rhodeisland"                  "southcarolina"               
#> [401] "southdakota"                  "tennessee"                   
#> [403] "texas"                        "austin"                      
#> [405] "dallasfortworth"              "elpaso"                      
#> [407] "houston"                      "sanantonio"                  
#> [409] "utah"                         "vermont"                     
#> [411] "virginia"                     "washingtondc"                
#> [413] "washingtonstate"              "seattle"                     
#> [415] "westvirginia"                 "wisconsin"                   
#> [417] "wyoming"                      "uruguay"                     
#> [419] "montevideo"                   "uzbekistan"                  
#> [421] "venezuela"                    "vietnam"                     
#> [423] "zimbabwe"
```

Get events that took place in a region, within a particular month:

``` r
ra_get_region_events(country = "morocco", year = 2020, month = 9)
#> [[1]]
#> [[1]]$event_id
#> [1] 1395741
#> 
#> [[1]]$event_name
#> [1] "[POSTPONED] Oasis Festival 2020"
#> 
#> [[1]]$event_date
#> [1] "2020-09-11" "2020-09-13"
#> 
#> [[1]]$venue_id
#> numeric(0)
#> 
#> [[1]]$venue_name
#> character(0)
#> 
#> [[1]]$artists
#> list()
#> 
#> [[1]]$promoters
#> [[1]]$promoters[[1]]
#> [[1]]$promoters[[1]]$promoter_name
#> [1] "Oasis Festival "
#> 
#> [[1]]$promoters[[1]]$promoter_id
#> [1] 52050
#> 
#> 
#> 
#> 
#> [[2]]
#> [[2]]$event_id
#> [1] 1395741
#> 
#> [[2]]$event_name
#> [1] "[POSTPONED] Oasis Festival 2020"
#> 
#> [[2]]$event_date
#> [1] "2020-09-11" "2020-09-13"
#> 
#> [[2]]$venue_id
#> numeric(0)
#> 
#> [[2]]$venue_name
#> character(0)
#> 
#> [[2]]$artists
#> list()
#> 
#> [[2]]$promoters
#> [[2]]$promoters[[1]]
#> [[2]]$promoters[[1]]$promoter_name
#> [1] "Oasis Festival "
#> 
#> [[2]]$promoters[[1]]$promoter_id
#> [1] 52050
#> 
#> 
#> 
#> 
#> [[3]]
#> [[3]]$event_id
#> [1] 1395741
#> 
#> [[3]]$event_name
#> [1] "[POSTPONED] Oasis Festival 2020"
#> 
#> [[3]]$event_date
#> [1] "2020-09-11" "2020-09-13"
#> 
#> [[3]]$venue_id
#> numeric(0)
#> 
#> [[3]]$venue_name
#> character(0)
#> 
#> [[3]]$artists
#> list()
#> 
#> [[3]]$promoters
#> [[3]]$promoters[[1]]
#> [[3]]$promoters[[1]]$promoter_name
#> [1] "Oasis Festival "
#> 
#> [[3]]$promoters[[1]]$promoter_id
#> [1] 52050
```
