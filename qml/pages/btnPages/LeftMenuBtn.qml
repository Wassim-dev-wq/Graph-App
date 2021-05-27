import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id : btnLeftMenu
    text: qsTr('Left Menu Text')

    // property
    property url btnIconSource: "../../images/svg_images/home_icon.svg"
    property color btnColorDefault: "#ffffff"
    property color btnColorMouseOver: "#a5cae2"
    property color btnColorMouseClicked: "#387ead"
    property int iconWidth: 18
    property int iconHeight: 18
    property color activeMenuColorLeft: "#2d8ecd"
 //   property color activeMenuColorRight: "#64e241"
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
            color: activeMenuColorLeft
        }
        // Rectangle{
        //     anchors{
        //         top: parent.top
        //         right: parent.right
        //         bottom: parent.bottom
        //     }
        //     width: 3
        //     visible: isActiveMenu
        //     color: activeMenuColorRight
        // }
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
            color: "#898d8f"
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: iconHeight
            width: iconWidth
        }
        Text {
            color: "#898d8f"
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
