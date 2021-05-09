import QtQuick 2.0
import QtQuick.Controls 2.15

Item {

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Label {
            id: label
            x: 337
            y: 185
            width: 126
            height: 53
            text: qsTr("Settings")
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 23
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
