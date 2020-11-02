# Bruno Salgado, 10/28/20
# FE-550, Fall 2020
#
# This script reads guppy body length data in order to construct network graphs
# and demonstrate command of network graph types and the techniques associated
# with constructing them

# Load library and data
library(tidyverse)
library(tidygraph)
library(ggraph)
data_filename <- "fish-guppy-familiar-1.edges"
guppy_data <- read.table(data_filename, skip = 1)

# Clean up data
guppy_data <- 
  rename(guppy_data,
         source = V1,
         destination = V2,
         weight = V3)

# Create network nodes
sources <- guppy_data %>%
  distinct(source) %>%
  rename(label = source)

destinations <- guppy_data %>%
  distinct(destination) %>%
  rename(label = destination)

weights <- guppy_data %>%
  distinct(weight) %>%
  rename(label = weight)

# Conjoin sources and destinations into a single dataframe
nodes <- full_join(sources, destinations, by = "label")
nodes <- nodes %>% rowid_to_column("id")

# Create network edges
per_route <- guppy_data %>%
  group_by(source, destination) %>%
  summarise(weight = n()) %>%
  ungroup()

edges <- per_route %>%
  left_join(nodes, by = c("source" = "label")) %>%
  rename(from = id)

edges <- edges %>%
  left_join(nodes, by = c("destination" = "label")) %>%
  rename(to = id)

edges <- select(edges, from, to, weight)

# Construct graph plot
routes_tidy <- tbl_graph(nodes = nodes, edges = edges)

routes_tidy %>%
  activate(edges) %>%
  arrange(desc(weight))

# Network Topology
ggraph(routes_tidy, layout = "kk") + 
  geom_edge_link(aes(label = weight, colour = weight),
                 angle_calc = "along",
                 label_dodge = unit(2.5, "mm")) + 
  geom_node_point() + 
  theme_graph() + 
  geom_node_label(aes(label = label)) + 
  labs(edge_width = "Letters")

# Arc Graph
ggraph(routes_tidy, layout = "linear") +
  geom_edge_arc() +
  geom_node_text(aes(label = label)) +
  geom_node_label(aes(label = label)) + 
  geom_edge_link(aes(color = "Dark2")) +
  theme_graph()
