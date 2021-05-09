import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id : btnLeftMenu
    text: qsTr('Left Menu Text')

    // property
    property url btnIconSource: "../../images/svg_images/home_icon.svg"
    property color btnColorDefault: "#354052"
    property color btnColorMouseOver: "#47bac1"
    property color btnColorMouseClicked: "#6CDFC2"
    property int iconWidth: 18
    property int iconHeight: 18
    property color activeMenuColor: "#64e241"
    property color activeMenuColorRight: "#e2e277"
    property bool isActiveMenu: false

    QtObject{
        id: internal
        property var dynamicColor: if(btnLeftMenu.down){
                                       btnLeftMenu.down ? btnColorMouseClicked : btnColorDefault
                                   }else {
                                       btnLeftMenu.hovered ? btnColorMouseOver : btnColorDefault
                                   }

    }


    implicitWidth: 250
    implicitHeight: 60
    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        Rectangle{
            anchors{
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            width: 3
            visible: isActiveMenu
            color: activeMenuColor
        }
        Rectangle{
            anchors{
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }
            width: 5
            visible: isActiveMenu
            color: activeMenuColorRight
        }
       }
    contentItem: Item {
        anchors.fill: parent
        id: content
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.leftMargin: 26
            anchors.left: parent.left
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            width: iconWidth
            height: iconHeight
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: true
        }
        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: iconHeight
            width: iconWidth
        }
        Text {
            color: "#ffffff"
            text: btnLeftMenu.text
            font: btnLeftMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}
}
##^##*/
