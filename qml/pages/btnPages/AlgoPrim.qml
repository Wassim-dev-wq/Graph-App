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
            anchors.right : algoPrimContainer.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left:parent.left
            anchors.rightMargin: 32
            anchors.leftMargin: 18
            source: "../../../graphe_images/graphImg.png"
            anchors.topMargin: 31
            anchors.bottomMargin: 35
            function reloadImage() {
                var oldSource = "../../../graphe_images/algoPrimGraph.png"
                source = ""
                source = oldSource
            }
        }
        
        Rectangle {
            id: algoPrimContainer
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
                id: algoPrimLabel
                x: 17
                y: 19
                width: 201
                height: 22
                color: "#7FB3D5"
                text: qsTr("Algorithme de Prim")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 13
                font.family: "Open Sans"
                font.bold: true
            }
            TextField {
                id: sourceInput
                x: 115
                y: 63
                width: 69
                height: 32
                placeholderText: qsTr("Source")
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
                    target: sourceInput
                    properties: "y"
                    to: 53
                    duration: 60
                }
                NumberAnimation {
                    target: sourceInput
                    properties: "y"
                    to: 63
                    duration: 50
                }
            }
            SequentialAnimation {
                id: succedInputmWarning
                NumberAnimation {
                    target: sourceInput
                    properties: "x"
                    to: 130
                    duration: 60
                }
                NumberAnimation {
                    target: sourceInput
                    properties: "x"
                    to: 99
                    duration: 50
                }
            }
            RunAlgosBtn {
                id: primTrigerBtn
                x: 213
                y: 64
                width: 103
                height: 30
                clip: true
                text:"Executer Prim"
                onClicked:{
                    if (sourceInput.text ===""){
                        emptyInputmWarning.running = true
                        sourceInputBorder= "#ff6666"
                        var warnLabel= Qt.createQmlObject(
                                'import QtQuick.Controls 2.15;Label {id: label;x: 115;y: 47;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer un sommet valide");font.pointSize: 9;styleColor: "#ffffff"}'
                                ,algoPrimContainer, "dynamicSnippet1");
                        warnLabel.destroy(1000);}
                    else {
                        backend.checkNodeExist(sourceInput.text)}
                }
            }              

            Label {
                id: algoPrim
                x: 47
                width: 369
                height: 30
                color: "#535b60"
                anchors.top: algoPrim2.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WrapAnywhere
                anchors.topMargin: 6
                font.family: "Open Sans"
                font.pointSize: 12
                font.bold: false
            }

            Label {
                id: algoPrim1
                x: 11
                width: 278
                height: 30
                visible: false
                color: "#535b60"
                text: "D'aprés l'algorithme :"
                anchors.top: primTrigerBtn.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                anchors.topMargin: 22
                font.pointSize: 13
                font.bold: false
                font.family: "Open Sans"
            }

            Label {
                id: algoPrim2
                x: 47
                width: 369
                height: 30
                color: "#535b60"
                anchors.top: algoPrim1.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WrapAnywhere
                font.pointSize: 12
                font.bold: false
                font.family: "Open Sans"
                anchors.topMargin: 21
            }
        
        
        }
        DropShadow{
            anchors.fill: algoPrimContainer
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: algoPrimContainer
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
        function onSetExist(bol){
            if(bol === "True"){
                succedInputmWarning.running = true;
                backend.minPrim('notDirected',sourceInput.text)
                imageGraph.reloadImage()
                algoPrim1.visible = true
                sourceInputBorder= "#80ff80"
                sourceInput.text = "";
            }else if (bol === "False"){
                var warnLabel= Qt.createQmlObject(
                    'import QtQuick.Controls 2.15;Label {id: label;x: 115;y: 47;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer un sommet valide");font.pointSize: 9;styleColor: "#ffffff"}'
                    ,algoPrimContainer, "dynamicSnippet1");
                warnLabel.destroy(1000);               
                sourceInputBorder= "#ff6666"
                emptyInputmWarning.running = true;}}    

        function onSetDataPrim(data){
            algoPrim2.text=data
        }
        function onSetDataPrimm(data) {
            algoPrim.text = data
        }

    }   
}


