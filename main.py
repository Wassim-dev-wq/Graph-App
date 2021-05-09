# This Python file uses the following encoding: utf-8
import networkx as nx
import matplotlib.pyplot as plt
import os
from pathlib import Path
import sys

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, Qt
from PySide2.QtWidgets import QVBoxLayout, QLineEdit,QApplication


class MainWindow(QObject):
    def __init(self):
        QObject.__init__(self)
        

    # @Slot(int,int)
    # def getSommetText(self, s1,s2):
    #     G.add_node(s1)
    #     G.add_node(s2)
    #     print(s1,s2)


    # @Slot(str,str)
    # def getEdge(self,v1,v2):
    #     G.add_edge(v1,v2)
    #     print(v1,v2)


    # @Slot()
    # def drawGraph(self):
    #     print("xx")
    #     nx.draw(G, with_labels=True, node_size=1500, node_color='red')
    #     plt.savefig("graph/path1.png")
    #     plt.show()



if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    G = nx.Graph()
    # Get CONTEXT
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)
    # Load QML FILE
    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
