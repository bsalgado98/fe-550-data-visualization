# Bruno Salgado, 01/31/21
# FE-550, Fall 2020
# This script generates various network diagrams based off of technology tags 
# on Stack Overflow posts.

# library(devtools)
# library(arcdiagram)

library(ggplot2)
library(readr)
library(igraph)
library(ggraph)
library(tidyverse)

nodes <- read.csv("./stack_network_nodes.csv")
edges <- read.csv("./stack_network_links.csv")

graph <- graph_from_data_frame(d = edges, vertices = nodes, directed = FALSE)

E(graph)
V(graph)

table(head_of(graph, E(graph)))
V(graph)$degree <- degree(graph)
gorder(graph)

plot(graph, vertex.color = rainbow(52),
     vertex.label = V(graph)$name,
     vertex.size = V(graph)$degree,
     vertex.label.cex = 0.5,
     vertex.label.color = "black",
     layout = layout.kamada.kawai(graph)
     )

par(mfrow=c(1,2))
gr <- make_ego_graph(graph, diameter(graph), nodes = 'r', mode = c("all"))[[1]]
dists <- distances(gr, "r")
colors <- c("black", "red", "orange", "blue", "dodgerblue", "cyan")
V(gr)$color <- colors[dists+1]
plot(gr, 
     vertex.label = dists, 
     vertex.label.color = "white",
     vertex.label.cex = .8,
     edge.color = 'black',
     vertex.size = 7,
     edge.arrow.size = .05,
)

ggraph(graph, layout = "fr") +
  geom_edge_link(aes(width = value), show.legend = FALSE, alpha = 0.5) +
  geom_node_point(aes(color = factor(group), size = nodesize * 30)) +
  geom_node_text(aes(label = name), repel = TRUE, size = 8)

ggraph(graph, layout = "linear") +
  geom_edge_arc() +
  geom_node_point(aes(color = factor(group))) +
  geom_node_text(aes(label = name, angle = 90, hjust = "right"))

