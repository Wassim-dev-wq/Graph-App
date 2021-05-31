import networkx as nx
import matplotlib.pyplot as plt
from networkx.classes.function import nodes
import sys


class Graph:
    def __init__(self):
        self.G = nx.Graph() 
        self.addEdges()
        self.kruskal()


    def addEdges(self):
        self.G.add_nodes_from([0,1,2,3,4])
        self.G.add_weighted_edges_from([ (0, 1, 4),(0, 2, 4), (0, 3, 6), (0, 4, 6), (1, 2, 2),(2,3,8),(3,4,6)])
        print(self.G.get_edge_data(1, 1))
    

    def kruskalInite(self,thisdict,visited):
        # G.edges.data() retourne une liste des chemins avec leurs poids dans un dictionnaire, lamba fetch chaque tuple et compare le avec les poids
        #si n'a pas de poid dans le chemin retourne 1
        for i in list(self.G.nodes):
            thisdict[i] = [None,sys.maxsize]
        edgesSorted=sorted(self.G.edges.data(), key=lambda t: t[2].get('weight', 1))
        while len(edgesSorted) != 0:
            if edgesSorted[0][0] not in visited and edgesSorted[0][1] not in visited:
                thisdict[edgesSorted[0][1]] = [edgesSorted[0][0],edgesSorted[0][2].get('weight')]
                visited.append(edgesSorted[0][1])
            edgesSorted.pop(0)
        return thisdict

    def drawGraph(self,thisdict):
        all_edges = set(tuple(sorted((n1, n2))) for n1, n2 in self.G.edges()) 
        edgesList = [] 
        print(thisdict.items())
        for key ,value in thisdict.items():
            if value[0] !=None:
                edgesList.append(tuple([key,value[0]]))       
        mst_edge = set(tuple(sorted((n1, n2))) for n1, n2 in edgesList) 
        print(mst_edge)
        pos=nx.circular_layout(self.G) 
        nx.draw_networkx_nodes(self.G, pos, node_size=500) 
        nx.draw_networkx_labels(self.G, pos) 
        nx.draw_networkx_edges(
        self.G, pos, edgelist=all_edges-mst_edge, alpha=0.4,   
        edge_color='skyblue', width=1)
        nx.draw_networkx_edges(
        self.G, pos, edgelist=mst_edge, alpha=1.0, 
        edge_color='skyblue', width=3)
        plt.savefig("path.png")
        plt.show() 

    def kruskal(self):
        thisdict = {}
        visited= []
        self.kruskalInite(thisdict,visited)
        self.drawGraph(thisdict)

if __name__ == "__main__":
    main = Graph()


