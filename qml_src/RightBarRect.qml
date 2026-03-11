import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Shapes 1.8
import QtQuick.Controls.Fusion
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
        //表头
        Rectangle{
            id:headerTableRect
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: titleTableRect.bottom
            height: 30
            color:"#FFF7F9F9"
            Row{
                id:headerRow
                anchors.top:parent.top
                height: 30
                width: parent.width
                Repeater{
                    model: BasicConfig.headerTitles
                    Rectangle{
                        height: parent.height-2
                        width: modelData.name==="速度/功率"?55:(parent.width-55)/5
                        Text {
                            anchors.centerIn:parent
                            width: parent.width-20
                            height: parent.height-10
                            text: modelData.name
                            font.pixelSize: 12

                        }
                        Rectangle{
                            width: parent.width
                            height: 2
                            anchors.right: parent.right

                            Gradient {
                                GradientStop { position: 0.0; color: "#4a4a4a" }
                                GradientStop { position: 1.0; color: "#dcdcdc" }
                            }

                        }
                    }


                }
            }

        }

        //表格
        Rectangle{
            id:tableRect
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: headerTableRect.bottom
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
                    implicitWidth: column === 3  ? 55 : (parent.width - 55) / 5
                    border.width: 1
                    border.color: "gray"

                    // 用来显示内容的元素
                    Item {
                        id:parentItem
                        width: parent.width
                        height: parent.height

                        // 显示或编辑列内容
                        Text {
                            anchors.centerIn: parent
                            visible: column !== 3 && column !== 2 // 只在非编辑列显示文本
                            text: {
                                switch(column) {
                                    case 0: return model.id || "未知"  // 确保有默认值
                                    case 1: return model.layer || "未知"
                                    case 4: return model.output ? "Yes" : "No"
                                    case 5: return model.visible ? "Yes" : "No"
                                    default:return ""
                                }
                            }
                        }
                        property var datamodel: model
                        // 用于 mode 列的下拉框
                        ComboBox {
                            id: modeCombo

                            anchors.fill: parent
                            anchors.margins: 1

                            visible: column === 2  // 只在 mode 列显示

                            // 下拉列表的模型
                            model: ["自动", "手动"]  // 可根据需要修改
                            font.pixelSize: 12

                            // 当前显示的文本应与 model.mode 保持一致

                            currentIndex: {
                                // 找到 model.mode 在列表中的索引，若找不到则设为 -1（显示空白）
                                var idx = model.indexOf(parentItem.datamodel.mode)  // 注意：modelData 可能未定义，应使用 model.mode
                                console.log("modeltest:"+parentItem.datamodel.mode)
                                return idx >= 0 ? idx : -1
                            }

                            // 当用户选择新项时更新模型
                            onActivated: {
                                // index 是选中的索引，currentText 是选中的文本
                                parentItem.datamodel.mode = currentText
                                console.log("mode:"+parentItem.datamodel.mode)
                            }
                            editable: false
                            // 自定义背景以实现悬浮变色
                            background: Rectangle {
                                anchors.fill: parent
                                color: modeCombo.hovered ? "#e0e0e0" : "white"  // 悬浮时浅灰色，否则白色
                                border.color: "#ccc"
                                border.width: 0
                                radius: 2
                            }

                            // 可选：自定义内容显示（如果默认内容样式不合适，可以自定义）
                            contentItem: Text {
                                anchors.centerIn: parent
                                text: modeCombo.displayText
                                font: modeCombo.font
                                color: "black"
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                            }

                        }

                        // 可编辑的文本框（speed 和 mode）
                        TextField {
                            anchors.fill: parent
                            visible: column === 3   // 只有 speed

                            text: {
                                // 确保 model.mode 和 model.speed 总是有效的，不为 undefined 或 null
                                switch(column) {
                                    case 3: return model.speed || "0 rpm"    // 设置默认值，防止 undefined 或 null
                                    default: return ""
                                }
                            }

                            onTextChanged: {
                                // 调试信息，查看文本是否有效
                                console.log("Text changed: ", text)
                                if (column === 3 && text && text !== model.speed) {
                                    model.setProperty("speed", text)  // 使用 setProperty 来更新值
                                }
                            }
                        }

                        CustCheckbox
                        {
                            id:root
                            anchors.centerIn: parent
                            // 对外暴露的属性
                            property bool checked: {

                                switch(column)
                                {
                                case 4:return model.output
                                case 5:return model.visible
                                default:return false
                                }
                            }

                            property color trackColor: "#ccc"          // 关闭时的轨道颜色
                            property color trackCheckedColor: "#4CAF50" // 开启时的轨道颜色
                            property color thumbColor: "#fff"           // 滑块颜色
                            property int animationDuration: 200         // 动画时长（毫秒）
                            visible: column === 4 || column === 5
                            // 尺寸建议（可自定义）
                            width: parent.width-10
                            height: parent.height/2
                            // 信号，当用户切换时发出
                            signal toggled(bool checked)

                            onToggled:function(checked) {

                                // ... 后续代码
                                if (column === 4)
                                {
                                    //console.log("修改之前的数据:"+model.output+"--checked:"+checked)
                                    model.output = checked
                                    //console.log("修改之后的数据:"+model.output+"--checked:"+checked)

                                } else if (column === 5)
                                {
                                    //console.log("修改之前的数据:"+model.visible+"--checked:"+checked)
                                    model.visible = checked
                                    //console.log("修改之后的数据:"+model.visible+"--checked:"+checked)
                                }
                            }



                        }
                    }
                }

            }

        }
        //分割层
        Rectangle {
            id: splitRect
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: tableRect.bottom
            height: 5

            //color:"#"
            gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FFF7F9F9" }   // 上面深灰
                    GradientStop { position: 1.0; color: "gray" }   // 下面浅白
                }
        }


    }

    //设备操作区域
    Rectangle{
        id:deviceOptRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: cutLayerSettings.bottom
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        color:"#FFDADCDD"
        //颜色层次
        Item{
            id:colorOptItem
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.top: parent.top
            anchors.topMargin: 10
            width: 120
            height: 20
            Row{
                spacing: 5
                Label{
                    id:colorLabel
                    width: 30
                    height: 20
                    text: "层颜色"
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                }
                Rectangle{
                    width: 80
                    height:20
                    color:"black"
                }
            }


        }
        //跳过计数
        Item{
            id:dropNumberItem
            anchors.left: colorOptItem.left
            anchors.top: colorOptItem.bottom
            anchors.topMargin: 10
            anchors.right: colorOptItem.right
            height: 20
            Row{
                spacing: 5
                Label{
                    id:dropNumberLabel
                    text:"跳过计数"
                    width: 30
                    height: 20
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                }
                SpinBox {
                    id:dropNumberSpinbox
                    width: 80
                    height: 20
                    from: 0
                    to: 100
                    value: 2
                    stepSize: 1
                }
            }
        }
        //间隔时间
        Item{
            id:splitTimeItem
            anchors.left: colorOptItem.left
            anchors.top: dropNumberItem.bottom
            anchors.topMargin: 10
            anchors.right: colorOptItem.right
            height: 20
            Row{
                spacing: 5
                Label{
                    id:splitTimeLabel
                    text:"间隔(mm)"
                    width: 30
                    height: 20
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                }
                SpinBox {
                    id:splitTimeSpinbox
                    width: 80
                    height: 20
                    from: 0
                    to: 100
                    value: 2
                    stepSize: 1
                }
            }
        }
        //速度
        Item{
            id:speedItem

            anchors.top: colorOptItem.top
            anchors.left:colorOptItem.right
            anchors.leftMargin: 30

            width: 120
            height: 20
            Row{
                spacing: 5
                Label{
                    id:speedLabel
                    text:"速度(mm/m)"
                    width: 30
                    font.pixelSize: 10
                    height: 20
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                }
                SpinBox {
                    id:speedSpinbox
                    width: 80
                    height: 20
                    from: 0
                    to: 100
                    value: 2
                    stepSize: 1
                }
            }
        }
        //最小功率
        Item{
            id:minRateItem
            anchors.left: speedItem.left
            anchors.right: speedItem.right
            anchors.top: speedItem.bottom
            anchors.topMargin: 10
            width: 120
            height: 20
            Row{
                spacing: 5
                Label{
                    id:minRatLabel
                    text:"最小功率(%)"
                    width: 30
                    font.pixelSize: 10
                    height: 20
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                }
                SpinBox {
                    id:minRatSpinbox
                    width: 80
                    height: 20
                    from: 0
                    to: 100
                    value: 2
                    stepSize: 1
                }
            }
        }
        //最大功率
        Item{
            id:maxRateItem
            anchors.left: speedItem.left
            anchors.right: speedItem.right
            anchors.top: minRateItem.bottom
            anchors.topMargin: 10
            width: 120
            height: 20
            Row{
                spacing: 5
                Label{
                    id:mixRateLabel
                    text:"最大功率(%)"
                    width: 30
                    font.pixelSize: 10
                    height: 20
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                }
                SpinBox {
                    id:mixRateSpinbox
                    width: 80
                    height: 20
                    from: 0
                    to: 100
                    value: 2.00
                    stepSize: 1.00
                }
            }
        }
        //向上
        Rectangle{
            id:upRect
            anchors.left: parent.left
            anchors.leftMargin: 70
            anchors.top:maxRateItem.bottom
            anchors.topMargin: 10
            width: BasicConfig.deviceOptWidth
            height: BasicConfig.deviceOptHeight
            color:"#FFC7CACB"
            radius: 10
            Image {
                anchors.centerIn:parent
                source: "qrc:/image/toUp.png"
            }
        }
        //回到原点
        Rectangle{
            id:centerInRect
            anchors.top: upRect.bottom
            anchors.topMargin: 5
            anchors.left: upRect.left
            width: BasicConfig.deviceOptWidth
            height: BasicConfig.deviceOptHeight
            color:"#FFC7CACB"
            radius: 10
            Image {
                anchors.centerIn:parent
                source: "qrc:/image/home.png"
            }
        }
        //向左
        Rectangle{
            id:leftRect
            anchors.top:centerInRect.top
            anchors.right: centerInRect.left
            anchors.rightMargin: 5
            width: BasicConfig.deviceOptWidth
            height: BasicConfig.deviceOptHeight
            color:"#FFC7CACB"
            radius: 10
            Image {
                anchors.centerIn:parent
                source: "qrc:/image/toLeft.png"
            }
        }
        //向右
        Rectangle{
            id:rightRect
            anchors.top:centerInRect.top
            anchors.left: centerInRect.right
            anchors.leftMargin: 5
            width: BasicConfig.deviceOptWidth
            height: BasicConfig.deviceOptHeight
            color:"#FFC7CACB"
            radius: 10
            Image {
                anchors.centerIn:parent
                source: "qrc:/image/toRight.png"
            }

        }
        //向下
        Rectangle{
            id:downRect
            anchors.top:centerInRect.bottom
            anchors.topMargin: 5
            anchors.left: centerInRect.left
            width: BasicConfig.deviceOptWidth
            height: BasicConfig.deviceOptHeight
            color:"#FFC7CACB"
            radius: 10
            Image {
                anchors.centerIn:parent
                source: "qrc:/image/toDown.png"
            }
        }
        //自动对焦
        Rectangle{
            id:autoFoucusRect
            anchors.left: rightRect.right
            anchors.leftMargin: 20
            anchors.top: upRect.top
            width:BasicConfig.autoOptFouncsWidth
            height:BasicConfig.autoOptFouncsHeight
            color: "#FFC7CACB"
            radius: 10
            Image {
                id:foucuImage
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                width: 40
                height: 40
                source: "qrc:/image/autofocus.png"


            }
            Item {
                anchors.top:foucuImage.bottom
                anchors.topMargin: 35
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    anchors.fill: parent
                    text: "自\n动\n对\n焦"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
            }

        }
        //暂停、停止、开始操作
        Item
        {
            id:pauseStopStart
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: downRect.bottom
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.topMargin: 15
            width: parent.width-30
            height: 40

            Row{
                width: parent.width
                height: parent.height
                spacing: 5
                Repeater{
                    model:BasicConfig.optBtnIconModel
                    Rectangle{
                        id:pauseRect
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        color:BasicConfig.optBtnbackground
                        width: parent.width/3
                        height: parent.height
                        Image {
                            id:img
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            width: 30
                            height: 30
                            source: modelData.text
                        }
                        Text {
                            anchors.left: img.right
                            anchors.leftMargin: 5
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: true
                            font.pixelSize: 14
                            text: modelData.name
                        }
                        radius: 10
                    }

                }


            }
        }
        //矩形边框，圆形边框，复位，去往原点
        Item
        {
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: pauseStopStart.bottom
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10

            width: parent.width-15
            height: 40

            Row{
                width: parent.width
                height: parent.height
                spacing: 5
                Repeater{
                    model:BasicConfig.optBtnIconModel2
                    Rectangle{

                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        color:BasicConfig.optBtnbackground
                        width: parent.width/4
                        height: parent.height
                        Image {
                            id:pic
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            anchors.verticalCenter: parent.verticalCenter
                            width: modelData.text?18:8
                            height: 18
                            source:modelData.text
                        }
                        Text {
                            anchors.left: pic.right
                            anchors.leftMargin: 5
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: true
                            font.pixelSize: 10
                            text: modelData.name
                        }
                        radius: 10
                    }

                }


            }
        }



    }





}
