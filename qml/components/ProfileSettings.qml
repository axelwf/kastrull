import QtQuick 2.0
import QtQuick.Controls 2.13

Grid {
    id: root

    rows: 5
    columns: 1

    Item {
        id: imageHolder
        width: parent.width
        height: parent.height * 0.3

        Image {
            id: settingsIcon

            height: parent.height * 0.8
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            source: "qrc:/images/settings.png"
        }
    }

    Item {
        id: genderSelectionHolder

        width: parent.width
        height: parent.height * 0.15


    }
}
