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
    property color btnColorDefault: "#ffffff"
    property color btnColorMouseOver: "#D4E6F1"
    property color textColorHover: "#726E6B"
    property color textColorDefault: "#5499C7"
    property color btnColorMouseClicked: "#6CDFC2"    
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
        border.color: "#AED6F1"
        radius: 3
       }
    contentItem: Item {
        anchors.fill: parent
        id: content
        Text {
            color : internal.dynamicColorText
            text: sendBtn.text
            font: sendBtn.font
            anchors.verticalCenter: parent.verticalCenter           
            anchors.horizontalCenter: parent.horizontalCenter
            
        }
    }

}