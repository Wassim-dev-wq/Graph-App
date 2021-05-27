import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
Rectangle {
            id: saveInfoContainer1
            x: 36
            y: 49
            width: 336
            height: 25
            color: "#52be80"
            radius: 5
            Label {
                id: saveInfoLabel1
                y: 3
                height: 27
                color: "#ffffff"
                text: qsTr("les informations ont été enregistrées avec succès ")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 9
                anchors.verticalCenterOffset: 0
                font.family: "Open Sans"
                anchors.leftMargin: 31
                anchors.rightMargin: 270
                font.bold: true
            }

            Image {
                id: image1
                x: 9
                y: 0
                width: 15
                height: 15
                anchors.verticalCenter: parent.verticalCenter
                source: "../../../images/svg_images/tooltip_icon.svg"
                anchors.verticalCenterOffset: 0
                fillMode: Image.PreserveAspectFit
            }
        }