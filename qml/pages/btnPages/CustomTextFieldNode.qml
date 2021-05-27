import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15



TextField {
    property color inBorderColor: "#75a3a3"
    //property string activetext
    // Component.onCompleted: {
    // var n=sommetInfo1.text;
    // var i;
    // console.log(n);
    // for(i=1;i<n;++i) {
    //     customNodesText.activetext= i
    //     backend.getSommetText(i)
    // } }
    //property var i: 0   
    id: customNodesText
    readOnly: true
    background: Rectangle {
        radius: 2
        implicitWidth: 50
        implicitHeight: 40
        border.color: inBorderColor
        border.width: 1     
    }  
}

