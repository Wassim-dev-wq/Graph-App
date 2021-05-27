import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../controls"

Item {
    property color predecesseurInputBorder: "#a3c2c2"
    width: 1020
    height: 415
    Rectangle {
        id: rectangle
        color: "#f4f8f9"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        
        Rectangle {
            id: predecesseurContainer
            x: 50
            y: 100
            width: 400
            height: 254
            color: "#ffffff"
            radius:5
            anchors.left: parent.left
            anchors.leftMargin: 36

            Label {
                id: predecesseurLabel
                x: 17
                y: 27
                width: 201
                height: 22
                color: "#7FB3D5"
                text: qsTr("Entrer le sommet :")
                font.pointSize: 11
                font.family: "Open Sans"
                font.bold: true
            }
            TextField {
                id: predecesseurInput
                x: 17
                y: 98
                placeholderText: qsTr("Sommet")
                background: Rectangle {
                    radius: 5
                    implicitWidth: 70
                    implicitHeight: 40
                    border.color: predecesseurInputBorder
                    border.width: 1
                }
            }
            SequentialAnimation {
                id: emptyInputmWarning
                NumberAnimation {
                    target: predecesseurInput
                    properties: "y"
                    to: 108
                    duration: 60
                }
                NumberAnimation {
                    target: predecesseurInput
                    properties: "y"
                    to: 98
                    duration: 50
                }
            }
            SequentialAnimation {
                id: succedInputmWarning
                NumberAnimation {
                    target: predecesseurInput
                    properties: "x"
                    to: 50
                    duration: 60
                }
                NumberAnimation {
                    target: predecesseurInput
                    properties: "x"
                    to: 17
                    duration: 50
                }
            }
            SendBtn {
                id: savePredecesseur
                x: 217
                y: 183
                text :"Prédécesseur"
                clip: true
                onClicked:{
                    if (predecesseurInput.text ===""){
                        emptyInputmWarning.running = true
                        emptyInputmWarning.running = true
                        predecesseurInputBorder= "#ff6666"
                        predecesseurInputBorder= "#ff6666"
                        var warnLabel= Qt.createQmlObject(
                                    'import QtQuick.Controls 2.15;Label {id: label;x: 17;y: 80;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer un sommet valide");font.pointSize: 9;styleColor: "#ffffff"}'
                                    ,predecesseurContainer, "dynamicSnippet1");
                        warnLabel.destroy(1000);}
                    else {
                        backend.checkNodeExist(predecesseurInput.text)}
                }
            }

        }
        DropShadow{
            anchors.fill: predecesseurContainer
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: predecesseurContainer
            z: 0
        }

        Rectangle {
            id: infoPredecesseurContainer
            x: 500
            y: 100
            width: 0
            height: 254
            color: "#ffffff"
            radius: 5
            Label {
                id: predLabel
                x: 126
                y: 19
                width: 92
                height: 26
                color: "#7FB3D5"
                text: qsTr("")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Open Sans"
                font.bold: true
                font.pointSize: 14
            }

            Label {
                id: infoContainer
                x: 28
                y: 76
                width: 289
                height: 103
                color: "#476b6b"
                text: ""
                wrapMode: Text.WrapAnywhere
                font.pointSize: 12
            }
        }
        PropertyAnimation{
            id: infopPredecessurContainerAnimation
            target: infoPredecesseurContainer
            properties: "width"
            from : 0
            to: 460
            duration: 300
            easing.type: Easing.OutExpo
        }
        DropShadow{
            anchors.fill: infoPredecesseurContainer
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: infoPredecesseurContainer
            z: 0
        }

    }
    Connections{
        target: backend
        function onSetExist(val){
            console.log(val)
            if(val === "True"){
                succedInputmWarning.running = true;
                backend.predecesseurNode(predecesseurInput.text)
                infopPredecessurContainerAnimation.running = true
                predLabel.text= "Prédécesseur"
                predecesseurInputBorder= "#80ff80"
                predecesseurInput.text = "";
            }else if (val === "False"){
                var warnLabel= Qt.createQmlObject(
                    'import QtQuick.Controls 2.15;Label {id: label;x: 17;y: 80;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer un sommet valide");font.pointSize: 9;styleColor: "#ffffff"}'
                    ,predecesseurContainer, "dynamicSnippet1");
                warnLabel.destroy(1000);               
                predecesseurInputBorder= "#ff6666"
                emptyInputmWarning.running = true;}}  

        function onSetData(getData){
            infoContainer.text = getData
        }     
    }   
}
/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:13;invisible:true}D{i:18;invisible:true}
}
##^##*/
