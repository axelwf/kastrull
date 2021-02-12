import QtQuick 2.0

Rectangle {
    id: root
    property string text: "EMPTY"
    property string picSource: ""
    property string pushObject: ""
    property int margin: 10
    property int fontSize: 36

    height: (buttonGrid.height - 3 * buttonGrid.spacing) / 2
    width: (buttonGrid.width - 3 * buttonGrid.spacing) / 2
    color: "transparent"
    border.color: colors.primaryColor
    border.width: 2
    radius: height * 0.2
    Text {
        anchors.centerIn: parent
        text: root.text
        color: colors.primaryText
        font.pixelSize: fontSize
    }
    MouseArea {
        anchors.fill: parent
        onClicked: stack.push(pushObject)
    }
}
