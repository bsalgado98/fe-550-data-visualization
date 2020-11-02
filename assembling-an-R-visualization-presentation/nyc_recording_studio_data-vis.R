# Bruno Salgado, 09/30/20
# FE-550, Fall 2020
# This script generates an RMarkdown presentation based off of NYC-based data
# which presents a list of recording studios around the city.

# Load library and data
library(ggplot2)
nyc_production_studio_data_file <- "Production_studio_map.csv"
nyc_production_studio_data <- read.csv(nyc_production_studio_data_file,
                                       header = TRUE)

# Parse csv file into data frame
df <- data.frame(studio_name = nyc_production_studio_data$Studio.Name,
                 studio_long = nyc_production_studio_data$Longitude, 
                 studio_lat = nyc_production_studio_data$Latitude)
states_map <- map_data("state")

#usa <- map_data("usa")
#ggplot() + geom_polygon(data = usa, aes(x = long, y = lat, group = group)) +
  #coord_fixed(1.3)

ggplot(data = df, aes(fill = studio_name)) +
  geom_map(aes(map_id = studio_name), map = states_map)
  #expand_limits(x = df$studio_long, y = df$studio_lat)

#ggplot(data = df, aes(fill = df.Location.1)) + 
  #geom_map(aes(map_id = state), map = df) +
  #expand_limits(x = df$Latitude, y = df$Longitude, id = state)