## Scrape the list of most populat TV shows from https://www.imdb.com/chart/tvmeter

# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# read in http://www.imdb.com/chart/tvmeter ------------------------------------

page <- read_html("https://www.imdb.com/chart/tvmeter")

# years ------------------------------------------------------------------------

years <- page %>%
  html_nodes("a+ .secondaryInfo") %>%
  html_text() %>% 
  str_remove("\\(") %>% 
  str_remove("\\)") %>% 
  as.numeric()

# scores -----------------------------------------------------------------------

scores <- page %>%
  html_nodes(".imdbRating") %>% 
  html_text() %>% 
  as.numeric()

# names ------------------------------------------------------------------------

names <- page %>% 
  html_nodes(".titleColumn a") %>% 
  html_text() %>% 
  str_remove_all("\n") %>% 
  str_squish()
  

# tvshows dataframe ------------------------------------------------------------

tvshows <- tibble(
  rank = 1:100,
  scores = scores,
  names = names,
  years = years
)

# add new variables ------------------------------------------------------------

tvshows <- tvshows %>%
  mutate(
    genre = NA,
    runtime = NA,
    n_episode = NA,
  )

# add new info for first show --------------------------------------------------

tvshows$genre[1] <- "Horror"
tvshows$runtime[1] <- "300"
tvshows$n_episode[1] <- "12"

# add new info for second show --------------------------------------------------

tvshows$genre[2] <- "Action"
tvshows$runtime[2] <- "320"
tvshows$n_episode[2] <- "5"

# add new info for third show --------------------------------------------------

tvshows$genre[3] <- "Fantasy"
tvshows$runtime[3] <- "500"
tvshows$n_episode[3] <- "15"

