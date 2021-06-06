import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    visible: true
    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 464
        height: 480
        color: "#e6c7c7"

        Label {
            id: label
            x: 36
            y: 114
            width: 87
            height: 26
            text: qsTr("Sommets :")
            font.bold: true
            font.pointSize: 11
        }

        TextInput {
            id: sommetInfo
            x: 137
            y: 120
            width: 24
            height: 20
            font.pixelSize: 12
        }

        TextInput {
            id: sommetInfo1
            x: 180
            y: 120
            width: 24
            height: 20
            font.pixelSize: 12
        }

        Label {
            id: label1
            x: 36
            y: 162
            width: 87
            height: 26
            text: qsTr("Chemins :")
            font.pointSize: 11
            font.bold: true
        }

        TextInput {
            id: sommetInfo2
            x: 146
            y: 165
            width: 24
            height: 20
            font.pixelSize: 12
        }

        TextInput {
            id: sommetInfo3
            x: 189
            y: 165
            width: 24
            height: 20
            font.pixelSize: 12
        }

        Label {
            id: label2
            x: 36
            y: 215
            width: 87
            height: 26
            text: qsTr("Chemins :")
            font.pointSize: 11
            font.bold: true
        }

        TextInput {
            id: sommetInfo4
            x: 146
            y: 218
            width: 24
            height: 20
            font.pixelSize: 12
        }

        TextInput {
            id: sommetInfo5
            x: 189
            y: 218
            width: 24
            height: 20
            font.pixelSize: 12
        }

        Label {
            id: weightLabel
            x: 36
            y: 162
            width: 87
            height: 26
            text: qsTr("Weight :")
            font.pointSize: 11
            font.bold: true
        }


        Button {
            id: nodeSave
            x: 61
            y: 310
            width: 73
            height: 40
            text: qsTr("Sommet")
            font.bold: true
            font.pointSize: 10
        }

        Button {
            id: edgeSave
            x: 146
            y: 310
            width: 73
            height: 40
            text: qsTr("Chemins")
            font.bold: true
            font.pointSize: 10
        }

        Button {
            id: drawGraph
            x: 232
            y: 310
            width: 73
            height: 40
            text: qsTr("Draw Graph")
            font.bold: true
            font.pointSize: 10
        }

        Label {
            id: label3
            x: 158
            y: 62
            width: 87
            height: 26
            text: qsTr("Normal Graph")
            font.pointSize: 11
            font.bold: true
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:4}D{i:5}D{i:12}D{i:13}
D{i:14}
}
##^##*/


