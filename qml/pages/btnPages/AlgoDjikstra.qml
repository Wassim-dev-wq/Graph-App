import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../controls"

Item {

    property color sourceInputBorder: "#a3c2c2"
    property url lienImage : "../../../graphe_images/algoPrimGraph.png"
    Rectangle {
        id: rectangle
        color: "#f4f8f9"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        Image {
            id: imageGraph
            cache: false
            width: 494
            anchors.right : algoDjikstraContainer.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left:parent.left
            anchors.rightMargin: 32
            anchors.leftMargin: 18
            source: "../../../graphe_images/graphImg.png"
            anchors.topMargin: 31
            anchors.bottomMargin: 35
            function reloadImage() {
                var oldSource = "../../../graphe_images/algoDjikstra.png"
                source = ""
                source = oldSource
            }
        }
        
        Rectangle {
            id: algoDjikstraContainer
            x: 526
            width: 456
            height: 349
            color: "#ffffff"
            radius:5
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 31
            anchors.bottomMargin: 35
            anchors.rightMargin: 38


            Label {
                id: algoDjikstraLabel
                x: 17
                y: 19
                width: 201
                height: 22
                color: "#7FB3D5"
                text: qsTr("Algorithme de Djikstra")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 13
                font.family: "Open Sans"
                font.bold: true
            }
            TextField {
                id: sourceInputDe
                x: 95
                y: 60
                width: 64
                height: 35
                placeholderText: qsTr("Source")
                background: Rectangle {
                    radius: 5
                    implicitWidth: 70
                    implicitHeight: 40
                    border.color: sourceInputBorder
                    border.width: 1
                }
            }
            TextField {
                id: sourceInputA
                x: 170
                y: 60
                width: 64
                height: 35
                placeholderText: qsTr("Destination")
                background: Rectangle {
                    radius: 5
                    implicitWidth: 70
                    implicitHeight: 40
                    border.color: sourceInputBorder
                    border.width: 1
                }
            }
            SequentialAnimation {
                id: emptyInputmWarning
                NumberAnimation {
                    targets:  [sourceInputDe,sourceInputA]
                    properties: "y"
                    to: 70
                    duration: 60
                }
                NumberAnimation {
                    targets:  [sourceInputDe,sourceInputA]
                    properties: "y"
                    to: 60
                    duration: 50
                }
            }
            SequentialAnimation {
                id: succedInputmWarning
                NumberAnimation {
                    target:  sourceInputDe
                    properties: "x"
                    to: 80
                    duration: 60
                }
                NumberAnimation {
                    targets: sourceInputDe
                    properties: "x"
                    to: 50
                    duration: 50
                }
            }
            SequentialAnimation {
                id: succedInputmWarning1
                NumberAnimation {
                    target:  sourceInputA
                    properties: "x"
                    to: 170
                    duration: 60
                }
                NumberAnimation {
                    targets: sourceInputA
                    properties: "x"
                    to: 140
                    duration: 50
                }
            }
            RunAlgosBtn {
                id: djikstraBtn
                x: 250
                y: 63
                width: 122
                height: 30
                clip: true
                text:"Executer Djikstra"
                onClicked:{
                    if (sourceInputDe.text ===""||sourceInputA.text===""){
                        emptyInputmWarning.running = true
                        sourceInputBorder= "#ff6666"
                        var warnLabel= Qt.createQmlObject(
                                'import QtQuick.Controls 2.15;Label {id: label;x: 97;y: 45;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer un sommet valide");font.pointSize: 9;styleColor: "#ffffff"}'
                                ,algoDjikstraContainer, "dynamicSnippet1");
                        warnLabel.destroy(1000);}
                    else if(sourceInputDe.text === sourceInputA.text){
                        emptyInputmWarning.running = true
                        sourceInputBorder= "#ff6666"
                        var warnLabel= Qt.createQmlObject(
                                'import QtQuick.Controls 2.15;Label {id: label;x: 97;y: 45;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer deux sommets différent");font.pointSize: 9;styleColor: "#ffffff"}'
                                ,algoDjikstraContainer, "dynamicSnippet1");
                        warnLabel.destroy(1000);
                    }
                    else {
                        backend.checkIfExist(sourceInputDe.text,sourceInputA.text)}
                                    
                }
            }

            Label {
                id: algoDjikstra
                height: 26
                color: "#535b60"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: algoDjikstra1.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WrapAnywhere
                anchors.topMargin: 14
                anchors.leftMargin: 47
                anchors.rightMargin: 8
                font.family: "Open Sans"
                font.pointSize: 14
                font.bold: true
            }

            Label {
                id: algoDjikstra1
                x: 0
                y: 130
                width: 232
                height: 26
                visible: false
                color: "#535b60"
                text: "D'aprés l'algorithme :"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WrapAnywhere
                font.pointSize: 13
                font.bold: true
                font.family: "Open Sans"
            }
        
        }
        DropShadow{
            anchors.fill: algoDjikstraContainer
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: algoDjikstraContainer
            z: 0
        }
        DropShadow{
            anchors.fill: imageGraph
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: imageGraph
            z: 0
        }
        

    }
    Connections{
        target: backend
        function onGetVal(bol){
            if(bol === "True"){
                succedInputmWarning.running = true;
                succedInputmWarning1.running = true
                backend.djikstraAlgo('notDirected',sourceInputDe.text,sourceInputA.text)
                imageGraph.reloadImage();
                algoDjikstra1.visible = true
                sourceInputBorder= "#80ff80";
                sourceInputDe.text = "";
                sourceInputA.text = "";
            }else if (bol === "False"){
                var warnLabel= Qt.createQmlObject(
                    'import QtQuick.Controls 2.15;Label {id: label;x: 97;y: 45;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer un sommet valide");font.pointSize: 9;styleColor: "#ffffff"}'
                    ,algoDjikstraContainer, "dynamicSnippet1");
                warnLabel.destroy(1000);               
                sourceInputBorder= "#ff6666"
                emptyInputmWarning.running = true;}}  

        function onSetDataDjikstra(data){
            algoDjikstra.text=data
        }

    }   
}



/*##^##
Designer {
    D{i:0}D{i:20}D{i:21;invisible:true}
}
##^##*/
