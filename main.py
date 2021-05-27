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


class MainWindow(QObject):
    def __init(self):
        QObject.__init__(self)
        print("init here")
    D = nx.DiGraph()
    G = nx.Graph()

    setData = Signal(str)
    setNode = Signal(str)
    setExist = Signal(str)
    getVal = Signal(str)

    # Normal Graphe
    @Slot(int)
    def getSommetText(self,s1):
        self.G.add_node(s1)

    @Slot(int,int)
    def checkIfExist(self,s1,s2):
        nodesList = [s1,s2]
        checkifExists = all(i in list(self.G.nodes) for i in nodesList)
        if checkifExists is True:
            self.getVal.emit("True")
        else:
            self.getVal.emit("False")

    # Ajouter un chemin entre deux sommets
    @Slot(int,int)
    def getEdge(self,v1,v2):
        self.G.add_edges_from([(v1, v2)])

    @Slot()
    def drawGraph(self):
        pos = nx.spring_layout(self.G)
        plt.margins(0.15)
        nx.draw(self.G, pos,with_labels=True, width=3,node_size=2500, edge_color="skyblue", style="solid")
        plt.savefig("graphImg/graphImg.png")


    #Graphe Orientée
    #Ajouter un sommet
    @Slot(int)
    def addDirectedNode(self,s1):
        self.D.add_node(s1)

    # Ajouter un chemin entre deux sommets
    @Slot(int,int)
    def addDirectedEdge(self,s1,s2):
        self.D.add_edges_from([(s1, s2)])

    # Dessiner un graphe Orientée
    @Slot()
    def drawDirectedGraph(self):
        pos = nx.spring_layout(self.D)
        plt.margins(0.15)
        nx.draw(self.D, pos,with_labels=True, width=3,node_size=2500, edge_color="skyblue", style="solid")
        plt.savefig("graphImg/graphImg.png")

    # Vérifier si les sommets existe dans le graphe
    @Slot(int,int)
    def directedCheckIfExist(self,s1,s2):
        nodesList = [s1,s2]
        checkifExists = all(i in list(self.D.nodes) for i in nodesList)
        if checkifExists is True:
            self.getVal.emit("True")
        else:
            self.getVal.emit("False")

    # Affiche la liste des successeurs
    @Slot(int)
    def successorNode(self,node):
        data = list(self.D.successors(node))     
        self.setData.emit("-"+str(data)+ " sont les successeurs de " + str(node) +". ") 

    # Affiche la liste des prédécesseur
    @Slot(int)
    def predecesseurNode(self,node):
        data = list(self.D.predecessors(node))     
        self.setData.emit("-"+str(data)+ " sont les prédécesseurs de " + str(node) +". ") 

    # Vérifie si le sommet existe dans le graphe 
    @Slot(int)
    def checkNodeExist(self,node):
        if node in list(self.D.nodes):
            self.setExist.emit("True")
        else:
            self.setExist.emit("False")

    @Slot(int)
    def degreNode(self,node):
        data = self.D.degree[node]
        print(data)
        self.setData.emit("-"+str(data)+" est le degrée du sommet "+str(node)+".")


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
