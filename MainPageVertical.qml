import QtQuick 2.0

Grid {
   rows: 3
   columns: 1

   Rectangle {
       width: parent.width
       height: parent.height * 0.5
       color: "red"

       Text {
           anchors.centerIn: parent
           text: appWindow.alcLevel
           font.pixelSize: 90
       }
   }

   Row {
       height: parent.height * 0.25
       width: parent.width
       Rectangle {
           height: parent.height
           width: parent.width * 0.5
           color: "blue"
           Text {
                text: "Have a beer"
           }
           MouseArea {
               anchors.fill: parent
               onClicked: stack.push("qrc:/BeverageDialogue.qml")
           }
       }
       Rectangle {
           height: parent.height
           width: parent.width * 0.5
           color: "green"
           Text {
                text: "Drink some wine"
           }
       }
   }

   Row {
       height: parent.height * 0.25
       width: parent.width
       Rectangle {
           height: parent.height
           width: parent.width * 0.5
           color: "purple"
           Text {
                text: "SHOT"
           }
       }
       Rectangle {
           height: parent.height
           width: parent.width * 0.5
           color: "yellow"
           Text {
                text: "GROGG"
           }
       }
   }
}

