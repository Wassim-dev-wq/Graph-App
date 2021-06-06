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
            id: image
            cache:false
            width: 494
            anchors.right : matriceAdjContainer.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left:parent.left
            anchors.rightMargin: 32
            anchors.leftMargin: 18
            source: "../../../graphe_images/graphImg.png"
            anchors.topMargin: 31
            anchors.bottomMargin: 35
            
            function reloadImage() {
                var oldSource = source
                source = ""
                source = oldSource
           
        }}
        
        Rectangle {
            id: matriceAdjContainer
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
                id: matriceAdjLabel
                x: 17
                y: 19
                width: 201
                height: 22
                color: "#7FB3D5"
                text: qsTr("Matrice d'adjacence")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 13
                font.family: "Open Sans"
                font.bold: true
            }
            

            Label {
                id: matriceAdj
                x: 17
                y: 130
                width: 201
                height: 175
                color: "#535b60"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenterOffset: 0
                font.family: "Open Sans"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 20
                font.bold: true
            }
        
        Component.onCompleted: {
                image.reloadImage()
                backend.matriceAdjacenceDiGraph()
        
        }
        }
        DropShadow{
            anchors.fill: matriceAdjContainer
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: matriceAdjContainer
            z: 0
        }

        DropShadow{
            anchors.fill: image
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: image
            z: 0
        }        

    }
    Connections{
        target: backend
        function onSetData(data){
            console.log(data)
            matriceAdj.text=data
            }
    }   
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.33}D{i:6;invisible:true}
}
##^##*/
