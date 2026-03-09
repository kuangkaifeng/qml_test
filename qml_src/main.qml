import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Shapes 1.8


ApplicationWindow {
    id:mainWindow
    width: 1400
    height: 800
    visible: true

    //关联信号和函数接口
    Connections{
        target: BasicConfig
        function onHandleToolclicked(context)
        {
            console.log("选择工具栏:"+context)
            if(context==="直线工具")
            {

                BasicConfig.currentTool="linePen"   //直线工具

            }
            else
            {
                BasicConfig.currentTool=""   //直线工具
            }
        }
        function onHandleMenuItemClicked(context)
        {
            console.log("选择工具栏:"+context)
            if(context==="直线工具")
            {

                BasicConfig.currentTool="linePen"   //直线工具

            }
            else
            {
                BasicConfig.currentTool=""   //直线工具
            }
        }
    }

    //菜单栏
    menuBar: MenuBar {
        id:menuchickBar
        // 设置菜单栏背景为深色，以便白色文字更明显
        background: Rectangle {
            color: BasicConfig.backgropundColor

        }

        // 自定义菜单栏按钮的外观
        delegate: MenuBarItem {
            id: menuBarItem

            // 自定义内容项：将文字改为白色
            contentItem: Text {
                text: menuBarItem.text
                font: menuBarItem.font
                color: "white" // 关键：将颜色设置为白色
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                leftPadding: 12
                rightPadding: 12
                elide: Text.ElideRight
            }

            // 可选：自定义背景，例如悬停时改变颜色
            background: Rectangle {
                implicitHeight: 30
                color: menuBarItem.highlighted ? BasicConfig.btnHoverColor : "transparent"
                // MouseArea{
                //     anchors.fill: parent
                //     hoverEnabled: true
                //     cursorShape: Qt.PointingHandCursor
                // }
            }
        }

        //文件
        Menu{
            id:fileMenu
            title: "文件"
            // 使用Repeater来创建MenuItem

            Repeater {
                model: BasicConfig.fileModel // 假设fileModel是一个数组或列表

                delegate: MenuItem {
                    text: modelData // 假设每个菜单项是一个字符串
                    // 点击菜单项时触发的事件
                    onTriggered: {
                        // 可以根据文本或索引来做相应的操作
                        BasicConfig.handleMenuItemClicked(modelData)
                    }
                }
            }
        }

        //编辑
        Menu{
            id: editMenu
            title: "编辑"

            Repeater
            {
                model: BasicConfig.editModel
                delegate: MenuItem
                {
                    text:modelData
                    onTriggered:
                    {
                        BasicConfig.handleMenuItemClicked(modelData)
                    }
                }
            }

        }
        //工具
        Menu{
            title: "工具"
            Repeater
            {
                model:BasicConfig.toolModel
                delegate: MenuItem
                {
                    text:modelData
                    onTriggered:
                    {
                        BasicConfig.handleMenuItemClicked(modelData)
                    }
                }
            }
        }
        //窗口
        Menu{
            title: "窗口"
            Repeater{
                model:BasicConfig.windowModel
                delegate: MenuItem
                {
                    text:modelData
                    onTriggered:
                    {
                        BasicConfig.handleMenuItemClicked(modelData)
                    }
                }
            }
        }
        //语言
        Menu{
            id:languageMenu
            title:"语言"
            Repeater{
                model:BasicConfig.languageModel
                delegate: MenuItem
                {
                    text:modelData
                    onTriggered:
                    {
                        BasicConfig.handleMenuItemClicked(modelData)
                    }
                }
            }
        }
        //帮助
        Menu{
            title:"帮助"
            Repeater
            {
                model: BasicConfig.helpModel
                delegate: MenuItem
                {
                    text:modelData
                    onTriggered:
                    {
                        BasicConfig.handleMenuItemClicked(modelData)
                    }
                }
            }
        }

    }






    //常用工具选择栏
    ToolSelectBar{
        id:selectRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top:parent.top
        height: 60
        border.width: 0
        //上分割线
        Rectangle{
            id:topSplit
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 1
            color: "gray"

        }
        //下分割线
        Rectangle{
            id:bottomSplit
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 1
            color: "gray"

        }
        color:BasicConfig.backgropundColor
        Rectangle{
            id:selectRectLeft
            anchors.left: parent.left
            anchors.top: topSplit.bottom
            anchors.bottom: bottomSplit.top
            width: 1100
            color:"transparent"
            Row{
                anchors.fill: parent
                spacing: 10
                //新建文件
                Item {

                    id: newfile
                    width:parent.height
                    height: parent.height
                    Image {
                        id: newFileImage
                        anchors.centerIn:parent
                        source: "qrc:/image/new.png"

                    }
                }
                //文件夹
                Item{
                    id:dir
                    width:parent.height
                    height: parent.height
                    Image{
                        id:dirImage
                        anchors.centerIn:parent
                        source:"qrc:/image/dir.png"
                    }
                }
                //保存文件
                Item{
                    id:save
                    width:parent.height
                    height: parent.height
                    Image{
                        id:saveImage
                        anchors.centerIn:parent
                        source:"qrc:/image/save.png"
                    }
                }
                //导入
                Item{
                    id:exportfile
                    width:parent.height
                    height: parent.height
                    Image{
                        id:exportfileImage
                        anchors.centerIn:parent
                        source:"qrc:/image/exportIn.png"
                    }
                }
                //间隙
                Rectangle{
                    width: 2
                    //color:BasicConfig.btnHoverColor
                    height: parent.height-15
                    anchors.verticalCenter: parent.verticalCenter
                    gradient: LinearGradient {
                        // 设置渐变的起始点和结束点
                        x1:0.0
                        y1:1.0
                        x2:1.0
                        y2:1.0

                        // 渐变的颜色和位置
                        GradientStop {
                            position: 0.0
                            color: BasicConfig.btnHoverColor  // 起始颜色
                        }
                        GradientStop {
                            position: 1.0
                            color: BasicConfig.backgropundColor // 结束颜色
                        }
                    }
                }

                //返回操作
                Item{
                    id:backopt
                    width:parent.height
                    height: parent.height
                    Image{
                        id:backoptImage
                        anchors.centerIn:parent
                        source:"qrc:/image/back.png"
                    }
                }
                //重做
                Item{
                    id:repeateropt
                    width:parent.height
                    height: parent.height
                    Image{
                        id:repeateroptImage
                        anchors.centerIn:parent
                        source:"qrc:/image/repeater.png"
                    }
                }
                //间隙
                Rectangle{
                    width: 2
                    //color:BasicConfig.btnHoverColor
                    height: parent.height-15
                    anchors.verticalCenter: parent.verticalCenter

                    gradient: LinearGradient {
                        // 设置渐变的起始点和结束点
                        x1:0.0
                        y1:1.0
                        x2:1.0
                        y2:1.0

                        // 渐变的颜色和位置
                        GradientStop {
                            position: 0.0
                            color: BasicConfig.btnHoverColor  // 起始颜色
                        }
                        GradientStop {
                            position: 1.0
                            color: BasicConfig.backgropundColor // 结束颜色
                        }
                    }
                }
                //保存GCODE
                Rectangle{
                    id:saveGCode
                    anchors.verticalCenter: parent.verticalCenter
                    width: 90
                    height: parent.height-20
                    radius: 10
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("保存 GCode")
                    }
                }
                //运行GCode
                Rectangle{
                    id:runGCode
                    anchors.verticalCenter: parent.verticalCenter
                    width: 90
                    height: parent.height-20
                    radius: 10
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("运行 GCode")
                    }
                }
                //间隙
                Rectangle{
                    width: 2
                    //color:BasicConfig.btnHoverColor
                    height: parent.height-15
                    anchors.verticalCenter: parent.verticalCenter
                    gradient: LinearGradient {
                        // 设置渐变的起始点和结束点
                        x1:0.0
                        y1:1.0
                        x2:1.0
                        y2:1.0

                        // 渐变的颜色和位置
                        GradientStop {
                            position: 0.0
                            color: BasicConfig.btnHoverColor  // 起始颜色
                        }
                        GradientStop {
                            position: 1.0
                            color: BasicConfig.backgropundColor // 结束颜色
                        }
                    }
                }
                //旋转组件
                Rectangle{
                    id:rotationRect
                    anchors.verticalCenter: parent.verticalCenter
                    width: 90
                    height: parent.height-20
                    radius: 10
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("旋转组件")
                    }
                }
                //间隙
                Rectangle{
                    width: 2
                    //color:BasicConfig.btnHoverColor
                    height: parent.height-15
                    anchors.verticalCenter: parent.verticalCenter
                    gradient: LinearGradient {
                        // 设置渐变的起始点和结束点
                        x1:0.0
                        y1:1.0
                        x2:1.0
                        y2:1.0

                        // 渐变的颜色和位置
                        GradientStop {
                            position: 0.0
                            color: BasicConfig.btnHoverColor  // 起始颜色
                        }
                        GradientStop {
                            position: 1.0
                            color: BasicConfig.backgropundColor // 结束颜色
                        }
                    }
                }
                //M7
                Rectangle{
                    id:m7Rect
                    anchors.verticalCenter: parent.verticalCenter
                    width: 50
                    height: parent.height-20
                    radius: 10
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("M7")
                    }
                }
                //M8
                Rectangle{
                    id:m8Rect
                    anchors.verticalCenter: parent.verticalCenter
                    width: 50
                    height: parent.height-20
                    radius: 10
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("M8")
                    }
                }
                //间隙
                Rectangle{
                    width: 2
                    //color:BasicConfig.btnHoverColor
                    height: parent.height-15
                    anchors.verticalCenter: parent.verticalCenter
                    gradient: LinearGradient {
                        // 设置渐变的起始点和结束点
                        x1:0.0
                        y1:1.0
                        x2:1.0
                        y2:1.0

                        // 渐变的颜色和位置
                        GradientStop {
                            position: 0.0
                            color: BasicConfig.btnHoverColor  // 起始颜色
                        }
                        GradientStop {
                            position: 1.0
                            color: BasicConfig.backgropundColor // 结束颜色
                        }
                    }
                }
                //材料库
                Item{
                    id:materialLibrary
                    width:parent.height
                    height: parent.height
                    Image{
                        id:materialLibraryImage
                        anchors.centerIn:parent
                        source:"qrc:/image/materialLibrary.png"
                    }
                }
                //相机
                Item{
                    id:camera
                    width:parent.height
                    height: parent.height
                    Image{
                        id:cameraImage
                        anchors.centerIn:parent
                        source:"qrc:/image/picture.png"
                    }
                }
                //AI
                Item{
                    id:ai
                    width:parent.height
                    height: parent.height
                    Image{
                        id:aiImage
                        anchors.centerIn:parent
                        source:"qrc:/image/ai.png"
                    }
                }
            }
        }

        //社区论坛
        Rectangle{
            id:communityForum
            anchors.left: selectRectLeft.right
            anchors.top: topSplit.bottom
            anchors.bottom: bottomSplit.top
            anchors.right: parent.right
            anchors.rightMargin: 20
            color:"red"
            Row{

                spacing: 10
                Rectangle{
                    anchors.fill: parent
                    Text{

                        width: 40
                        height: 40

                        text: "案例讨论社区"
                        color: "white"

                    }
                }
                Rectangle{
                    anchors.fill: parent
                    Text{

                        width: parent.height
                        height: parent.height

                        text: "www.thmglaser.com"
                        color: "white"
                    }
                }


            }


        }


    }
    //右侧属性栏
    Rectangle{
        id:rightRect
        anchors.right: parent.right
        anchors.top: selectRect.bottom
        width: 200
        height: 200
        color:"gray"
        MouseArea{
            onClicked: {
                BasicConfig.menuData
            }
        }

    }

    //左侧工具栏
    Rectangle
    {
        id:leftToolBarRect
        anchors.left:parent.left
        anchors.top:selectRect.bottom
        anchors.bottom: parent.bottom
        width: 60
        color:BasicConfig.backgropundColor
        LeftToolBar
        {
            id:leftToolBar
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:parent.top
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            width: 40
            color:BasicConfig.backgropundColor

        }
    }
    //中间绘图和尺寸区域
    GridCanvas{
        id:midRect
        anchors.left: leftToolBarRect.right
        anchors.right: rightRect.left
        anchors.top: selectRect.bottom
        anchors.bottom: mainWindow.bottom
        height: parent.height-selectRect.height
        width: parent.width-leftToolBar.width-rightRect.width
        color:"white"
    }











}
