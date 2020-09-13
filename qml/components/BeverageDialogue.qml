import QtQuick 2.0
import QtQuick.Controls 2.15

Grid {
    id: root

    rows: 5
    columns: 1

    property string picSource: ""
    property real defaultSize: 10
    property int maxSize: 50
    property real sizeStepSize: 4
    property real selectedSize: defaultSize
    property real defaultAlcPerc: 10
    property real maxAlcPerc: 50
    property real minAlcPerc: 2
    property real alcPercStepSize: 0.1
    property real selectedAlcPerc: defaultAlcPerc
    property int defaultTimeOffset: 0 //resultion: 1 unit = 15 minutes
    property int maxTimeOffset: 48
    property int selectedTimeOffset: defaultTimeOffset




    Item {
        id: imageHolder
        width: parent.width
        height: parent.height * 0.3
        Image {
            width: parent.width*0.4
            height: parent.height
            anchors.centerIn: parent
            source: picSource
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
                width: root.width * 0.6
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
                font.pixelSize: 30
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
                width: root.width * 0.6
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
                font.pixelSize: 30
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
                width: root.width * 0.6
                handle.implicitHeight: 20
                handle.implicitWidth: 20
                value: selectedTimeOffset
                from: -maxTimeOffset
                to: 0
                onValueChanged: selectedTimeOffset = value
            }

            Text {
                width: root.width * 0.2
                text: selectedTimeOffset === 0? qsTr("Now"): qsTr(selectedTimeOffset * 15 + " min")
                font.pixelSize: 30
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
                main.addBeverage(selectedSize, selectedAlcPerc, selectedTimeOffset)
                stack.pop()
            }
        }
    }
}
