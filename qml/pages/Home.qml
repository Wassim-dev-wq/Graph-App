import QtQuick 2.0
import QtQuick.Controls 2.15

Item {

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent
        opacity:0
        BorderImage {
            id: borderImage
            anchors.fill: parent
            source: "../../images/svg_images/appHome.png"
    }

        SequentialAnimation {
            id: showRec
            NumberAnimation {
                    target:  rectangle
                    properties: "opacity"
                    to: 1
                    duration: 1000
                }
            }
            
            Component.onCompleted: showRec.running = true

    }
    
    
}

