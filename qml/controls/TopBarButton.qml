import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id : btnTopBar

    // property
    property url btnIconSource: "../../images/svg_images/minimizee_icon.svg"
    property color btnColorDefault: "#ffffff"
    property color btnColorMouseOver: "#6CDFC2"
    property color btnColorMouseClicked: "#76cd46"

    QtObject{
        id: internal
        property var dynamicColor: if(btnTopBar.down){
                                       btnTopBar.down ? btnColorMouseClicked : btnColorDefault
                                   }else {
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }

    }


    implicitWidth: 35
    implicitHeight: 35
    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: 16
            width: 16
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
