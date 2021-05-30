import networkx as nx
import matplotlib.pyplot as plt
from networkx.classes.function import nodes
import sys

class Graph:
    def __init__(self):
        self.G = nx.Graph()         
        self.edgesDict = {}
        self.addEdges()
        self.thisdict = {}
        self.visited= []
        self.unvisited = list(self.G.nodes)
        self.index=int(input("Entrer l'index source "))
        self.all_edges = set(tuple(sorted((n1, n2))) for n1, n2 in self.G.edges())
        self.minPrim()

    def addEdges(self):
    # Declarer un graph
        #Ajouter tous les sommets dans un seul copy
        self.G.add_nodes_from([0,1,2,3,4,5,6,7])
        self.G.add_weighted_edges_from([(0, 1, 2), (0, 3, 4), (1, 3, 4),(1, 5, 2), (1, 6, 1), (3, 5, 3), (5, 7, 8), (6, 2, 2), (2, 4, 3), (4, 7, 7)])




    def drawGraph(self):
        edgesList = []
        for key ,value in self.edgesDict.items():
            if value[0] !=-1:
                edgesList.append(tuple(value))            
        # mst_edge = set(tuple(sorted((n1, n2))) for n1, n2 in self.G.edges())*
        mst_edge = set(tuple(sorted((n1, n2))) for n1, n2 in edgesList)  
        pos=nx.circular_layout(self.G)         
        nx.draw_networkx_nodes(self.G, pos, node_size=500)
        nx.draw_networkx_labels(self.G, pos)
        nx.draw_networkx_edges(
        self.G, pos, edgelist=self.all_edges-mst_edge, alpha=0.4,
        edge_color='skyblue', width=1)
        nx.draw_networkx_edges(
        self.G, pos, edgelist=mst_edge, alpha=1.0,
        edge_color='skyblue', width=3)
        plt.savefig("path.png")
        plt.show()


    # Initialise le dictionnaire des sommets ,parent et poid
    # Initialise les valeurs de dictionnaire en [None,maxsize]
    def primInit(self,s):
        for i in list(self.G.nodes):
            self.edgesDict[i] = [None,sys.maxsize] 
            self.thisdict[i] = [None,sys.maxsize]
        # Parent et le poid du source en [-1,0]
        self.thisdict[s] = [-1,0]
        self.edgesDict[s] = [-1,0]  
        return self.thisdict



    def prim(self,s):
        print("--------------------------------------------------------------------------------------------------------")
        self.visited.append(s)
        weightOld = sys.maxsize
        for j in self.visited:
            w = sys.maxsize

            adjVertices = list(self.G.adj[j])
            print()
            print("Les adjacents de",j," sont ",adjVertices)
            for i in adjVertices:
                if i in self.visited:   
                    edgeDataOld=dict(self.G.get_edge_data(j, i))
                    weightOld = edgeDataOld.get('weight') 
                    self.thisdict[i] = [j,weightOld]
                if i in self.unvisited:     
                    edgeData=dict(self.G.get_edge_data(j, i))
                    weight = edgeData.get('weight')
                    if weight <= weightOld and j in self.unvisited :   
                        self.thisdict[i] = [j,weight]
                    if weight < w :  #poid actuel dans le dictionnaire:                                            
                        w=weight
                        self.edgesDict[i] = [j,i]  
                        print("Update ",i,":[",j,",",weight,"]")
                        self.thisdict[i] = [j,weight]
        self.unvisited.remove(s)                    
        self.indexOfNode(s)
        return self.thisdict

    # Retourne la sommet prochaine
    def indexOfNode(self,s):
        localdict = dict(self.thisdict)
        for i in self.visited:
            print(i,localdict[i])
            localdict.pop(i)
        i=0
        w = sys.maxsize
        for key,value in self.thisdict.items() :
                for i in range(len(list(self.G.nodes))):
                    if key and i in self.unvisited :   
                        if self.G.get_edge_data(i , key)== None:
                            pass
                        else:
                            for k,s in localdict.items():
                                weight = s[1]
                                if weight < w:
                                    print("")                            
                                    w=weight
                                    self.index = k                    
        if len(self.unvisited) == 1:
                self.index = self.unvisited[0]            
        return self.index

    def minPrim(self):
        self.primInit(self.index)
        print("visitée",self.visited)
        print("Non visitée",self.unvisited)
        print("L'index  :",self.index)
        print(self.thisdict)       
        while (len(self.unvisited) != 0):
            self.prim(self.index)
            print("visitée",self.visited)
            print("Non visitée",self.unvisited)
            print("L'index  :",self.index)
        self.drawGraph()

if __name__ == "__main__":
    main = Graph()


