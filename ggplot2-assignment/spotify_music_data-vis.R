# Bruno Salgado, 09/16/20
# FE-550, Fall 2020
# This script reads data from the top 10 songs on Spotify from 2010 to 2019 and 
# presents the data in 3 different visualization formats

# Load library and data
library(ggplot2)
library(plyr) # To count frequencies
spotify_data <- read.csv("top10s_spotify_2010-2019.csv", header = TRUE)
df <- data.frame(spotify_data)

# Genre frequency, for all data
ggplot(data = df, mapping = aes(x = top.genre)) + 
  geom_bar() + 
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  labs(title = "Genre Frequency (2010-2019)")

# BPM by year
ggplot(data = df, mapping = aes(x = bpm, y = year)) +
  geom_point() +
  labs(title = "Beats Per Minute (BPM) vs. Year")

# "Danceability" vs. dB
ggplot(data = df, mapping = aes(x = dB, y = dnce)) +
  geom_jitter() +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  labs(title = "\"Danceability\" vs. Loudness (dB)")