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

    //variables
    property real alcLevel: 0.25
    property string sizeUnit: "oz"
    property ListModel drinkList

    //functions
    function addBeverage(size, perc, timeOffset) {
        //calculate absolute time
        drinkList.append()
    }

    header: ToolBar {
            RowLayout {
                anchors.fill: parent
                ToolButton {
                    text: qsTr("‹")
                    onClicked: stack.pop()
                    font.pixelSize: 36
                }
                Label {
                    text: "Kastrull"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                    font.pixelSize: 24
                }
                ToolButton {
                    text: qsTr("⋮")
                    onClicked: menu.open()
                    font.pixelSize: 36
                }
            }
        }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: MainPageVertical{}
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

    Component.onCompleted: {
        splashTimer.start()
    }

}
