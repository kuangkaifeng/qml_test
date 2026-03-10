// TableCell.qml
import QtQuick

Rectangle {
    property alias text: cellText.text
    property color textColor: "#333333"
    property bool fontBold: false
    property int fontSize: 12

    color: "transparent"
    border.color: "transparent"

    Text {
        id: cellText
        anchors.centerIn: parent
        color: parent.textColor
        font.bold: parent.fontBold
        font.pixelSize: parent.fontSize
        elide: Text.ElideRight
        maximumLineCount: 1
    }

    // 右侧边框
    Rectangle {
        width: 1
        height: parent.height
        color: "#e0e0e0"
        anchors.right: parent.right
    }
}
