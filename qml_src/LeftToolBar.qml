import QtQuick 2.15
import QtQuick.Layouts 2.15

Rectangle{

    Column{
        anchors.fill: parent
        spacing: 30
        Repeater{
            model: BasicConfig.leftContextModel

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter

                width: 40
                height: 40
                color: "transparent"
                radius: 4
                Image{
                    anchors.centerIn: parent
                    source: modelData.text
                    width: parent.width  // 宽度自适应容器
                    height: parent.height  // 高度自适应容器
                    fillMode: Image.Stretch  // 保持图片比例适应容器
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onEntered: {
                        parent.color=BasicConfig.btnHoverColor
                    }
                    onExited: {
                        parent.color="transparent"

                    }

                    onClicked: {
                        BasicConfig.handleToolclicked(modelData.name)
                    }
                }
            }
        }
    }
}
