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

   Grid {
       id: buttonGrid
       rows: 2
       columns: 2

       width: parent.width
       height: parent.height * 0.5
       anchors {
           top: alcLevelContainer.bottom
       }
       horizontalItemAlignment: Grid.AlignHCenter
       verticalItemAlignment: Grid.AlignVCenter
       leftPadding: spacing
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
           pushObject: "qrc:/qml/components/BeerDialogue.qml"
       }

       MainButton {
           text: "DRINK"
           pushObject: "qrc:/qml/components/BeerDialogue.qml"
       }
   }
}
