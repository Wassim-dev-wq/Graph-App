#https://networkx.org/documentation/stable/tutorial.html#drawing-graphs Documentation
#https://www.youtube.com/watch?v=QN6Ag7vxT8Q&t=2525s&ab_channel=HussamHourani Video that might help

import networkx as nx
import matplotlib.pyplot as plt

# Declarer un graph
G = nx.Graph()

#Ajouter tous les sommets dans un seul coup
G.add_nodes_from([1,2,3,4])

#Ajouter les chemins avec leurs poids dans un seul coup
G.add_weighted_edges_from([(1, 2, 3), (1, 3, 2), (1, 5, 4), (2, 3, 8), (3, 4, 1), (4, 5, 3)])

pos=nx.spring_layout(G)
#dessiner le graph
nx.draw_networkx(G,pos)

#l'ajout des poids au graph
labels = nx.get_edge_attributes(G,'weight')
nx.draw_networkx_edge_labels(G,pos,edge_labels=labels)

#sauvegarder le graph sous un fichier path.png
plt.savefig("path.png")

#afficher le graph
plt.show()