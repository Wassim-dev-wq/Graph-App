
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: button

    property color colorDefault: "#599cc8"
    // 
    //property color colorDefault: "#45B39D"
    property color colorMouseOver: "#7dbde8"
    property color colorPressed: "#55aaff"
    property color textColorHover: "#000000"
    property color textColorDefault: "#ffffff"
    implicitWidth: 120
    implicitHeight: 95

    QtObject{
        id: internal

        property var dynamicColor: if(button.down){
                                       button.down ? colorPressed : colorDefault
                                   }else{
                                       button.hovered ? colorMouseOver : colorDefault
                                   }
        property var dynamicColorText: if(button.down){
                                       button.down ? textColorHover : textColorDefault
                                   }else {
                                       button.hovered ? textColorHover : textColorDefault
                                   }        
    }

    text: qsTr("Button")
    font.pointSize: 10
    //font.family: "Segoe UI"
    font.family: "Open Sans SemiBold"
    contentItem: Item{
        id: itemBtn
        Text {
            id: name
            text: button.text
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignBottom
            anchors.leftMargin: 2
            anchors.bottomMargin: 5
            font: button.font
            color: internal.dynamicColorText
        }
        Image {
            id: icon
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 2
            anchors.topMargin: 2
            sourceSize.height: 25
            sourceSize.width: 25
            fillMode: Image.PreserveAspectFit
            antialiasing: false
        }
    }

    background: Rectangle{
        color: internal.dynamicColor
        radius: 10
    }
}
/*##^##
Designer {
    D{i:0;formeditorZoom:2}
}
##^##*/
