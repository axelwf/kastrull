import QtQuick 2.15
import "../components"

Item {
    id: root

    Item {
        id: alcLevelContainer
        width: parent.width
        height: parent.height * 0.5

        Text {
            id: alcLevelText
            anchors.centerIn: parent
            text: main.alcLevel
            font.pixelSize: 90
        }

        Text {
            anchors {
                horizontalCenter: alcLevelText.horizontalCenter
                top: alcLevelText.bottom
                topMargin: 10
            }
            text: "Number of drinks consumed: " + main.drinkList.count
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

