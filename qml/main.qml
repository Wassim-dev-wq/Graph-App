import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "controls"

Window {
    flags: Qt.Window | Qt.FramelessWindowHint
    id: window
    width: 1100
    height: 650
    minimumWidth: 700
    minimumHeight: 500
    visible: true
    color: "#00000000"
    title: qsTr("Hello World")

    //proprety

    property int windowStatus: 0
    property int windowMargin: 10


    //functions
    QtObject{
        id:internal

        function resizeBorders(){
            resizeBottom.visible= true
            resizeLeft.visible =true
            resizeRight.visible= true
        }

        function restoreMax(){
            if(windowStatus === 0) {
                window.showMaximized()
                btnMaximize.btnIconSource = "../images/svg_images/restore_icon.svg"
                resizeBottom.visible =false
                resizeLeft.visible= false
                resizeRight.visible= false
                windowStatus = 1
                windowMargin = 0
            }else{
                window.showNormal()
                btnMaximize.btnIconSource = "../images/svg_images/maximize_icon.svg"
                internal.resizeBorders()
                windowStatus = 0
                windowMargin = 10
            }
        }
        function maxWindowRestore(){
            if(windowStatus == 1){
                window.showNormal()
                internal.resizeBorders()
                windowStatus = 0
                windowMargin = 10
            }
        }
        function restoreMinimizeMargins(){
            internal.resizeBorders()
            windowStatus =0
            windowMargin=10
        }

    }

    Rectangle {
        id: rectangle
        color: "#55aaff"
        border.color: "#201c1c"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: windowMargin
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin

        Rectangle {
            id: upcontainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topbar
                height: 60
                color: "#f5f9fc"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 0

                ToggleButton {
                    id: menuBtn
                    onClicked: animationMenu.running=true

                }

                Row {
                    id: rowBtns
                    x: 889
                    width: 105
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.topMargin: 0

                    TopBarButton {
                        id: btnMinimize
                        btnIconSource: "../images/svg_images/minimize_icon.svg"
                        onClicked:{
                            window.showMinimized()
                            internal.restoreMinimizeMargins()
                        }
                    }

                    TopBarButton {
                        id: btnMaximize
                        btnIconSource: "../images/svg_images/maximize_icon.svg"
                        onClicked: internal.restoreMax()
                    }

                    TopBarButton {
                        id: btnClose
                        btnIconSource: "../images/svg_images/close_icon.svg"
                        onClicked: window.close()
                    }
                }

            }

            Rectangle {
                id: content
                color: "#ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topbar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#354052"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0

                    PropertyAnimation{
                        id: animationMenu
                        target: leftMenu
                        properties: "width"
                        to: if(leftMenu.width==70) return 210;
                            else return 70
                        duration: 500
                        easing.type: Easing.InOutQuint
                    }

                    Column {
                        id: column
                        width: 37
                        height: 309
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 90
                        anchors.topMargin: 0

                        LeftMenuBtn {
                            id: btnHome
                            width: leftMenu.width
                            text: qsTr("Home")
                            font.letterSpacing: 1.3
                            btnIconSource: "../images/svg_images/home_icon.svg"
                            font.weight: Font.Medium
                            font.capitalization: Font.Capitalize
                            iconWidth: 19
                            iconHeight: 19
                            font.bold: false
                            font.pointSize: 10
                            font.family: "Verdana"
                            isActiveMenu: true
                            onClicked: {
                                btnHome.isActiveMenu=true
                                btnSettings.isActiveMenu=false
                                stackView.push(Qt.resolvedUrl("pages/Home.qml"))
                                //                                pageView.setSource(Qt.resolvedUrl("pages/Home.qml"))

                            }
                        }

                        LeftMenuBtn {
                            id: btnOpen
                            width: leftMenu.width
                            text: qsTr("Open")
                            font.letterSpacing: 1.3
                            font.weight: Font.Medium
                            font.pointSize: 10
                            font.family: "Verdana"
                            font.capitalization: Font.Capitalize
                            iconWidth: 19
                            iconHeight: 19
                            btnIconSource: "../images/svg_images/open_icon.svg"
                            autoRepeat: false
                        }

                        LeftMenuBtn {
                            id: btnSave
                            width: leftMenu.width
                            text: qsTr("Save")
                            font.letterSpacing: 1.3
                            font.weight: Font.Medium
                            font.capitalization: Font.Capitalize
                            font.pointSize: 10
                            font.family: "Verdana"
                            iconWidth: 19
                            iconHeight: 19
                            btnIconSource: "../images/svg_images/save_icon.svg"
                        }
                    }

                    LeftMenuBtn {
                        id: btnSettings
                        x: 0
                        y: 323
                        width: leftMenu.width
                        text: qsTr("Settings")
                        anchors.bottom: parent.bottom
                        font.letterSpacing: 1.3
                        font.pointSize: 10
                        font.family: "Verdana"
                        font.weight: Font.Medium
                        font.capitalization: Font.Capitalize
                        iconWidth: 20
                        iconHeight: 20
                        clip: true
                        anchors.bottomMargin: 25
                        btnIconSource: "../images/svg_images/settings_icon.svg"
                        onClicked: {
                            btnHome.isActiveMenu=false
                            btnSettings.isActiveMenu=true
                            stackView.push(Qt.resolvedUrl("pages/Settings.qml"))
                            //                            pageView.setSource(Qt.resolvedUrl("pages/Settings.qml"))
                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        initialItem: Qt.resolvedUrl("pages/Home.qml")
                    }
                    //                    Loader{
                    //                        id: pageView
                    //                        anchors.fill: parent
                    //                        source: Qt.resolvedUrl("pages/Home.qml")
                    //                    }

                }

                Rectangle {
                    id: rectangle1
                    color: "#c7c7c7"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    Label {
                        id: labelBotInfo1
                        width: 639
                        height: 17
                        text: qsTr("Appliication Description")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.topMargin: 0
                        anchors.rightMargin: 30
                        font.pointSize: 10
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 10
                    }

                    MouseArea {
                        id: mouseArea
                        x: 883
                        y: -25
                        width: 25
                        height: 25
                        opacity: 0.5
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        cursorShape: Qt.SizeFDiagCursor
                        DragHandler {
                            target: null
                            onActiveChanged: if(active){
                                                 window.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                             }
                        }

                        Image {
                            id: image
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            source: "../images/svg_images/resize_icon.svg"
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            anchors.bottomMargin: 0
                            anchors.rightMargin: 0
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                    }
                }
            }
        }
    }
    DropShadow{
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#ec2020"
        source: bg
        z: 0
    }

    MouseArea {
        id: resizeLeft
        width: 10
        height: 0
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 window.startSystemResize(Qt.LeftEdge)
                             }
        }
    }
    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.rightMargin: 0
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 window.startSystemResize(Qt.RightEdge)
                             }
        }
    }
    MouseArea {
        id: resizeBottom
        width: 980
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 window.startSystemResize(Qt.BottomEdge)
                             }
        }
    }

    Connections{
        target: backend
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
