import QtQuick 2.13
import QtQuick.Controls 2.13
import "./qml/mainView"

ApplicationWindow {
    id: appWindow
    visible: true
    // 16:9 portrait
    height: 720
    width: 405
    visibility: ApplicationWindow.AutomaticVisibility
    title: qsTr("Kastrull")

    Text {
        id: hej
        text: qsTr("Hej Erik")
        font.pixelSize: 42
        anchors.centerIn: parent
    }

    Splashscreen {
        id: splash
        width: appWindow.width
        height: appWindow.height
    }

    Timer {
        id: splashTimer
        onTriggered: splash.opacity = 0
        interval: 2000
    }

    Component.onCompleted: splashTimer.start()

//    ScrollView {
//        anchors.fill: parent

//        ListView {
//            width: parent.width
//            model: 20
//            delegate: ItemDelegate {
//                text: "Item " + (index + 1)
//                width: parent.width
//            }
//        }
//    }
}
