import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import "./qml/mainView"
import "./qml/data"

ApplicationWindow {
    id: main
    visible: true
    // 16:9 portrait
    height: 720
    width: 405
    visibility: ApplicationWindow.AutomaticVisibility
    title: qsTr("Kastrull")

    property alias drinkList: drinkList

    //variables
    property real alcLevel: 0.25
    property string sizeUnit: "oz"


    //data structures
    ListModel{
        id: drinkList
    }

    //functions
    function addBeverage(size, perc, selectedDrinkStart) {
        //calculate absolute time
        drinkList.append({"size": size, "perc": perc, "time": selectedDrinkStart})
    }

    Colors {
        id: colors
    }

    header: ToolBar {
            RowLayout {
                anchors.fill: parent
                ToolButton {
                    text: qsTr("‹")
                    onClicked: stack.pop()
                    font.pixelSize: 44
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
                    font.pixelSize: 44
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
        width: main.width
        height: main.height
    }

    Timer {
        id: splashTimer
        onTriggered: splash.opacity = 0
        interval: 2000
    }

    onClosing: {
        if(stack.depth > 1) {
            close.accepted = false;
            stack.pop()
        }
        else {
            close.accepted = true;
        }
    }

    Component.onCompleted: {
        splashTimer.start()
    }

}
