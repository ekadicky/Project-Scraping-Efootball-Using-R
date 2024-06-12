# Memuat library yang akan digunakan
library(rvest)
library(tidyverse)
library(mongolite)

# Masukkan link atau alamat website yang akan discraping
alamatweb <- 'https://pesdb.net/efootball/?mode=authentic&featured=0'
lamanweb <- read_html(alamatweb)

# Mengambil tabel/data yang diinginkan
tabel <- lamanweb %>% html_nodes(".players") %>% html_table()

# Membentuk dataframe
tabeldf <- data.frame(tabel)

# Memilih satu baris data secara acak
pilih <- sample(1:32,1,replace=F)
player_terpilih <- tabeldf[pilih,]

# Koneksi ke MongoDB untuk memasukkan data
atlas_conn <- mongo(
  collection = Sys.getenv("ATLAS_COLLECTION"),
  db         = Sys.getenv("ATLAS_DB"),
  url        = Sys.getenv("ATLAS_URL")
)

atlas_conn$insert(player_terpilih)
rm(atlas_conn)
