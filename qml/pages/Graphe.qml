import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.11
import "componentCreation.js" as MyScript
import "../controls"

Item {
    property color inBorderColor: "#a3c2c2"
    property color inBorderColorEdge: "#a3c2c2"
    property var newobj1: null
    property var newobj2: null
    property url getImageSource: "../../graph/path.jpg"
    property url setSourceGraphImg: "../../graph/graphImg.jpg"

    QtObject{
        id: internal
        function updateGraph(){
            graphImage.source="../../graph/path1.png"
        }
        function loadGraph(){
            image.source ="../../graph/graphimg.png"
        }
        function setVisible(){
            saveInfoContainer.visible = true
            gridLayoutBottom.visible = true
            btnChooseLabel.visible = true
        }
        function addNodes(){
            var myText=1;
            for(var i=0;i<sommetInfo1.text;++i){
                var newNodeInput= Qt.createQmlObject(
                            'import "../controls"; CustomTextFieldNode {}'
                            ,nodesRowColumn, "dynamicSnippet1");
                newNodeInput.text=myText;
                backend.getSommetText(myText)
                ++myText;
            }
        }
        function emptyText(){
            sommetInfo1.isEmpty ? addNode.enabled = false : addNode.enabled
        }
    }

    Rectangle {
        id: rectangle
        visible: true
        color: "#f4f8f9"
        anchors.fill: parent
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.rightMargin: 0

        Rectangle {
            id: rectangle1
            y: 98
            width: 442
            height: 265
            color: "#ffffff"
            radius:5
            anchors.left: parent.left
            anchors.leftMargin: 36

            Label {
                id: nodeLabel
                x: 8
                y: 19
                width: 92
                height: 26
                color: "#7FB3D5"
                text: qsTr("Entrer le nombre des sommets :")
                font.family: "Open Sans"
                font.bold: true
                font.pointSize: 11
            }
            //  Component.onCompleted:
            //      {
            //          textString="Hello"
            //          textInput="textinputid2"
            //          Qt.createQmlObject(editText, columnID, "dynamicObject")
            //          textString="world"
            //          textInput="textinputid1"
            //         var obj=Qt.createQmlObject(editText,columnID, "dynamicObject")
            //      }
            // Component.onCompleted: MyScript.createSpriteObjects();

            Flickable {
                id: flickable1
                y: 91
                height: 41
                contentWidth: nodesRowColumn.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.leftMargin: 8
                clip: true
                Row {
                    id: nodesRowColumn
                    y: 0
                    width: 1800
                    spacing:10
                    height: 40
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                }
            }
            SequentialAnimation {
                id: nodeEmptyInputWarn
                NumberAnimation {
                    target: sommetInfo1
                    properties: "y"
                    to: 101
                    duration: 60
                }
                NumberAnimation {
                    target: sommetInfo1
                    properties: "y"
                    to: 91
                    duration: 50
                }
            }

            // PropertyAnimation{
            //     id: nodeEmptyInputValid
            //     target: sommetInfo1
            //     properties: "x"
            //     to: 400
            //     duration: 300
            //     easing.type: Easing.OutInCubic
            // }
            SequentialAnimation {
                id: nodeEmptyInputValid
                NumberAnimation {
                    target: sommetInfo1
                    properties: "y"
                    to: 15
                    duration: root.duration*0.8
                }
                NumberAnimation {
                    target: sommetInfo1
                    properties: "x"
                    to: 385
                    duration: root.duration*0.6
                }
            }

            TextField {
                id: sommetInfo1
                placeholderText:"Entrer le nombre de sommet"
                width:70
                x: 17
                y: 100
                background: Rectangle {
                    radius: 5
                    implicitWidth: 70
                    implicitHeight: 40
                    border.color: inBorderColor
                    border.width: 1
                }
            }

            CustomAddBtn {
                id: saveNode
                x: 367
                y: 218
                width: 56
                height: 30
                text: qsTr("Save")
                clip: true
                onClicked:{
                    console.log(sommetInfo.text)
                    console.log(sommetInfo1.text)
                    console.log(newtext.text)
                }
            }

            CustomAddBtn {
                id: addNode
                x: 207
                y: 218
                text: qsTr("Ajouter sommet")
                z:1

                MouseArea {
                    x: -207
                    y: -218
                    anchors.fill: parent
                    onClicked: {
                        if (sommetInfo1.text===""){
                            nodeEmptyInputWarn.running = true;
                            var warnLabel= Qt.createQmlObject(
                                'import QtQuick.Controls 2.15;Label {id: labelEmptyText;x: 17;y: 73;width: 192;height: 14;color: "#fa3030";text: qsTr("Veuillez Entrer nombre de sommet");font.pointSize: 10}'
                                ,rectangle1, "dynamicSnippet1");
                            warnLabel.destroy(1000);
                            inBorderColor = "#ff6666"
                        }
                        else if (sommetInfo1.text==="1"){
                            nodeEmptyInputWarn.running = true;
                            var warnLabel= Qt.createQmlObject(
                                'import QtQuick.Controls 2.15;Label {id: labelEmptyText;x: 17;y: 73;width: 192;height: 14;color: "#fa3030";text: qsTr("Veuillez Entrer un nombre plus que 1");font.pointSize: 10}'
                                ,rectangle1, "dynamicSnippet1");
                            warnLabel.destroy(1000);
                            inBorderColor = "#ff6666"
                        }
                        else{
                            internal.addNodes()
                            inBorderColor = "#80ff80"
                            sommetInfo1.readOnly= true
                            nodeEmptyInputValid.running = true
                        }
                        //backend.getSommetText(newtext.text)
                    }
                }
                //addNode.disableProperty().bind(Bindings.isEmpty(sommetInfo1.textProperty()));
                //btnIconSource: "../../images/svg_images/add_icon.svg"

            }
        }

        Rectangle {
            id: saveInfoContainer
            x: 36
            y: 59
            width: 414
            height: 25
            color: "#52BE80"
            radius:5
            visible: false

            Label {
                id: saveInfoLabel
                y: 3
                height: 27
                color: "#ffffff"
                text: qsTr("les informations ont été enregistrées avec succès ")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 31
                anchors.verticalCenterOffset: 0
                anchors.rightMargin: 270
                font.family: "Open Sans"
                font.bold: true
                font.pointSize: 9

            }

            Image {
                id: image
                x: 9
                y: 0
                width: 15
                height: 15
                anchors.verticalCenter: parent.verticalCenter
                source: "../../images/svg_images/tooltip_icon.svg"
                anchors.verticalCenterOffset: 0
                fillMode: Image.PreserveAspectFit
            }
        }

        Rectangle {
            id: rectangle2
            y: 98
            width: 466
            height: 265
            color: "#ffffff"
            radius: 5
            anchors.left: rectangle1.right
            anchors.leftMargin: 58

            Label {
                id: edgeLabel1
                x: 8
                y: 25
                width: 46
                height: 22
                color: "#7FB3D5"
                text: qsTr("Entrer les chemins :")
                font.pointSize: 11
                font.family: "Open Sans"
                font.bold: true
            }


            TextField {
                id: customEdgeTextDe
                x: 17
                y: 98
                placeholderText: qsTr("De")
                background: Rectangle {
                    radius: 5
                    implicitWidth: 70
                    implicitHeight: 40
                    border.color: inBorderColorEdge
                    border.width: 1
                }

            }

            TextField {
                id: customEdgeTextA
                x: 127
                y: 98
                placeholderText: qsTr("A")
                background: Rectangle {
                    radius: 5
                    implicitWidth: 70
                    implicitHeight: 40
                    border.color: inBorderColorEdge
                    border.width: 1
                }
            }

            SequentialAnimation {
                id: anim
                NumberAnimation {
                    target: customEdgeTextDe
                    properties: "x"
                    to: 100
                    // 60% of time to travel up
                    duration: root.duration*0.6
                }
                NumberAnimation {
                    target: customEdgeTextDe
                    properties: "x"
                    to: 17
                    // 40% of time to travel sideways
                    duration: root.duration*0.4
                }
            }
            SequentialAnimation {
                id: anim1
                NumberAnimation {
                    target: customEdgeTextA
                    properties: "x"
                    to: 220
                    // 60% of time to travel up
                    duration: root.duration*0.6
                }
                NumberAnimation {
                    target: customEdgeTextA
                    properties: "x"
                    to: 127
                    // 40% of time to travel sideways
                    duration: root.duration*0.4
                }
            }
            SequentialAnimation {
                id: animWarning
                NumberAnimation {
                    target: customEdgeTextDe
                    properties: "y"
                    to: 110
                    duration: 60
                }
                NumberAnimation {
                    target: customEdgeTextDe
                    properties: "y"
                    to: 98
                    duration: 50
                }
            }
            SequentialAnimation {
                id: animWarning1
                NumberAnimation {
                    target: customEdgeTextA
                    properties: "y"
                    to: 110
                    duration: 60
                }
                NumberAnimation {
                    target: customEdgeTextA
                    properties: "y"
                    to: 98
                    duration: 50
                }
            }

            CustomAddBtn {
                id: saveEdge
                x: 390
                y: 218
                width: 56
                height: 30
                text: qsTr("Save")
                clip: true
                onClicked:{
                    console.log(newobj1.text)
                    console.log(newobj2.text)
                }
            }

            CustomAddBtn {
                id: addEdge1
                x: 217
                y: 218
                text: qsTr(" Ajouter un chemin")
                anchors.right: parent.right
                anchors.rightMargin: 82
                btnIconSource: "../../images/svg_images/add_icon.svg"
                clip: true

                MouseArea {
                    x: -188
                    y: -218

                    anchors.fill: parent
                    onClicked: {
                        if (customEdgeTextDe.text===""||customEdgeTextA.text===""){
                            animWarning.running = true
                            animWarning1.running = true
                            inBorderColorEdge= "#ff6666"
                            inBorderColorEdge= "#ff6666"
                            var warnLabel= Qt.createQmlObject(
                                        'import QtQuick.Controls 2.15;Label {id: labelEmptyText;x: 17;y: 75;width: 192;height: 14;color: "#fa3030";text: qsTr("Remplir les cases vides");font.pointSize: 10}'
                                        ,rectangle2, "dynamicSnippet1");
                            warnLabel.destroy(1000);}
                        else {
                            backend.checkIfExist(customEdgeTextDe.text,customEdgeTextA.text)}
                        //animWarning.running = true
                        // }else if(backend.checkIfExist(customEdgeTextDe.text)){
                        //         anim.running = true
                        //         anim1.running = true
                        //         customEdgeTextDe.text = ""
                        //         customEdgeTextDe.text = ""
                        // }   else{
                        //     console.log('This',backend.checkIfExist(customEdgeTextDe.text))
                        //     animWarning.running = true
                        //     animWarning1.running = true}
                        //backend.getEdge(cheminInfo3.text,cheminInfo4.text)
                    }
                }
            }



        }
        DropShadow{
            anchors.fill: rectangle2
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: rectangle2
            z: 0
        }
        DropShadow{
            anchors.fill: rectangle1
            horizontalOffset: 0
            verticalOffset: 0
            radius: 7
            samples: 16
            color: "#475461"
            source: rectangle1
            z: 0
        }

        Rectangle {
            id: saveInfoContainer1
            x: 548
            y: 59
            width: 414
            height: 25
            visible: false
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
                source: "../../images/svg_images/tooltip_icon.svg"
                anchors.verticalCenterOffset: 0
                fillMode: Image.PreserveAspectFit
            }
        }

    }

    Connections{
        target: backend
        function onGetVal(val){
            if(val === "True"){
                anim.running = true;
                anim1.running = true;
                backend.getEdge(customEdgeTextDe.text,customEdgeTextA.text)
                inBorderColorEdge= "#80ff80"
                inBorderColorEdge= "#80ff80"
                customEdgeTextDe.text = "";
                customEdgeTextA.text = "";
            }else if (val === "False"){
                var warnLabel= Qt.createQmlObject(
                            'import QtQuick.Controls 2.15;Label {id: labelEmptyText;x: 17;y: 75;width: 192;height: 14;color: "#fa3030";text: qsTr("Veuillez Entrer un chemin valide");font.pointSize: 10}'
                            ,rectangle2, "dynamicSnippet1");
                warnLabel.destroy(1000);
                inBorderColorEdge= "#ff6666"
                inBorderColorEdge= "#ff6666"
                animWarning.running = true;
                animWarning1.running = true
            }
        }
    }
}














/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}D{i:4}D{i:13}D{i:3}D{i:22}
D{i:23}D{i:25}D{i:39}D{i:40}D{i:21}D{i:42;invisible:true}D{i:43;invisible:true}
}
##^##*/
