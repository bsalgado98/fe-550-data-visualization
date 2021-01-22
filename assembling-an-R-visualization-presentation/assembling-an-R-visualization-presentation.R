# Bruno Salgado, 01/31/21
# FE-550, Fall 2020
# This script shows relationships between time spent during COVID-19 lockdowns
# in different countries and Google search terms for various mental health topics

# Load library and data
library(ggplot2)
library(dplyr)
library(readxl)
library(wesanderson)
require(maps)
data_us <- read_excel("search_term_us.xlsx")
data_ca <- read_excel("search_term_canada.xlsx")
data_uk <- read_excel("search_term_uk.xlsx")

df_us <- data.frame(data_us)
df_ca <- data.frame(data_ca)
df_uk <- data.frame(data_uk)

us <- ggplot(df_us, aes(x = Week, y = depression)) +
  geom_point(color=wes_palettes$FantasticFox1[5]) +
  geom_smooth(method = lm, color = wes_palettes$FantasticFox1[4],
              fill=wes_palettes$FantasticFox1[3]) +
  labs(title = "U.S. Depression Search Interest")

us

ca <- ggplot(df_ca, aes(x = Week, y = depression)) +
  geom_point(color=wes_palettes$FantasticFox1[5]) +
  geom_smooth(method = lm, color = wes_palettes$FantasticFox1[4],
              fill=wes_palettes$FantasticFox1[3]) +
  labs(title = "Canada Depression Search Interest")

ca

uk <- ggplot(df_uk, aes(x = Week, y = depression)) +
  geom_point(color=wes_palettes$FantasticFox1[5]) +
  geom_smooth(method = lm, color = wes_palettes$FantasticFox1[4],
              fill=wes_palettes$FantasticFox1[3]) +
  labs(title = "U.K. Depression Search Interest")

uk

us_psy <- ggplot(df_us, aes(x = Week, y = anxiety, fill = psychiatrist)) +
  geom_tile() +
  scale_fill_gradientn(colors = wes_palette("FantasticFox1", type="continuous")) +
  labs(title = "U.S. Anxiety and Psychiatrist Search Interest")

us_psy

ca_psy <- ggplot(df_ca, aes(x = Week, y = anxiety, fill = psychiatrist)) +
  geom_tile() +
  scale_fill_gradientn(colors = wes_palette("FantasticFox1", type="continuous")) +
  labs(title = "Canada Anxiety and Psychiatrist Search Interest")

ca_psy

uk_psy <- ggplot(df_uk, aes(x = Week, y = anxiety, fill = psychiatrist)) +
  geom_tile() +
  scale_fill_gradientn(colors = wes_palette("FantasticFox1", type="continuous")) +
  labs(title = "U.K. Anxiety and Psychiatrist Search Interest")

uk_psy