import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.11


Item {
    property url getImageSource: "../../graph/path.jpg"
    property url so: "../../graph/path1.png"
    property var addNode: "pythonProject\qml\controls\Line.qml"

    width: 900

    QtObject{
        id: internal
        function updateGraph(){
            graphImage.source="../../graph/path1.png"
         }
        function addLine() {
             row.addRow
             row.push(sommetInfo)
        }
    }

    Rectangle {
        id: rectangle
        visible: true
        color: "#ffffff"
        anchors.fill: parent
        anchors.rightMargin: -5

        Label {
            id: label
            x: 305
            y: 166
            width: 260
            height: 52
            text: qsTr("Home")
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: -16
            anchors.horizontalCenterOffset: -11
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            font.pointSize: 13
        }
    }

    Connections{
        target: backend
    }

    }



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}D{i:3}
}
##^##*/
