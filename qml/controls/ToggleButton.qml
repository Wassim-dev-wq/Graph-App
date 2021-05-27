import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id : btnToggle

    // property
    property url btnIconSource: "../../images/svg_images/menu_icon.svg"
    property color btnColorDefault: "#ffffff"
    property color btnColorMouseOver: "#a5cae2"
    property color btnColorMouseClicked: "#387ead"

    QtObject{
        id: internal
        property var dynamicColor: if(btnToggle.down){
                                       btnToggle.down ? btnColorMouseClicked : btnColorDefault
                                   }else {
                                       btnToggle.hovered ? btnColorMouseOver : btnColorDefault
                                   }

    }


    implicitWidth: 70
    implicitHeight: 60
    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
        }
        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#898d8f"
            antialiasing: false
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}
}
##^##*/
