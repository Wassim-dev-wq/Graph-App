import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.11
import "componentCreation.js" as MyScript
import "../controls"

Item {
    property color inBorderColor: "#a3c2c2"
    property color inBorderColorEdge: "#a3c2c2"
    property var newobj1: null
    property var newobj2: null
    property url getImageSource: "../../graph/path.jpg"
    property url setSourceGraphImg: "../../graph/graphImg.jpg"


    QtObject{
        id: internal
        function updateGraph(){
            graphImage.source="../../graph/path1.png"
        }
        function loadGraph(){
            image.source ="../../graph/graphimg.png"
        }
        function setVisible(){
            saveInfoContainer.visible = true
            gridLayoutBottom.visible = true
            btnChooseLabel.visible = true
        }
        function addNodes(){
            var myText=1;
            for(var i=0;i<sommetInfo1.text;++i){
                var newNodeInput= Qt.createQmlObject(
                            'import "../controls"; CustomTextFieldNode {}'
                            ,nodesRowColumn, "dynamicSnippet1");
                newNodeInput.text=myText;
                backend.getSommetText(myText)
                ++myText;
            }
        }
        function emptyText(){
            sommetInfo1.isEmpty ? addNode.enabled = false : addNode.enabled
        }
    }

    Rectangle {
        id: rectangle
        color: "#f4f8f9"
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.rightMargin: 0

        Flickable {
            id: flickable
            contentWidth: gridLayoutBottom.width
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: stackView.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 54
            anchors.bottomMargin: 20
            anchors.rightMargin: 8
            anchors.leftMargin: 22
            clip: true

            GridLayout {
                id: gridLayoutBottom
                anchors.left: parent.left
                anchors.right:btnRight.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                columns: 100
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                columnSpacing: 10
                rows: 0
                //  visible : false
                CustomBtn {
                    text: "Graphe"
                    font.pointSize: 9
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked:{
                        stackView.push(Qt.resolvedUrl("Graphe.qml"))
                    }
                }

                CustomBtn {
                    text: "Dessiner le graphe"
                    font.pointSize: 9
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked:{
                        backend.drawGraph()
                        stackView.push(Qt.resolvedUrl("btnPages/DrawGraph.qml"))
                    }
                }

                CustomBtn{
                    text: "Algorithm Prim"
                    font.pointSize: 9
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: nodesView.push("pages/pageNoInternet.qml")
                }

                CustomBtn{
                    text: "Algorithm Djikstra"
                    font.pointSize: 9
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: nodesView.push("pages/pageNoInternet.qml")
                }

                CustomBtn{
                    text: "Algorithm Kruskal"
                    font.pointSize: 9
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: nodesView.push("pages/pageNoInternet.qml")
                }

                CustomBtn{
                    text: "Voisinage"
                    font.pointSize: 9
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: nodesView.push("pages/pageNoInternet.qml")
                }

                CustomBtn{
                    text: "Degré"
                    font.pointSize: 9
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: nodesView.push("pages/pageNoInternet.qml")
                }


                CustomBtn{
                    text: "Nombre de sommet "
                    font.pointSize: 9
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: nodesView.push("pages/pageNoInternet.qml")
                }

                CustomBtn{
                    text: "Matrice d'adjacence "
                    font.pointSize: 9
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: nodesView.push("pages/pageNoInternet.qml")
                }

                CustomBtn{
                    id:btnRight
                    text: "Matrice d'incidence "
                    font.pointSize: 9
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: nodesView.push("pages/pageNoInternet.qml")
                }
            }

        }

        Label {
            id: btnChooseLabel
            width: 737
            text: qsTr("Lorem fezo ifep oakg maf [ btn choix ]")
            anchors.left: parent.left
            anchors.bottom: flickable.top
            anchors.leftMargin: 36
            anchors.bottomMargin: 25
            font.pointSize: 12
            font.family: "Open Sans SemiBold"
            // visible: false
        }

        StackView {
            id: stackView
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 180
            initialItem: Qt.resolvedUrl("Graphe.qml")

        }

    }
}












/*##^##
Designer {
    D{i:0;formeditorZoom:0.33}D{i:4}D{i:3}D{i:15}D{i:16}
}
##^##*/
