import QtQuick 2.13
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
            font.pixelSize: 120
            color: colors.primaryText
        }
    }

    Item {
        id: consumedDrinksHolder
        width: parent.width
        height: parent.height / 4
        anchors.top: alcLevelContainer.bottom

        Row {
            id: drinkRow
            anchors.centerIn: parent

            Repeater {
                id: drinks
                model: 4

                Item {
                    id: drinkHolder
                    height: consumedDrinksHolder.height
                    width: consumedDrinksHolder.width / 4

                    Item {
                        id: pictureHolder
                        height: parent.height * 0.75
                        width: parent.width

                        Image {
                            height: parent.height * 0.9
                            anchors.centerIn: parent
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/images/beer.PNG"
                        }
                    }

                    Item {
                        id: timeStampHolder
                        height: parent.height * 0.25
                        width: parent.width
                        anchors.top: pictureHolder.bottom

                        Text {
                            id: timeStampText
                            anchors.centerIn: parent
                            text: "6:42p"
                            font.pixelSize: 20
                            color: colors.primaryText
                        }
                    }
                }
            }
        }
    }

    Item {
        id: addButtonHolder
        width: parent.width
        height: parent.height / 4
        anchors.top: consumedDrinksHolder.bottom

        MainButton {
            width: parent.width * 0.75
            height: parent.height * 0.5
            anchors.centerIn: parent
            text: "+"
            pushObject: "qrc:/qml/components/BeverageDialogue.qml"
        }
    }

//    Grid {
//       id: buttonGrid
//       rows: 2
//       columns: 2

//       width: parent.width
//       height: parent.height * 0.5
//       anchors {
//           top: alcLevelContainer.bottom
//       }
//       leftPadding: spacing
//       topPadding: spacing
//       spacing: 10

//       MainButton {
//           text: "BEER"
//           pushObject: "qrc:/qml/components/BeerDialogue.qml"
//       }

//       MainButton {
//           text: "WINE"
//           pushObject: "qrc:/qml/components/WineDialogue.qml"
//       }

//       MainButton {
//           text: "SHOT"
//           pushObject: "qrc:/qml/components/ShotDialogue.qml"
//       }

//       MainButton {
//           text: "Cocktail"
//           pushObject: "qrc:/qml/components/CocktailDialogue.qml"
//       }
//    }
}

