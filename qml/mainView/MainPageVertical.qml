import QtQuick 2.13
import "../components"

Item {
    id: root

    Item {
        id: alcLevelContainer
        width: parent.width
        height: parent.height * 0.5

        Rectangle {
            id: alcLevelTextHolder
            color: "transparent"
            border.color: "white"
            width: parent.width
            height: parent.height / 2

            Text {
                id: alcLevelText
                anchors.centerIn: parent
                text: main.alcLevel
                font.pixelSize: 90
                color: colors.primaryText
            }
        }

        Rectangle {
            id: consumedDrinksHolder
            color: "transparent"
            border.color: "blue"
            width: parent.width
            height: parent.height
            anchors.top: alcLevelTextHolder.bottom

            Row {
                id: drinkRow
                anchors.centerIn: parent

                Repeater {
                    id: drinks
                    model: 4

                    Item {
                        id: drinkHolder

                    }

                    Image {
                        height: firstRowHolder.height * 0.9
                        anchors.verticalCenter: parent.verticalCenter
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/images/beer.PNG"
                    }
                }
            }

//            Text {
//                anchors.centerIn: parent
//                text: "Number of drinks consumed: " + main.drinkList.count
//                font.pixelSize: 20
//                color: colors.primaryText
//            }
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
           pushObject: "qrc:/qml/components/CocktailDialogue.qml"
       }
   }
}

