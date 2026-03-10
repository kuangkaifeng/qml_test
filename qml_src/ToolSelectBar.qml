import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Shapes 1.8

//图纸操作行
Rectangle{
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
        width: 130

        color:"transparent"
        Text{
            anchors.centerIn: parent
            id:communityText
            font.pixelSize: BasicConfig.textFontSize
            color:BasicConfig.textColor
            text: "案例讨论社区"
            MouseArea{
                id:communitymouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    communitytooltip.visible=true
                    communityText.color="yellow"
                }
                onExited: {
                    communitytooltip.visible=false
                    communityText.color="white"
                }
            }
            // ToolTip: 作为提示框显示
            ToolTip {
                id: communitytooltip
                text: "进入社区网站"
                x:communitymouseArea.mouseX+10
                y:communitymouseArea.mouseY+10
                delay: BasicConfig.tipDelay  // 可调节显示延时，0为立即显示
            }
        }



    }
    //官网地址
    Rectangle{
        id:websiteAddressRect
        anchors.left: communityForum.right
        anchors.leftMargin: 10
        anchors.top: topSplit.bottom
        anchors.bottom: bottomSplit.top
        width: 160

        color:"transparent"
        Text{
            anchors.centerIn: parent
            id:websiteAddressText
            font.pixelSize: BasicConfig.textFontSize
            color:BasicConfig.textColor
            text: "www.thmglaser.com"
            MouseArea{
                id:websiteAddressMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    websiteAddressToolTip.visible=true
                    websiteAddressText.color=BasicConfig.textHoverColor
                }
                onExited: {
                    websiteAddressToolTip.visible=false
                    websiteAddressText.color=BasicConfig.textColor
                }
            }
            // ToolTip: 作为提示框显示
            ToolTip {
                id: websiteAddressToolTip
                text: "进入官网"
                x:websiteAddressMouseArea.mouseX+10
                y:websiteAddressMouseArea.mouseY+10
                delay: BasicConfig.tipDelay // 可调节显示延时，0为立即显示
            }
        }


    }

}
