library(networkD3)
library(tidyr)

# load data
budget_data <- read.csv('budget_2010_2019_cleaned.csv')

# create nodes dataframe
programs <- unique(as.character(budget_data$Program))
categories <- unique(as.character(budget_data$Category))

nodes <- data.frame(node = c(0:104),
                    name = c(programs, categories))

#create links dataframe
budget_data <- merge(budget_data, nodes, by.x = "Program", by.y = "name")
budget_data <- merge(budget_data, nodes, by.x = "Category", by.y = "name")
links <- budget_data[ , c("node.x", "node.y", "Revenue")]
colnames(links) <- c("source", "target", "value")

# draw sankey network
networkD3::sankeyNetwork(Links = links, Nodes = nodes, 
                         Source = 'source', 
                         Target = 'target', 
                         Value = 'value', 
                         NodeID = 'name',
                         units = 'dollars')