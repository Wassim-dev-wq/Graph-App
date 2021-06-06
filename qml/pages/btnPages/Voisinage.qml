import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../controls"

Item {

    property color voisinInputBorder: "#a3c2c2"
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
            anchors.left: parent.left
            cache: false
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: voisinContainer.left
            source: "../../../graphe_images/graphImg.png"
            anchors.leftMargin: 16
            anchors.rightMargin: 44
            anchors.bottomMargin: 35
            anchors.topMargin: 31
            function reloadImage() {
                var oldSource = source
                source = ""
                source = oldSource
            }
        }
        
        Rectangle {
            id: voisinContainer
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
                id: voisinLabel
                x: 17
                y: 19
                width: 201
                height: 22
                color: "#7FB3D5"
                text: qsTr("Voisinage")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 12
                font.family: "Open Sans"
            }
            TextField {
                id: voisinInput
                x: 139
                width: 74
                height: 33
                anchors.top: voisinLabel.bottom
                anchors.topMargin: 22
                placeholderText: qsTr("Sommet")
                background: Rectangle {
                    radius: 5
                    implicitWidth: 70
                    implicitHeight: 40
                    border.color: voisinInputBorder
                    border.width: 1
                }
            }
            
            SequentialAnimation {
                id: emptyInputmWarning
                NumberAnimation {
                    target: voisinInput
                    properties: "anchors.topMargin"
                    to: 32
                    duration: 60
                }
                NumberAnimation {
                    target: voisinInput
                    properties: "anchors.topMargin"
                    to: 22
                    duration: 50
                }
            }
            SequentialAnimation {
                id: succedInputmWarning
                NumberAnimation {
                    target: voisinInput
                    properties: "x"
                    to: 169
                    duration: 60
                }
                NumberAnimation {
                    target: voisinInput
                    properties: "x"
                    to: 139
                    duration: 50
                }
            }
            SendBtn {
                id: voisinBtn
                width: 71
                height: 33
                clip: true
                text:"Voisin"
                anchors.left: voisinInput.right
                anchors.top: voisinLabel.bottom
                anchors.leftMargin: 35
                anchors.topMargin: 22
                onClicked:{
                    imageGraph.reloadImage()
                    if (voisinInput.text ===""){
                        emptyInputmWarning.running = true
                        voisinInputBorder= "#ff6666"
                        var warnLabel= Qt.createQmlObject(
                                'import QtQuick.Controls 2.15;Label {id: label;x: 139;y: 45;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer un sommet valide");font.pointSize: 9;styleColor: "#ffffff"}'
                                ,voisinContainer, "dynamicSnippet1");
                        warnLabel.destroy(1000);}
                    else {
                        backend.checkNodeExist(voisinInput.text)}
                }
                }       

            Label {
                id: voisinage
                color: "#535b60"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: voisinInput.bottom
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WrapAnywhere
                anchors.bottomMargin: 136
                anchors.topMargin: 50
                anchors.rightMargin: 8
                anchors.leftMargin: 30
                font.family: "Open Sans"
                font.pointSize: 13
            }
        
        
        }
        DropShadow{
            anchors.fill: voisinContainer
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: voisinContainer
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
                backend.voisinNode(voisinInput.text)
                voisinInputBorder= "#80ff80"
                voisinInput.text = "";
            }else if (bol === "False"){
                var warnLabel= Qt.createQmlObject(
                    'import QtQuick.Controls 2.15;Label {id: label;x: 139;y: 40;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer un sommet valide");font.pointSize: 9;styleColor: "#ffffff"}'
                    ,voisinContainer, "dynamicSnippet1");
                warnLabel.destroy(1000);               
                voisinInputBorder= "#ff6666"
                emptyInputmWarning.running = true;}}  

        function onSetDataVoisin(data){
            voisinage.text=data
        }

    }   
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:2}D{i:5}D{i:9;invisible:true}D{i:13}D{i:15;invisible:true}
D{i:16;invisible:true}
}
##^##*/
