# This Python file uses the following encoding: utf-8
import networkx as nx
import matplotlib.pyplot as plt
import os
from pathlib import Path
import sys
from PIL import Image
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal
from PySide2.QtWidgets import QVBoxLayout, QLineEdit,QApplication
from numpy import array

class MainWindow(QObject):
    def __init(self):
        QObject.__init__(self)

    D = nx.DiGraph()
    G = nx.Graph()

    setDataDjikstra = Signal(str)
    setNodesCountDi = Signal(str)
    setNodesCount = Signal(str)
    setDataVoisin = Signal(str)
    setDataKruskal = Signal(str)
    setDataKruskall = Signal(str)
    setDataPrimm = Signal(str)
    setDataPrim = Signal(str)
    setSourceIndex = Signal(str)
    setData = Signal(str)
    setNode = Signal(str)
    setExist = Signal(str)
    getVal = Signal(str)
    checkGraphKruskal = Signal(str)
    internError = Signal(str)
    imgReload = Signal()
###########################################################################################################
    @Slot()
    def renitiliserGraphe(self):
        self.G = nx.Graph()
        self.D = nx.DiGraph()

################""  

    def drawGraphA(self,G,all_edges,edgesDict):
        edgesList = [] 
        for key ,value in edgesDict.items():
            if value[0] !=-1 and value[0]!=None:
                edgesList.append(tuple(value))          
        mst_edge = set(tuple(sorted((n1, n2))) for n1, n2 in edgesList) 
        fig = plt.figure(frameon=False)
        ax = fig.add_axes([0, 0, 1, 1])
        ax.axis('off')
        plt.margins(0.15)
        pos=nx.circular_layout(G) 
        labels = nx.get_edge_attributes(G,'weight')     
        nx.draw_networkx(G,pos,node_size=2500, style="solid")
        nx.draw_networkx_labels(G, pos) 
        nx.draw_networkx_edges(
        G, pos, edgelist=all_edges-mst_edge, alpha=0.4, width=2)
        nx.draw_networkx_edges(
        G, pos, edgelist=mst_edge, alpha=1.0, 
        edge_color='skyblue', width=3)
        nx.draw_networkx_edge_labels(G, pos,edge_labels=labels,font_size=14)
        plt.savefig("graphe_images/algoPrimGraph.png") 
        poidArbre = 0
        for i in edgesList:
            poidArbre = poidArbre + G.get_edge_data(i[0],i[1]).get('weight')
        data = " ".join(map(str,edgesList))
        for r in (("(","["),(")", "]"),(", ",",",),(" "," et ")):
            data = data.replace(*r)  
        self.setDataPrimm.emit("- L'arbre obtenu est de poids "+str(poidArbre))      
        self.setDataPrim.emit("- On peut choisir "+data) 
        plt.clf()

    def primInit(self,G,s,thisdict,edgesDict):
        for i in list(G.nodes):
            edgesDict[i] = [None,sys.maxsize]  
            thisdict[i] = [None,sys.maxsize] 
        thisdict[s] = [-1,0] 
        edgesDict[s] = [-1,0]  
        return thisdict



    def prim(self,G,s,unvisited,visited,thisdict,edgesDict):
        try:
            visited.append(s) 
            weightOld = sys.maxsize   
            for j in visited:
                w = sys.maxsize 
                adjVertices = list(G.adj[j])
                for i in adjVertices: 
                    if i in visited: 
                        edgeDataOld=dict(G.get_edge_data(j, i))
                        weightOld = edgeDataOld.get('weight') 
                        thisdict[i] = [j,weightOld]
                    else:
                        edgeData=dict(G.get_edge_data(j, i))
                        weight = edgeData.get('weight')
                        if weight <= weightOld and j in unvisited : 
                            thisdict[i] = [j,weight] 
                        if weight < w :                         
                            w=weight
                            edgesDict[i] = [j,i]  
                            thisdict[i] = [j,weight]
            unvisited.remove(s)                  
            self.indexOfNode(G,s,unvisited,visited,thisdict,edgesDict)
        except UnboundLocalError as e:
            raise Exception (self.internError.emit("Aucun chemin n'est possible ")) from e
        return thisdict


    def indexOfNode(self,G,s,unvisited,visited,thisdict,edgesDict):
        localdict = dict(thisdict)
        for i in visited:
            print(i,localdict[i])
            localdict.pop(i)
        i=0
        w = sys.maxsize
        for key,value in thisdict.items() :
                for i in range(len(list(G.nodes))):
                    if key and i in unvisited :   
                        if G.get_edge_data(i , key)== None:
                            pass
                        else:
                            for k,s in localdict.items():
                                weight = s[1]
                                if weight < w:
                                    w=weight
                                    indexo = k                    
        if len(unvisited) == 1:
                indexo = unvisited[0] 
        while (len(unvisited) != 0):
            self.prim(G,indexo,unvisited,visited,thisdict,edgesDict)

    @Slot(str,int)
    def minPrim(self,graphType,indexo):
        if graphType == 'directed':
            G = self.D
        else:
            G = self.G
        thisdict = {}
        edgesDict = {}
        visited= []
        unvisited = list(G.nodes)  
        all_edges = set(tuple(sorted((n1, n2))) for n1, n2 in G.edges())
        self.primInit(G,indexo,thisdict,edgesDict)
        self.prim(G,indexo,unvisited,visited,thisdict,edgesDict)  
        self.drawGraphA(G,all_edges,edgesDict)

#################################################################################################

    def kruskalInit(self,G,thisdict,visited):
        # G.edges.data() retourne une liste des chemins avec leurs poids dans un dictionnaire, lamba fetch chaque tuple et compare le avec les poids
        #si n'a pas de poid dans le chemin retourne 1
        poidArbre = 0
        chemin = []
        for i in list(G.nodes):
            thisdict[i] = [None,sys.maxsize]
        edgesSorted=sorted(G.edges.data(), key=lambda t: t[2].get('weight', 1))
        while len(edgesSorted) != 0:
            if edgesSorted[0][1] not in visited:
                thisdict[edgesSorted[0][1]] = [edgesSorted[0][0],edgesSorted[0][2].get('weight')]
                visited.append(edgesSorted[0][1])
                poidArbre = poidArbre + edgesSorted[0][2].get('weight')
                e = edgesSorted[0][0],edgesSorted[0][1]
                chemin.append(e) 
            edgesSorted.pop(0)
        data = " ".join(map(str,chemin))
        for r in (("(","["),(")", "]"),(", ",",",),(" "," puis ")):
            data = data.replace(*r)  
        self.setDataKruskall.emit("- L'arbre obtenu est de poids "+str(poidArbre))      
        self.setDataKruskal.emit("- On peut choisir "+data) 
        return thisdict

    def drawGraphKruskal(self,G,thisdict):
        all_edges = set(tuple(sorted((n1, n2))) for n1, n2 in G.edges()) 
        edgesList = [] 
        print(thisdict.items())
        for key ,value in thisdict.items():
            if value[0] !=None:
                edgesList.append(tuple([key,value[0]]))       
        mst_edge = set(tuple(sorted((n1, n2))) for n1, n2 in edgesList) 
        print(mst_edge," edge list ",all_edges)
        fig = plt.figure(frameon=False)
        ax = fig.add_axes([0, 0, 1, 1])
        ax.axis('off')
        plt.margins(0.15)
        pos=nx.circular_layout(G) 
        labels = nx.get_edge_attributes(G,'weight')     
        nx.draw_networkx(G,pos,node_size=2500, style="solid")
        nx.draw_networkx_labels(G, pos) 
        nx.draw_networkx_edges(
        G, pos, edgelist=all_edges-mst_edge, alpha=0.4, width=2)
        nx.draw_networkx_edges(
        G, pos, edgelist=mst_edge, alpha=1.0, 
        edge_color='skyblue', width=3)
        nx.draw_networkx_edge_labels(G, pos,edge_labels=labels,font_size=14)
        plt.savefig("graphe_images/algoKruskalGraph.png") 
        plt.clf()
        self.imgReload.emit()

    @Slot(str)
    def kruskal(self,graphType):
        if graphType == "directed":
            G = self.D
        else:
            G = self.G
        if self.checkIfGraphNotEmpty(G) == "noNodes":
            self.checkGraphKruskal.emit("noNodes")
        elif self.checkIfGraphNotEmpty(G) == "noEdges":
            self.checkGraphKruskal.emit("noEdges")
        else:
            thisdict = {}
            visited= []
            self.kruskalInit(G,thisdict,visited)
            self.drawGraphKruskal(G,thisdict)

    def checkIfGraphNotEmpty(self,G):
        if len(G.nodes) == 0:
            return "noNodes"
        elif len(G.edges) == 0:
            return "noEdges"
        else:
            return "ready"
##########################################################################################################################



    @Slot(str,int,int)
    def djikstraAlgo(self,graphType,source,destination):
        # G.edges.data() retourne une liste des chemins avec leurs poids dans un dictionnaire, lamba fetch chaque tuple et compare le avec les poids
        #si n'a pas de poid dans le chemin retourne 1
        if graphType == 'directed':
            G = self.D
        else:
            G = self.G
        thisdict = {}
        visited= []
        for i in list(G.nodes):
            thisdict[i] = [None,sys.maxsize]
            thisdict[source] = [-1,0]
        for i in list(G.nodes):
            adjNode = list(G.adj[i])
            for j in adjNode:
                if j not in visited:
                    weight = G.get_edge_data(i,j).get('weight')
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
        data = " ".join(map(str,chemin[::-1]))
        data = data.replace(' ',' -> ')       
        self.setDataDjikstra.emit('- Le chemin pris de de '+str(source)+' a '+str(olddest)+ ' est ' + data+"\n- Le poid du chemin est "+str(poidChemin))
        self.drawGraphDjikstra(G,thisdict)

    def drawGraphDjikstra(self,G,thisdict):
        all_edges = set(tuple(sorted((n1, n2))) for n1, n2 in G.edges()) 
        edgesList = [] 
        print(thisdict.items())
        for key ,value in thisdict.items():
            if value[0] !=-1 and value[0] != None:
                edgesList.append(tuple([key,value[0]]))   
        print(edgesList)    
        mst_edge = set(tuple(sorted((n1, n2))) for n1, n2 in edgesList) 
        fig = plt.figure(frameon=False)
        ax = fig.add_axes([0, 0, 1, 1])
        ax.axis('off')
        plt.margins(0.15)
        pos=nx.circular_layout(G) 
        labels = nx.get_edge_attributes(G,'weight')     
        nx.draw_networkx(G,pos,node_size=2500, style="solid")
        nx.draw_networkx_labels(G, pos) 
        nx.draw_networkx_edges(G, pos, edgelist=all_edges-mst_edge, alpha=0.4, width=2)
        nx.draw_networkx_edges(G, pos, edgelist=mst_edge, alpha=1.0, 
        edge_color='skyblue', width=3)
        nx.draw_networkx_edge_labels(G, pos,edge_labels=labels,font_size=14)
        plt.savefig("graphe_images/algoDjikstra.png") 
        plt.clf()








    # Normal Graphe
    @Slot(int)
    def getSommetText(self,s1):
        self.G.add_node(s1)

    @Slot(int,int)
    def checkIfExist(self,s1,s2):
        nodesList = [s1,s2]
        v = (s1,s2)
        v2 = (s2,s1)
        checkifExists = all(i in list(self.G.nodes) for i in nodesList)
        if checkifExists is True:
            if v not in self.G.edges and v2 not in self.G.edges:
                self.getVal.emit("True")
            else: self.getVal.emit("edgeExist")
        else:
            self.getVal.emit("False")

    # Ajouter un chemin entre deux sommets
    @Slot(int,int)
    def getEdge(self,v1,v2):
        if v1 ==0 or v2 == 0: 
            pass
        else:
            self.G.add_edges_from([(v1, v2)])

    # Crée la matrice d'adjacence     
    @Slot()
    def matriceGrapheAdjacence(self):
        M = nx.to_numpy_array(self.G)
        data = "\n".join(map(str, M))
        for r in ((".","  "),(" ]", "|"), ("[", "| ")):
            data = data.replace(*r)
        self.setData.emit(str(data))

    @Slot(int)
    def degreGrapheNode(self,node):
        data = self.G.degree[node]
        self.setData.emit("- Le degrée du sommet "+str(node)+" est "+str(data)+".")

    @Slot(int)
    def voisinNode(self,node):
        data = list(self.G.adj[node])
        if len(data) == 0:
            self.setDataVoisin.emit("- Le sommet "+str(node)+" n'a pas de voisin.")        
        elif  len(data) == 1: 
            self.setDataVoisin.emit("- Le voisin de "+str(node)+" est "+" - ".join(map(str, data)))
        else:
            self.setDataVoisin.emit("- Les voisins de "+str(node)+" sont "+" - ".join(map(str, data)))
    @Slot()
    def nodesCount(self):
            data = len(list(self.G.nodes))
            if data > 1:
                self.setNodesCount.emit("- Le graphe a "+str(data)+" sommets")        
            elif data == 1:
                self.setNodesCount.emit("- Le graphe a "+str(data)+" sommet")
            else: 
                self.setNodesCount.emit("- Veuillez créer un graphe ")

    @Slot(int)
    def checkNodeExist(self,node):
        if node in list(self.G.nodes):
            self.setExist.emit("True")
        else:
            self.setExist.emit("False")
    @Slot()
    def drawGraph(self):
        all_edges = set(tuple(sorted((n1, n2))) for n1, n2 in self.G.edges())
        fig = plt.figure(frameon=False)
        ax = fig.add_axes([0, 0, 1, 1])
        ax.axis('off')
        plt.margins(0.15)
        pos=nx.circular_layout(self.G) 
        nx.draw_networkx(self.G,pos,node_size=2500, style="solid")
        nx.draw_networkx_edges(self.G, pos, edgelist=all_edges, alpha=1, width=3)
        plt.savefig("graphe_images/graphImg.png") 
        plt.clf()

    #Graphe Orientée

    #Ajouter un sommet
    @Slot(int)
    def addDirectedNode(self,s1):
        print("Somme ajouter",s1)
        self.D.add_node(s1)

    # Ajouter un chemin entre deux sommets
    @Slot(int,int)
    def addDirectedEdge(self,s1,s2):
        if s1 ==0 or s2 == 0: 
            pass
        else:
            self.D.add_edges_from([(s1, s2)])

    # Dessiner un graphe Orientée
    @Slot()
    def drawDirectedGraph(self):
        all_edges = set(tuple(sorted((n1, n2))) for n1, n2 in self.D.edges())
        fig = plt.figure(frameon=False)
        ax = fig.add_axes([0, 0, 1, 1])
        ax.axis('off')
        plt.margins(0.15)
        pos=nx.circular_layout(self.D) 
        nx.draw_networkx(self.D,pos,node_size=2500, style="solid")
        nx.draw_networkx_edges(self.D, pos, edgelist=all_edges, alpha=1, width=3)
        plt.savefig("graphe_images/graphImg.png") 
        plt.clf()

    # Vérifier si les sommets existe dans le graphe
    @Slot(int,int)
    def directedCheckIfExist(self,s1,s2):
        nodesList = [s1,s2]
        v= (s1,s2)
        v2 = (s2,s1)
        checkifExists = all(i in list(self.D.nodes) for i in nodesList)
        if checkifExists is True:
            if v not in self.D.edges and v2 not in self.D.edges:
                self.getVal.emit("True")
            else: self.getVal.emit("edgeExist")
        else:
            self.getVal.emit("False")

    # Affiche la liste des successeurs
    @Slot(int)
    def successorNode(self,node):
        data = str(list(self.D.successors(node)))  
        for r in (("]", ""), ("[", "")):        
            data = data.replace(*r)
        if len(list(data)) == 0:  
            self.setData.emit("- Le sommet " + str(node) +" n'a pas de successeur. ") 
        elif len(list(data)) > 1:
            self.setData.emit("-"+data+ " sont les successeurs de " + str(node) +". ") 
        else:
            self.setData.emit("-"+data+ " est le successeur de " + str(node) +". ") 

    # Affiche la liste des prédécesseur
    @Slot(int)
    def predecesseurNode(self,node):
        data = str(list(self.D.predecessors(node)))    
        for r in (("]", ""), ("[", "")):        
            data = data.replace(*r)
        if len(list(data)) == 0:  
            self.setData.emit("- Le sommet " + str(node) +" n'a pas de prédécesseur. ") 
        elif len(list(data)) > 1:  
            self.setData.emit("-"+data+ " sont les prédécesseurs de " + str(node) +". ") 
        else:
            self.setData.emit("-"+data+ " est le prédécesseur de " + str(node) +". ") 
    
    
    # Vérifie si le sommet existe dans le graphe 
    @Slot(int)
    def checkDirectedNodeExist(self,node):
        if node in list(self.D.nodes):
            self.setExist.emit("True")
        else:
            self.setExist.emit("False")

    @Slot(int)
    def degreNode(self,node):
        data = self.D.degree[node]
        self.setData.emit("-"+str(data)+" est le degrée du sommet "+str(node)+".")

    @Slot()
    def nodesCountDi(self):
        data = len(list(self.D.nodes))
        if data > 1:
            self.setNodesCountDi.emit("- Le graphe a "+str(data)+" sommets")        
        elif data == 1:
            self.setNodesCountDi.emit("- Le graphe a "+str(data)+" sommet")
        else: 
            self.setNodesCountDi.emit("- Veuillez créer un graphe ")            

    @Slot()
    def matriceAdjacenceDiGraph(self):
        M = nx.to_numpy_array(self.D)
        data = "\n".join(map(str, M))
        for r in ((".","  "),(" ]", "|"), ("[", "| ")):
            data = data.replace(*r)
        self.setData.emit(str(data))

    
    
    # Graphe Pondéré

    @Slot(int,int,float)
    def addWeightedEdge(self,s1,s2,weight):
        if s1 ==0 or s2 == 0: 
            pass
        else:
            self.G.add_weighted_edges_from([(s1, s2, weight)])

    @Slot()
    def drawWeightedGraph(self):
        pos=nx.circular_layout(self.G) 
        fig = plt.figure(frameon=False)
        ax = fig.add_axes([0, 0, 1, 1])
        ax.axis('off')
        plt.margins(0.15)
        nx.draw_networkx(self.G,pos,node_size=2500, style="solid")
        labels = nx.get_edge_attributes(self.G,'weight')     
        nx.draw_networkx_edges(self.G, pos, width=3)
        nx.draw_networkx_edge_labels(self.G, pos,edge_labels=labels,font_size=14)
        plt.savefig("graphe_images/graphImg.png")
        plt.clf()
    


    # Graphe orienté pondérer
    @Slot(int,int,float)
    def addWeightedDiEdge(self,s1,s2,weight):
        if s1 ==0 or s2 == 0: 
            pass
        else:
            self.D.add_weighted_edges_from([(s1, s2, weight)])

    @Slot()
    def drawWeightedDiGraph(self):
        pos=nx.circular_layout(self.D) 
        fig = plt.figure(frameon=False)
        ax = fig.add_axes([0, 0, 1, 1])
        ax.axis('off')
        plt.margins(0.15)
        nx.draw_networkx(self.D,pos,node_size=2500, style="solid")
        labels = nx.get_edge_attributes(self.D,'weight')     
        nx.draw_networkx_edges(self.D, pos, width=3)
        nx.draw_networkx_edge_labels(self.D, pos,edge_labels=labels,font_size=14)
        plt.savefig("graphe_images/graphImg.png")
        plt.clf()     

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine() 
    # Get CONTEXT
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)
    # Load QML FILE
    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_()) 
