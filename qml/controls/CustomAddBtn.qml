import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id : addBtn
    text: qsTr('Add')
    font.family: "Segoe UI"
    font.pointSize: 10
    font.bold: true
    // property
    property url btnIconSource: "../../images/svg_images/add_icon.svg"
    // // property color btnColorDefault: "#647dfe"
    // //   //  property color btnColorDefault: "#11a0f8"
    // // property color btnColorMouseOver: "#47bac1"
    // // property color btnColorMouseClicked: "#6CDFC2"
    property color btnColorDefault: "#ffffff"
    property color btnColorMouseOver: "#33ab94"
    property color textColorHover: "#ffffff"
    property color textColorDefault: "#76D7C4"
    property color btnColorMouseClicked: "#6CDFC2"    
    property color colDisabled: "#45B39D"
    property int iconWidth: 5
    property int iconHeight: 5
    property color activeMenuColorLeft: "#45B39D"

    QtObject{
        id: internal
        property var dynamicColor: if(addBtn.down){
                                       addBtn.down ? btnColorMouseClicked : btnColorDefault
                                   }else {
                                       addBtn.hovered ? btnColorMouseOver : btnColorDefault
                                   }
        property var dynamicColorText: if(addBtn.down){
                                       addBtn.down ? textColorHover : textColorDefault
                                   }else {
                                       addBtn.hovered ? textColorHover : textColorDefault
                                   }    
    }


    implicitWidth: 130
    implicitHeight: 30       
    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        border.color: "#76D7C4"
        radius: 5
       }
    contentItem: Item {
        anchors.fill: parent
        id: content
        Text {
            color : internal.dynamicColorText
            text: addBtn.text
            font: addBtn.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}
}
##^##*/
