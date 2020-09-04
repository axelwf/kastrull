import QtQuick 2.0
import QtQuick.Controls 2.15

Grid {
    id: root

    rows: 5
    columns: 1

    property string picSource: ""
    property int defaultSize: 10
    property int maxSize: 50
    property int selectedSize: defaultSize
    property real defaultAlcPerc: 10
    property real maxAlcPerc: 50
    property real selectedAlcPerc: defaultAlcPerc
    property int defaultTimeOffset: 0 //resultion: 1 unit = 15 minutes
    property int maxTimeOffset: 48
    property int selectedTimeOffset: defaultTimeOffset

    Item {
        id: imageHolder
        width: parent.width
        height: parent.height * 0.3
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
                onValueChanged: selectedSize = value
            }

            Text {
                width: root.width * 0.2
                text: qsTr(selectedSize + " " + appWindow.sizeUnit)
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
                to: maxAlcPerc
                stepSize: 0.1
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
            onClicked: appWindow.addBeverage(selectedSize, selectedAlcPerc, selectedTimeOffset)
        }
    }
}
