import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../controls"

Item {

    property color degreInputBorder: "#a3c2c2"

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
            anchors.right : degreContainer.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left:parent.left
            anchors.rightMargin: 38
            anchors.leftMargin: 18
            source: "../../../graphe_images/graphImg.png"
            anchors.bottomMargin: 35
            anchors.topMargin: 31
            function reloadImage() {
                var oldSource = source
                source = ""
                source = oldSource
            }
        }
        
        Rectangle {
            id: degreContainer
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
                id: degreLabel
                x: 17
                y: 19
                width: 201
                height: 22
                color: "#7FB3D5"
                text: qsTr("Degré")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 16
                font.family: "Open Sans"
                font.bold: true
            }
            TextField {
                id: degreInput
                x: 137
                width: 70
                height: 35
                anchors.top: degreLabel.bottom
                anchors.topMargin: 26
                placeholderText: qsTr("Sommet")
                background: Rectangle {
                    radius: 5
                    implicitWidth: 70
                    implicitHeight: 40
                    border.color: degreInputBorder
                    border.width: 1
                }
            }

            SequentialAnimation {
                id: emptyInputmWarning
                NumberAnimation {
                    target: degreInput
                    properties: "anchors.topMargin"
                    to: 36
                    duration: 60
                }
                NumberAnimation {
                    target: degreInput
                    properties: "anchors.topMargin"
                    to: 26
                    duration: 50
                }
            }
            SequentialAnimation {
                id: succedInputmWarning
                NumberAnimation {
                    target: degreInput
                    properties: "x"
                    to: 167
                    duration: 60
                }
                NumberAnimation {
                    target: degreInput
                    properties: "x"
                    to: 137
                    duration: 50
                }
            }
            SendBtn {
                id: degreBtn
                x: 226
                width: 70
                height: 35
                clip: true
                text:"Degrée"
                anchors.top: degreLabel.bottom
                anchors.topMargin: 26
                onClicked:{
                    if (degreInput.text ===""){
                        emptyInputmWarning.running = true
                        degreInputBorder= "#ff6666"
                        degreInputBorder= "#ff6666"
                        var warnLabel= Qt.createQmlObject(
                                'import QtQuick.Controls 2.15;Label {id: label;x: 139;y: 45;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer un sommet valide");font.pointSize: 9;styleColor: "#ffffff"}'
                                ,degreContainer, "dynamicSnippet1");
                        warnLabel.destroy(1000);}
                    else {
                        backend.checkNodeExist(degreInput.text)}
                }
            }              

            Label {
                id: degree
                width: 407
                color: "#535b60"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: degreInput.bottom
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WrapAnywhere
                anchors.topMargin: 50
                anchors.leftMargin: 30
                anchors.rightMargin: 8
                anchors.bottomMargin: 41
                font.family: "Open Sans"
                font.pointSize: 13
            }
        
        
        }
        DropShadow{
            anchors.fill: degreContainer
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: degreContainer
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
        
        
        Component.onCompleted: imageGraph.reloadImage()
        

    }
    Connections{
        target: backend
        function onSetExist(bol){
            if(bol === "True"){
                succedInputmWarning.running = true;
                backend.degreGrapheNode(degreInput.text)
                degreInputBorder= "#80ff80"
                degreInput.text = "";
            }else if (bol === "False"){
                var warnLabel= Qt.createQmlObject(
                    'import QtQuick.Controls 2.15;Label {id: label;x: 139;y: 45;width: 220;height: 14;color: "#ff6666";text: qsTr("Veuillez entrer un sommet valide");font.pointSize: 9;styleColor: "#ffffff"}'
                    ,degreContainer, "dynamicSnippet1");
                warnLabel.destroy(1000);               
                degreInputBorder= "#ff6666"
                emptyInputmWarning.running = true;}}  

        function onSetData(data){
            degree.text = data
        }     

    }   
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:2}D{i:5}D{i:13}D{i:15;invisible:true}D{i:16;invisible:true}
}
##^##*/
