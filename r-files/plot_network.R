# Copyright (C) 2015 Dawn M. Foster
# Licensed under GNU General Public License (GPL), version 3 or later: 
# http://www.gnu.org/licenses/gpl.txt

# Load the igraph package using the library command - you may need to install it first
# Install using command: install.packages("igraph")

library(igraph)

# Load the data into a data frame (comma separated with a header line)

mailing_list<-read.csv("~/gitrepos/linuxcon_2015/data/network_output.csv", sep=',', 
                                    header=TRUE)

# Look at data and verify that it looks good

mailing_list

# Simplify converts it into a simple graph that does not have loops or duplicate
# connections (edges) between people. Count multiple edges to get a number that 
# represents the number of times person a replied to person b as the weight.

mailing_list.graphw <- simplify(mailing_list.graph, count.multiple(mailing_list.graph))

# Use help function to learn more about any of these commands ?whatever. Example:
?simplify

# Default plot - not great looking

plot(mailing_list.graphw)

# Interactive graph using tkplot that uses the weights calculated above to make
# the arrows between people (edges) wider depending on how many times one person has
# replied to another. The circles (nodes) representing each person become larger the
# more connections that person has to others within the network (degree centrality).

tkplot(mailing_list.graphw, vertex.label.color="black", edge.color="darkslategray",
       edge.width=E(mailing_list.graphw)$weight/3, edge.arrow.size=.5, 
       vertex.size=degree(mailing_list.graphw))

# export a format of the data with weights that can be imported into other 
# visualization sw

write.graph(mailing_list.graphw, "/tmp/network.dot", format=c("dot"))

# STOP here. The stuff below is just bonus material for those who want a couple 
# other alternatives.
###################







# A second tkplot using betweenness centrality (another measure)

tkplot(mailing_list.graphw, vertex.label.color="black", edge.color="darkslategray",
       edge.width=E(mailing_list.graphw)$weight/3, edge.arrow.size=.5, 
       vertex.size=betweenness(mailing_list.graph)^.5)

# Static Plot for reference - it's hard to make these look awesome.

plot.igraph(mailing_list.graphw,vertex.label=V(mailing_list.graph)$name,
            layout=layout.fruchterman.reingold, vertex.size=20, 
            vertex.label.color="black",
            edge.color="black",edge.width=E(mailing_list.graphw)$weight/3, 
            edge.arrow.size=.1)
