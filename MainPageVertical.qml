import QtQuick 2.15

Grid {
   rows: 3
   columns: 1

   Rectangle {
       width: parent.width
       height: parent.height * 0.5
       color: "transparent"

       Text {
           id: alcLevelText
           anchors.centerIn: parent
           text: appWindow.alcLevel
           font.pixelSize: 90
       }

       Text {
           anchors {
                horizontalCenter: alcLevelText.horizontalCenter
                top: alcLevelText.bottom
                topMargin: 10
           }
           text: "Number of drinks consumed: " + appWindow.drinkList.count
           font.pixelSize: 20
       }


   }

   Row {
       height: parent.height * 0.25
       width: parent.width
       spacing: parent.width * 0.05
       leftPadding: parent.width * 0.025
       Rectangle {
           height: parent.height * 0.9
           width: parent.width * 0.45
           color: "transparent"
           border.color: "teal"
           border.width: 2
           radius: height * 0.2
           Text {
               anchors.centerIn: parent
               text: "BEER"
           }
           MouseArea {
               anchors.fill: parent
               onClicked: stack.push("qrc:/BeerDialogue.qml")
           }
       }
       Rectangle {
           height: parent.height * 0.9
           width: parent.width * 0.45
           color: "transparent"
           border.color: "teal"
           border.width: 2
           radius: height * 0.2
           Text {
               anchors.centerIn: parent
               text: "WINE"
           }
           MouseArea {
               anchors.fill: parent
               onClicked: stack.push("qrc:/WineDialogue.qml")
           }
       }
   }

   Row {
       height: parent.height * 0.25
       width: parent.width
       spacing: parent.width * 0.05
       leftPadding: parent.width * 0.025
       Rectangle {
           height: parent.height * 0.9
           width: parent.width * 0.45
           color: "transparent"
           border.color: "teal"
           border.width: 2
           radius: height * 0.2
           Text {
               anchors.centerIn: parent
               text: "SHOT"
           }
           MouseArea {
               anchors.fill: parent
               onClicked: stack.push("qrc:/BeerDialogue.qml")
           }
       }
       Rectangle {
           height: parent.height * 0.9
           width: parent.width * 0.45
           color: "transparent"
           border.color: "teal"
           border.width: 2
           radius: height * 0.2
           Text {
               anchors.centerIn: parent
               text: "GROGG"
           }
           MouseArea {
               anchors.fill: parent
               onClicked: stack.push("qrc:/BeerDialogue.qml")
           }
       }
   }
}

