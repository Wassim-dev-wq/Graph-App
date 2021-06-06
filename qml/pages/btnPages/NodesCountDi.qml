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
            cache: false
            width: 494
            anchors.right : nodesCountContainer.left
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
            }
        }
        
        Rectangle {
            id: nodesCountContainer
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
                id: nodesCountLabel
                x: 17
                y: 19
                width: 201
                height: 22
                color: "#7FB3D5"
                text: qsTr("Nombre de sommet")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 13
                font.family: "Open Sans"
                font.bold: true
            }           

            Label {
                id: nodesCount
                color: "#535b60"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: nodesCountLabel.bottom
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WrapAnywhere
                anchors.leftMargin: 25
                anchors.rightMargin: 20
                anchors.topMargin: 86
                anchors.bottomMargin: 47
                font.family: "Open Sans"
                font.pointSize: 14
                font.bold: true
            }
        Component.onCompleted: {
                image.reloadImage()
                backend.nodesCountDi()
        }
        }
        DropShadow{
            anchors.fill: nodesCountContainer
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: nodesCountContainer
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
        function onSetNodesCountDi(data){
            nodesCount.text=data
            }
    }   
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}D{i:2}D{i:5}D{i:3}
}
##^##*/
