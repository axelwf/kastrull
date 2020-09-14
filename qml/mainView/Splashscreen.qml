import QtQuick 2.0

Rectangle {
    color: colors.primaryColor
    Behavior on opacity {PropertyAnimation {duration: 1000}}

    Text {
        anchors.centerIn: parent
        width: parent.width * 0.7
        id: appTitle
        text: qsTr("KASTRULL")
        color: colors.primaryText
        font.family: "Chiller"
        font.pixelSize: 60
        fontSizeMode: Text.HorizontalFit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
