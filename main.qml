import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import "./qml/mainView"

ApplicationWindow {
    id: appWindow
    visible: true
    // 16:9 portrait
    height: 720
    width: 405
    visibility: ApplicationWindow.AutomaticVisibility
    title: qsTr("Kastrull")


    header: ToolBar {
            RowLayout {
                anchors.fill: parent
                ToolButton {
                    text: qsTr("‹")
                    onClicked: stack.pop()
                }
                Label {
                    text: "Title"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
                ToolButton {
                    text: qsTr("⋮")
                    onClicked: menu.open()
                }
            }
        }

    StackView {
        id: stack
        anchors.fill: parent
    }

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
