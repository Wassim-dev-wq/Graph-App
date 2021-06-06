import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../controls"

Item {

    property color degreInputBorder: "#a3c2c2"
    Rectangle {
        id: rectangle
        color: "#f4f8f9"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        Image {
            id: imageGraph
            cache: false
            width: 494
            anchors.right : algoKruskalContainer.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left:parent.left
            anchors.rightMargin: 32
            anchors.leftMargin: 18
            source: "../../../graphe_images/graphImg.png"
            anchors.topMargin: 31
            anchors.bottomMargin: 35
            function reloadImage() {
                var oldSource ="../../../graphe_images/algoKruskalGraph.png"
                source = ""
                source = oldSource
            }
        }
        
        Rectangle {
            id: algoKruskalContainer
            x: 526
            width: 456
            height: 349
            color: "#ffffff"
            radius:5
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 31
            anchors.bottomMargin: 35
            anchors.rightMargin: 38


            Label {
                id: algoKruskalLabel
                x: 17
                width: 201
                height: 22
                color: "#7FB3D5"
                text: qsTr("Algorithme de Kruskal")
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 19
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 13
                font.family: "Open Sans"
                font.bold: true
            }

            RunAlgosBtn {
                id: kruskalTrignerBtn
                x: 152
                width: 128
                height: 32
                clip: true
                text:"Exécuter Kruskal"
                anchors.right: parent.right
                anchors.top: algoKruskalLabel.bottom
                anchors.rightMargin: 152
                anchors.topMargin: 16
                onClicked:{
                    backend.kruskal('directed')
                }
            }              

            Label {
                id: algoKruskal
                height: 32
                color: "#535b60"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: algoKruskal1.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WrapAnywhere
                anchors.rightMargin: 15
                anchors.leftMargin: 43
                anchors.topMargin: 23
                font.family: "Open Sans"
                font.pointSize: 13
                font.bold: false
            }

            Label {
                id: algoKruskal1
                width: 230
                height: 35
                visible: false
                color: "#535b60"
                text: "D'aprés l'algorithme :"
                anchors.left: parent.left
                anchors.top: kruskalTrignerBtn.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WrapAnywhere
                anchors.leftMargin: 15
                anchors.topMargin: 30
                font.pointSize: 12
                font.bold: true
                font.family: "Open Sans"
            }

            Label {
                id: algoKruskal2
                height: 24
                color: "#535b60"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: algoKruskal.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WrapAnywhere
                anchors.leftMargin: 43
                anchors.rightMargin: 15
                anchors.topMargin: 15
                font.pointSize: 13
                font.bold: false
                font.family: "Open Sans"
            }
        
        
        }
        DropShadow{
            anchors.fill: algoKruskalContainer
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: algoKruskalContainer
            z: 0
        }
        DropShadow{
            anchors.fill: imageGraph
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: imageGraph
            z: 0
        }
        

    }
    Connections{
        target: backend
        function onSetDataKruskal(data){
            algoKruskal.text=data
            algoKruskal1.visible = true

        }
        function onSetDataKruskall(data) {
            algoKruskal2.text = data

        }
        function onImgReload() {
            imageGraph.reloadImage()
        }
        function onCheckGraphKruskal(data) {
            if (data === "noNodes"){
                var warnLabel= Qt.createQmlObject(
                    'import QtQuick.Controls 2.15;Label {id: label;x: 152;y: 90;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez créer un graphe");font.pointSize: 10;font.bold:true;styleColor: "#ffffff"}'
                    ,algoKruskalContainer, "dynamicSnippet1");
                warnLabel.destroy(1000);}
            else if ( data ==="noEdges"){
                 var warnLabel= Qt.createQmlObject(
                    'import QtQuick.Controls 2.15;Label {id: label;x: 152;y: 90;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez ajouter des chemins dans le graphe");font.pointSize: 10;font.bold:true;styleColor: "#ffffff"}'
                    ,algoKruskalContainer, "dynamicSnippet1");
                warnLabel.destroy(1000);
            }
        }
    }   
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:4}D{i:5}D{i:6}D{i:7}D{i:8}D{i:9;invisible:true}D{i:10;invisible:true}
}
##^##*/
