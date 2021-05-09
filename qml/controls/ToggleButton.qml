import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id : btnToggle

    // property
    property url btnIconSource: "../../images/svg_images/menu_icon.svg"
    property color btnColorDefault: "#354052"
    property color btnColorMouseOver: "#47bac1"
    property color btnColorMouseClicked: "#82ECF3"

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
            color: "#ffffff"
            antialiasing: false
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}
}
##^##*/
