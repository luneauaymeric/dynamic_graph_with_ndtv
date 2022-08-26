
library(sna)
library(ndtv)
library(tsna)

#save(static_edge, static_node, dynamic_edge, dynamic_node, file = "issued_networkdynamic.RData")

load("issued_networkdynamic.RData")

static_node <- static_node[,0:2]

net <- network(static_edge,
  vertex.attr = static_node,
  directed = TRUE,
  bipartite = FALSE,
  multiple = FALSE,
  loops = FALSE
)


dynamic_edge <- dynamic_edge[,0:7]

dynet <- networkDynamic(
  net,
  edge.spells = dynamic_edge,
  vertex.spells = dynamic_node,
  #create.TEAs = TRUE
)

# Here we can see that there are 30 new edges => why ?
t <- as.data.frame(dynet)

timeline(dynet)

# reconcile.edge.activity allows to correct conflicts between edges and vertices, but there are still edges which did not exist in the original edgelist

reconcile.edge.activity(net = dynet, mode = "reduce.to.vertices", active.default = TRUE)
render.d3movie(dynet, 
               animation.mode='kamadakawai',
               usearrows = T,
               displaylabels = T, label= "vertex.id")


               
