import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id : btnGraphMenu
    text: qsTr('Graph Menu Text')

    // property
    property url btnIconSource: "../../images/svg_images/leftClick_icon.svg"
    property color btnColorDefault: "#ffffff"
    property color btnColorMouseOver: "#a1d0db"
    property color btnColorMouseClicked: "#6CDFC2"
    property color textColorHover: "#ffffff"
    property color textColorDefault: "#898d8f"
    property bool isActive: false

    property int iconWidth: 17
    property int iconHeight: 17

    QtObject{
        id: internal
        property var dynamicColor: if(btnGraphMenu.down){
                                       btnGraphMenu.down ? btnColorMouseClicked : btnColorDefault
                                   }else {
                                       btnGraphMenu.hovered ? btnColorMouseOver : btnColorDefault
                                   }
        property var dynamicColorText: if(btnGraphMenu.down){
                                       btnGraphMenu.down ? textColorHover : textColorDefault
                                   }else {
                                       btnGraphMenu.hovered ? textColorHover : textColorDefault
                                   }    
    }


    implicitWidth: 250
    implicitHeight: 60
    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        Rectangle{
            anchors{
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }
            height: 1
            visible: true
            color: "#9cc0c9"
            opacity: 0.3
        }
        Rectangle{
            anchors{
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            width: 1
            visible: true
            color: "#9cc0c9"
            opacity: 0.3
        }
        Rectangle{
            anchors{
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            width: 3
            visible: isActive
            color: "#add8e6"
        }
       }
       
    contentItem: Item {
        anchors.fill: parent
        id: content
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.right: parent.right
            anchors.rightMargin: 11
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            width: iconWidth
            height: iconHeight
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            visible: true
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
            color: internal.dynamicColorText
            text: btnGraphMenu.text
            font: btnGraphMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 12
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}
}
##^##*/
