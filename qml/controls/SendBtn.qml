import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id : sendBtn
    text: qsTr('Successeur')
    font.family: "Segoe UI"
    font.pointSize: 10
    font.bold: true
    // property
    property url btnIconSource: "../../images/svg_images/send_icon.svg"
    property color btnColorDefault: "#ffffff"
    property color btnColorMouseOver: "#33ab94"
    property color textColorHover: "#ffffff"
    property color textColorDefault: "#76D7C4"
    property color btnColorMouseClicked: "#6CDFC2"    
    property color colDisabled: "#45B39D"
    property int iconWidth: 20
    property int iconHeight: 20
    property color activeMenuColorLeft: "#45B39D"

    QtObject{
        id: internal
        property var dynamicColor: if(sendBtn.down){
                                       sendBtn.down ? btnColorMouseClicked : btnColorDefault
                                   }else {
                                       sendBtn.hovered ? btnColorMouseOver : btnColorDefault
                                   }
        property var dynamicColorText: if(sendBtn.down){
                                       sendBtn.down ? textColorHover : textColorDefault
                                   }else {
                                       sendBtn.hovered ? textColorHover : textColorDefault
                                   }    
    }


    implicitWidth: 130
    implicitHeight: 30       
    background: Rectangle {
        id: bgBtn
        color : internal.dynamicColor
        border.color: "#76D7C4"
        radius: 5
       }
    contentItem: Item {
        anchors.fill: parent
        id: content
            Image {
            id: iconBtn
            source: btnIconSource
            anchors.leftMargin: 95
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
            color: "#76D7C4"
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: iconHeight
            width: iconWidth
        }
        Text {
            color : internal.dynamicColorText
            text: sendBtn.text
            font: sendBtn.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 12
        }
    }

}