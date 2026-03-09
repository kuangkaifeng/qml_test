import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Shapes 1.8
import QtQuick.Controls.Basic
import Qt.labs.qmlmodels
Rectangle{
    //设备选择区域
    Rectangle{
        id:deviceRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top:parent.top
        height: 200
        color:"#FFDADCDD"
        Rectangle{
            id:topRect
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top
            height: 50
            color:"#FF525353"
            Text {
                id: deviceText
                anchors.centerIn: parent
                text: qsTr("+ 选择设备")
                color:BasicConfig.textColor
                font.pixelSize: BasicConfig.textFontSize
                font.bold: true
            }
            MouseArea{
                id:deviceArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    deviceTip.visible=true
                }
                onExited: {
                    deviceTip.visible=false
                }
            }
            ToolTip {
                id: deviceTip
                text: "请选择设备"
                x:deviceArea.mouseX+10
                y:deviceArea.mouseY+10
                delay: BasicConfig.tipDelay  // 可调节显示延时，0为立即显示
            }
        }

        Rectangle{
            id:bottomRect
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: topRect.bottom
            anchors.bottom: parent.bottom
            Image {
                id:devicePicture
                width: parent.width-80
                height: parent.height-80
                anchors.centerIn: parent
                source: "qrc:/image/device.png"
            }
            Rectangle{
                anchors.top: devicePicture.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                Row{
                    anchors.centerIn: parent
                    spacing: 10
                    Rectangle{
                        id:testButton
                        width: 80
                        height: 30
                        anchors.verticalCenter: parent.verticalCenter
                        color:"#FFC7CACB"
                        Text {
                            id:testText
                            anchors.centerIn: parent
                            text: qsTr("机器测试")
                            font.pixelSize: BasicConfig.textFontSize-6
                            color:"black"
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                BasicConfig.handleAction("TestButtonClicked","机器测试")
                            }
                            onEntered: {
                                testText.color="white"
                                parent.color="#FF0078D7"
                                testText.font.pixelSize=BasicConfig.textFontSize-4
                            }
                            onExited: {
                                testText.color="black"
                                parent.color="#FFC7CACB"
                                testText.font.pixelSize=BasicConfig.textFontSize-6
                            }

                        }


                    }
                    Rectangle{
                        id:videoTutorial
                        width: 80
                        height: 30
                        anchors.verticalCenter: parent.verticalCenter
                        color:"#FFC7CACB"
                        Text {
                            id:videoText
                            anchors.centerIn: parent
                            text: qsTr("视频教程")
                            font.pixelSize: BasicConfig.textFontSize-6
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                BasicConfig.handleAction("videoButtonClicked","视频教程")
                            }
                            onEntered: {
                                videoText.color="white"
                                parent.color="#FF0078D7"
                                videoText.font.pixelSize=BasicConfig.textFontSize-4
                            }
                            onExited: {
                                videoText.color="black"
                                parent.color="#FFC7CACB"
                                videoText.font.pixelSize=BasicConfig.textFontSize-6
                            }

                        }

                    }
                }

            }
        }

    }
    //切割/图层/设置
    Rectangle{
        id:cutLayerSettings
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: deviceRect.bottom
        height: 250
        color:"#FFDADCDD"
        Rectangle{
            id:titleTableRect
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: titleText.implicitHeight+5

            color:"#FFB3B5B6"
            Text{
                id:titleText
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 2
                color:"black"
                text:"切割/图层/设置"
                font.pixelSize:12
            }
        }

        //表格
        Rectangle{
            id:tableRect
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: titleTableRect.bottom
            anchors.bottom: parent.bottom
            TableView {
                id: layerTable
                anchors.fill: parent
                clip: true

                model: dataHandlerManger

                ScrollBar.vertical: ScrollBar {}
                ScrollBar.horizontal: ScrollBar {}

                delegate: Rectangle {
                    implicitHeight: 30
                    implicitWidth: parent.width/6
                    border.width: 1
                    border.color: "gray"

                    Text {
                        anchors.centerIn: parent

                        text: {
                            switch(column) {
                            case 0: return model.id
                            case 1: return model.layer
                            case 2: return model.mode
                            case 3: return model.speed
                            case 4: return model.output
                            case 5: return model.visible
                            }
                        }
                    }
                }
            }

        }

    }







}
