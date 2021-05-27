import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.11

Item{
    Rectangle {
        id: rectangle
        color: "#f4f8f9"
        anchors.fill: parent

        Text {
            id: text1
            x: 251
            y: 201
            width: 70
            height: 29
            text: qsTr("Graphe Oriente Pondéré")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}