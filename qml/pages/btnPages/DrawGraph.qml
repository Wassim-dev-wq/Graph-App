import QtQuick 2.0
import QtQuick.Controls 2.15
import "../../controls"
Item {

    Rectangle {
        id: graphDrawContainer
        color: "#f4f8f9"
        anchors.fill: parent
        anchors.bottomMargin: 0
        z:1
        Image {
            id: graphImg
            cache:false
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "../../../graphe_images/graphImg.png"
            anchors.leftMargin: 198
            anchors.rightMargin: 196
            anchors.topMargin: 34
            anchors.bottomMargin: 51
            fillMode: Image.PreserveAspectFit
            Rectangle {
                id:recBehind
                border.color: "#94b8b8"
                anchors.fill: parent
                anchors.margins: -border.width
                z: -1
                border.width: 1
            } 
            function reloadImage() {
                var oldSource = source
                source = ""
                source = oldSource
            }
            
            
        }
        Component.onCompleted: graphImg.reloadImage()        
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:2}
}
##^##*/
