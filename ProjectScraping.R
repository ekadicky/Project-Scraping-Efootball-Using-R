library(rvest)
library(tidyverse)
library(mongolite)

alamatweb <- 'https://pesdb.net/efootball/?mode=authentic&featured=0'
lamanweb <- read_html(alamatweb)

tabel <- lamanweb %>% html_nodes(".players") %>% html_table()
tabeldf <- data.frame(tabel)

pilih <- sample(1:32,1,replace=F)
player <- tabeldf[pilih,]

atlas_conn <- mongo(
  collection = Sys.getenv("ATLAS_COLLECTION"),
  db         = Sys.getenv("ATLAS_DB"),
  url        = Sys.getenv("ATLAS_URL")
)

atlas_conn$insert(player)
rm(atlas_conn)