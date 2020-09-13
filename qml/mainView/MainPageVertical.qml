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
            color: colors.primaryText
        }

        Text {
            anchors {
                horizontalCenter: alcLevelText.horizontalCenter
                top: alcLevelText.bottom
                topMargin: 10
            }
            text: "Number of drinks consumed: " + main.drinkList.count
            font.pixelSize: 20
            color: colors.primaryText
        }
   }

   Grid {
       id: buttonGrid
       rows: 2
       columns: 2

       width: parent.width
       height: parent.height * 0.5
       anchors {
           top: alcLevelContainer.bottom
       }
       leftPadding: spacing
       topPadding: spacing
       spacing: 10

       MainButton {
           text: "BEER"
           pushObject: "qrc:/qml/components/BeerDialogue.qml"
       }

       MainButton {
           text: "WINE"
           pushObject: "qrc:/qml/components/WineDialogue.qml"
       }

       MainButton {
           text: "SHOT"
           pushObject: "qrc:/qml/components/ShotDialogue.qml"
       }

       MainButton {
           text: "Cocktail"
           pushObject: "qrc:/qml/components/ShotDialogue.qml"
       }
   }
}

