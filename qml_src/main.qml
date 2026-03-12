import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Shapes 1.8
import com.yourcompany.dxfparser 1.0   // 注册的 C++ 模块

ApplicationWindow {
    id:mainWindow
    width: 1450
    height: 900
    visible: true

    //关联信号和函数接口
    Connections{
        target: BasicConfig


        function onHandleAction(actionType,context)
        {
            console.log("事件类型："+actionType+"事件内容："+context)
            if(actionType==="TestButtonClicked")
            {


            }
            else if(actionType==="MenuItemClicked")
            {

                if(context==="直线工具")
                {
                    BasicConfig.currentTool="linePen"
                }
                else
                {
                    BasicConfig.currentTool="linePen"
                }
            }
            else if(actionType==="Toolclicked")
            {

                if(context==="直线工具")
                {
                    BasicConfig.currentTool="linePen"
                }
                else
                {
                    BasicConfig.currentTool="linePen"
                }
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
                        BasicConfig.handleAction("MenuItemClicked",modelData)
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
                        BasicConfig.handleAction("MenuItemClicked",modelData)
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
                        BasicConfig.handleAction("MenuItemClicked",modelData)
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
                        BasicConfig.handleAction("MenuItemClicked",modelData)
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
                        BasicConfig.handleAction("MenuItemClicked",modelData)
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
                        BasicConfig.handleAction("MenuItemClicked",modelData)
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
    }
    //右侧属性栏
    RightBarRect{
        id:rightRect
        anchors.right: parent.right
        anchors.top: selectRect.bottom
        anchors.bottom: parent.bottom
        width: 300
        color:BasicConfig.rightProperBarBckColor

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
