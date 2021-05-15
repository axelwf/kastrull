import QtQuick 2.0
import QtQuick.Controls 2.13


Grid {
    id: root

    rows: 5
    columns: 1

    property real defaultSize: variable.selectedDrinkSize
    property int maxSize: 50
    property real sizeStepSize: 4
    property real selectedSize: defaultSize
    property real defaultAlcPerc: variable.selectedDrinkPercentage
    property real maxAlcPerc: 50
    property real minAlcPerc: 2
    property real alcPercStepSize: 0.1
    property real selectedAlcPerc: defaultAlcPerc
    property int defaultTimeOffset: 0 //resultion: 1 unit = 15 minutes
    property int maxTimeOffset: 16
    property int selectedTimeOffset: defaultTimeOffset
    property date selectedDrinkStart: new Date()
    property int drinkTypeIndex: variable.selectedDrinkType

    function increaseDrinkTypeIndex() {
        if (drinkTypeIndex === 3) drinkTypeIndex = 0
        else drinkTypeIndex++
        switch (drinkTypeIndex) {
        case 0: //beer
            selectedSize = 12
            selectedAlcPerc = 5
            break
        case 1: //wine
            selectedSize = 6
            selectedAlcPerc = 12
            break
        case 2: //shot
            selectedSize = 4
            selectedAlcPerc = 40
            break
        case 3: //cocktail
            selectedSize = 12
            selectedAlcPerc = 10
            break
        }
    }

    function decreaseDrinkTypeIndex() {
        if (drinkTypeIndex === 0) drinkTypeIndex = 3
        else drinkTypeIndex--
        switch (drinkTypeIndex) {
        case 0: //beer
            selectedSize = 12
            selectedAlcPerc = 5
            break
        case 1: //wine
            selectedSize = 6
            selectedAlcPerc = 12
            break
        case 2: //shot
            selectedSize = 4
            selectedAlcPerc = 40
            break
        case 3: //cocktail
            selectedSize = 12
            selectedAlcPerc = 10
            break
        }
    }

    Item {
        id: imageHolder
        width: parent.width
        height: parent.height * 0.3

        Rectangle {
            id: leftArrowItem
            color: "blue"
            height: parent.height / 3
            width: height
            anchors {
                left: parent.left
                leftMargin: width / 2
                verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: decreaseDrinkTypeIndex()
            }
        }

        Image {
            id: drinkTypeImage
            //width: parent.width*0.4
            height: parent.height * 0.8
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            source: switch (drinkTypeIndex) {
                    case 0: "qrc:/images/beer.PNG"
                        break
                    case 1: "qrc:/images/wine.PNG"
                        break
                    case 2: "qrc:/images/shot.PNG"
                        break
                    default: ""
                    }
        }

        Rectangle {
            id: rightArrowItem
            color: "blue"
            height: parent.height / 3
            width: height
            anchors {
                right: parent.right
                rightMargin: width / 2
                verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: increaseDrinkTypeIndex()
            }
        }
    }

    Item {
        id: sizeSliderHolder
        width: parent.width
        height: parent.height * 0.15

        Row {
            anchors.centerIn: parent
            spacing: 30
            Slider {
                width: root.width * 0.5
                handle.implicitHeight: 20
                handle.implicitWidth: 20
                value: selectedSize
                to: maxSize
                stepSize: sizeStepSize
                onValueChanged: selectedSize = value
            }

            Text {
                width: root.width * 0.2
                text: qsTr(Math.round(selectedSize*100)/100 + " " + main.sizeUnit)
                font.pixelSize: 25
                color: "white"
            }
        }


    }

    Item {
        id: alcPercentageSliderHolder
        width: parent.width
        height: parent.height * 0.15

        Row {
            anchors.centerIn: parent
            spacing: 30
            Slider {
                width: root.width * 0.5
                handle.implicitHeight: 20
                handle.implicitWidth: 20
                value: selectedAlcPerc
                from: minAlcPerc
                to: maxAlcPerc
                stepSize: alcPercStepSize
                onValueChanged: selectedAlcPerc = Math.round(value*10)/10
            }

            Text {
                width: root.width * 0.2
                text: qsTr(selectedAlcPerc + " %")
                font.pixelSize: 25
                color: "white"
            }
        }
    }

    Item {
        id: timeSliderHolder
        width: parent.width
        height: parent.height * 0.15

        Row {
            anchors.centerIn: parent
            spacing: 30
            Slider {
                width: root.width * 0.5
                handle.implicitHeight: 20
                handle.implicitWidth: 20
                value: selectedTimeOffset
                from: -maxTimeOffset
                to: 0
                onValueChanged: {
                    selectedTimeOffset = value
                }
            }

            Text {
                width: root.width * 0.2
                text: selectedTimeOffset === 0? qsTr("Now"): qsTr("-" + -Math.ceil(selectedTimeOffset/4)+" h " + -(selectedTimeOffset*15 - Math.ceil(selectedTimeOffset/4)*60) + " m")
                font.pixelSize: 25
                color: "white"
            }
        }
    }

    Item {
        id: confirmButtonHolder
        width: parent.width
        height: parent.height * 0.25

        Button {
            anchors.centerIn: parent
            width: parent.width * 0.4
            height: parent.width * 0.2
            text: qsTr("DRINK!")
            font.pixelSize: 30
            onClicked: {
                variable.selectedDrinkType = drinkTypeIndex
                variable.selectedDrinkSize = selectedSize
                variable.selectedDrinkPercentage = selectedAlcPerc
                var today = new Date()
                selectedDrinkStart = new Date(today.getFullYear(), today.getMonth(), today.getDate(), today.getHours()+Math.ceil(selectedTimeOffset/4), today.getMinutes()+(selectedTimeOffset*15 - Math.ceil(selectedTimeOffset/4)*60), today.getSeconds())
                console.log(selectedDrinkStart)
                main.addBeverage(selectedSize, selectedAlcPerc, selectedDrinkStart, drinkTypeIndex, "US")
                stack.pop()
            }
        }
    }
}
