import networkx as nx
import matplotlib.pyplot as plt
from networkx.classes.function import nodes
import sys


class Graph:
    def __init__(self):
        #Création d'un graphe
        self.G = nx.Graph() 
        self.edgesDict = {}
        #Appele de la fonction addEdge() qui permet d'ajouter des sommets et chemins dans le graphe
        self.addEdges()
        #Dictionnaire, qui servent apres pour stocker les sommets avec leurs parent et leurs poid 
        self.thisdict = {}
        #liste des sommets visités, aucun sommet n'est visité au début du prog
        self.visited= []
        #liste des sommets non visités, on l'initialise avec tous les sommets du graphe puis chaque sommet visité 
        # on le supprime du liste unvisited et l'ajouter dans la liste visité pour éviter un cycle
        self.unvisited = list(self.G.nodes)  
        #index c'est le source d'ou commence l'algo, l'utilisateur a le choix de commencer l'algo de n'importe quelle source                                   
        self.index=int(input("Entrer l'index source "))
        #on ajouter tous les chemins dans un seul var afin de les dessiner aprés
        self.all_edges = set(tuple(sorted((n1, n2))) for n1, n2 in self.G.edges())
        #on appele la fonction minPrim
        self.minPrim()

    def addEdges(self):
    # Declarer un graph
        #Ajouter tous les sommets dans un seul copy
        self.G.add_nodes_from([0,1,2,3,4,5,6,7])
        self.G.add_weighted_edges_from([(0, 1, 2), (0, 3, 4), (1, 3, 4),(1, 5, 2), (1, 6, 1), (3, 5, 3), (5, 7, 8), (6, 2, 2), (2, 4, 3), (4, 7, 7)])




    def drawGraph(self):
        edgesList = [] # une liste ou on va ajouter les chemins qu'on a pris
        for key ,value in self.edgesDict.items(): # Itérer sur les items du dictionnaire pour prendre tous les chemins
            if value[0] !=-1:
                edgesList.append(tuple(value)) # L'ajouter des chemins       
        mst_edge = set(tuple(sorted((n1, n2))) for n1, n2 in edgesList) # Ajouter tous les chemins dans set afin de les dessiner 
        pos=nx.circular_layout(self.G) # Donner au graphe un layout qui est circulare [ Circle]
        nx.draw_networkx_nodes(self.G, pos, node_size=500) # Dessiner les sommets
        nx.draw_networkx_labels(self.G, pos) #Dessiner les labels[ Nom] des sommets
        nx.draw_networkx_edges(
        self.G, pos, edgelist=self.all_edges-mst_edge, alpha=0.4,   # Dessiner les chemins qu'on a pas pris 
        edge_color='skyblue', width=1)
        nx.draw_networkx_edges(
        self.G, pos, edgelist=mst_edge, alpha=1.0, # Dssiner les chemins qu'on pris
        edge_color='skyblue', width=3)
        plt.savefig("path.png") # Sauvegarder l'image dans path.png
        plt.show() #Afficher l'image


    def primInit(self,s):
        for i in list(self.G.nodes):
            self.edgesDict[i] = [None,sys.maxsize]  # Initialise le dictionnaire des sommets ,parent et poid
            self.thisdict[i] = [None,sys.maxsize] # Initialise le dictionnaire des sommets ,parent et poid
        # Initialisation du sommet source  (Parent et le poid  en [-1,0])
        self.thisdict[s] = [-1,0] 
        self.edgesDict[s] = [-1,0]  
        return self.thisdict



    def prim(self,s):
        print("--------------------------------------------------------------------------------------------------------")
        self.visited.append(s)  #Ajouter le sommet dans la liste des visitées
        weightOld = sys.maxsize  #Initialiser la var weightold avec une valeure infiny
        for j in self.visited: # On boucle dans les listes des visitées pour traiter tous les chemins possible
            w = sys.maxsize  #Initialiser la var weightold avec une valeure infiny
            adjVertices = list(self.G.adj[j]) #Var qui stock une liste des adjacents de sommet J 
            print("Les adjacents de",j," sont ",adjVertices)
            for i in adjVertices: # On boucle dans la liste des adjacents pour traiter tous les chemins possible du sommet J vers i
                if i in self.visited: # Si le chemin existe déja dans le dictionnaire donc on prend la valeur ancien du poid
                    edgeDataOld=dict(self.G.get_edge_data(j, i))
                    weightOld = edgeDataOld.get('weight') 
                    self.thisdict[i] = [j,weightOld]
                else: #Sinon on prend le poid actuel du chemin
                    edgeData=dict(self.G.get_edge_data(j, i))
                    weight = edgeData.get('weight')
                    if weight <= weightOld and j in self.unvisited : # Vérifie si le nouveau poid du chemin et plus petit que l'ancien poid 
                        self.thisdict[i] = [j,weight] #Si oui, on modifie le chemin précedent avec le nouveau chemin
                    if weight < w : # =Dans chaque itération on vérifie si le dernier chemin dans le dict est plus petit 
                                    # du nouveau chemin,Si oui on modifie la valeur de weight par le dernier poid ajouté
                                    # pour qu'on puisse tjrs prendre le plus petit poid, A la fin d'itération donc on aura 
                                    # le chemin avec le plus petit poid                                        
                        w=weight
                        self.edgesDict[i] = [j,i]  
                        self.thisdict[i] = [j,weight]
        # Apres avoir visité le sommet on le supprimer du liste dans sommets unvisité
        self.unvisited.remove(s)         
        #Appele du fonction pour savoir la prochaine sommet            
        self.indexOfNode(s)
        #Retourne un dictionnaire qui contient les sommets des adjacents avec leurs poids et leurs parents
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
        #Appele de la fonction prim jusqu'a quand a plus de sommet a visité, comme on garantie la visite de tous les sommets     
        while (len(self.unvisited) != 0):
            self.prim(self.index)
            print("visitée",self.visited)
            print("Non visitée",self.unvisited)
            print("L'index  :",self.index)
        #Fonction qui permet de dessiner le graphe
        self.drawGraph()

if __name__ == "__main__":
    main = Graph()


