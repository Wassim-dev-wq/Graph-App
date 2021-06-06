import networkx as nx
import matplotlib.pyplot as plt
from networkx.classes.function import nodes
import sys


class Graph:
    def __init__(self):
        self.G = nx.Graph() 
        self.addEdges()
        self.djikstraInit(2,5)


    def addEdges(self):
        self.G.add_nodes_from([0,1,2,3,4,5])
        self.G.add_weighted_edges_from([ (0, 1, 2),(0, 2, 4), (1, 2, 1), (1, 3, 4), (1, 4, 2),(2,4,3),(3,4,1),(3,5,2),(4,5,2)])
        print(self.G.get_edge_data(1, 1))
    

    def djikstraInit(self,source,destination):
        # G.edges.data() retourne une liste des chemins avec leurs poids dans un dictionnaire, lamba fetch chaque tuple et compare le avec les poids
        #si n'a pas de poid dans le chemin retourne 1
        thisdict = {}
        visited= []
        for i in list(self.G.nodes):
            thisdict[i] = [None,sys.maxsize]
            thisdict[source] = [-1,0]
        for i in list(self.G.nodes):
            adjNode = list(self.G.adj[i])
            for j in adjNode:
                if j not in visited:
                    weight = self.G.get_edge_data(i,j).get('weight')
                    lastweight = thisdict.get(i)[1]
                    weight = weight + lastweight
                    if  weight < thisdict.get(j)[1]:
                        thisdict[j]=[i,weight]
                        lastweight= weight
            visited.append(i)
        chemin = []
        x=0
        poidChemin = 0
        olddest = destination
        chemin.append(destination)
        while( x!=-1):
            for key, value in thisdict.items():
                if key == destination:
                    e = thisdict.get(key)[0]
                    poidChemin = poidChemin + thisdict.get(key)[1]
                    if e != -1:
                        chemin.append(e)
                        destination = e
                        print(e)
                    else: x =-1
        print(thisdict)
        data = " ".join(map(str,chemin[::-1]))
        data = data.replace(' ',' -> ')
        
        print('Le poid du plus court chemin de '+str(source)+' a '+str(olddest)+ ' est ' + str(thisdict.get(3)[1]) +'.')
        print('Le plus court chemin de '+str(source)+' a '+str(olddest)+ ' est ' + data , " et son poid est "+ str(poidChemin))


    def djikstra(self):
        thisdict = {}
        visited= []
        self.djikstraInit(0,5,thisdict,visited)

if __name__ == "__main__":
    main = Graph()




    # # def drawGraph(self,thisdict):
    # #     all_edges = set(tuple(sorted((n1, n2))) for n1, n2 in self.G.edges()) 
    # #     edgesList = [] 
    # #     print(thisdict.items())
    # #     for key ,value in thisdict.items():
    # #         if value[0] !=None:
    # #             edgesList.append(tuple([key,value[0]]))       
    # #     mst_edge = set(tuple(sorted((n1, n2))) for n1, n2 in edgesList) 
    # #     print(mst_edge)
    # #     pos=nx.circular_layout(self.G) 
    # #     nx.draw_networkx_nodes(self.G, pos, node_size=500) 
    # #     nx.draw_networkx_labels(self.G, pos) 
    # #     nx.draw_networkx_edges(
    # #     self.G, pos, edgelist=all_edges-mst_edge, alpha=0.4,   
    # #     edge_color='skyblue', width=1)
    # #     nx.draw_networkx_edges(
    # #     self.G, pos, edgelist=mst_edge, alpha=1.0, 
    # #     edge_color='skyblue', width=3)
    # #     plt.savefig("path.png")
    # #     plt.show() 