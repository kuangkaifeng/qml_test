import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15



Window {
    id:mainWindow
    width: 1400
    height: 800
    visible: true
    flags: Qt.FramelessWindowHint

    title: qsTr("Hello World")
    color:"#F8F8F8"
    property string currentTool: "pen"
    property int penWidth: 1
    property color penColor: "black"
    property bool windowStatus: false
    //缩小，放大，设置，关闭区域
    Rectangle{
        id:topRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top:parent.top
        height: 40
        color:"#FF070B10"

        //支持界面的拖动
        MouseArea{
            id:dragArea
            anchors.fill: parent
            property int dragOffsetX: 0
            property int dragOffsetY: 0
            onPressed: {
                dragOffsetX=dragArea.mouseX
                dragOffsetY=dragArea.mouseY
                console.log("clicked")
            }
            onReleased: {

            }
            onPositionChanged: {
                mainWindow.x+=dragArea.mouseX-dragOffsetX

                mainWindow.y+=dragArea.mouseY-dragOffsetY

            }
        }
        //界面按钮
        Rectangle {
            id: selectFunRect
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 160
            color: "transparent"

            Row {
                anchors.fill: parent
                spacing: 0
                Repeater {
                    id:repeater
                    model:[
                        {name: "min", text: "缩小"},
                        {name: "max", text: "放大"},
                        {name: "set", text: "设置"},
                        {name: "close", text: "关闭"}
                    ]

                    Item {
                        width: 40  // 宽度自动适应父容器
                        height: 40  // 固定高度，避免重叠

                        property color horColor: "transparent"

                        // 背景矩形
                        Rectangle {
                            color: parent.horColor
                            anchors.fill: parent

                            border.width: 0

                        }
                        // 按钮文本
                        Text {
                            anchors.centerIn: parent
                            text: modelData.text
                            font.bold: true
                            font.pixelSize: 14
                            color: "#FFFFFF"
                        }


                        // 鼠标区域，覆盖整个按钮
                        MouseArea {
                            anchors.fill: parent  // 确保 MouseArea 覆盖整个区域
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: {
                                parent.horColor = modelData.name==="close"?"red":"#FF2D3541"
                            }

                            onExited: {
                                parent.horColor = "transparent"  // 鼠标离开时背景恢复透明
                            }

                            onClicked: {
                                console.log("按钮点击: " + modelData.name)
                                // 根据不同按钮的 name 做相应操作
                                if (modelData.name === "close")
                                {
                                    console.log("关闭逻辑")
                                    Qt.quit();  // 退出应用程序
                                }
                                else if (modelData.name === "min")
                                {
                                    console.log("缩小逻辑")
                                    showMinimized()
                                    // 在此处添加缩小窗口的逻辑
                                }
                                else if (modelData.name === "max")
                                {
                                    console.log("放大逻辑")
                                    if(!windowStatus)
                                    {
                                        windowStatus=true
                                        showMaximized()
                                    }
                                    else
                                    {
                                        windowStatus=false
                                        showNormal()
                                    }

                                    // 在此处添加放大窗口的逻辑
                                }
                                else if (modelData.name === "set")
                                {
                                    console.log("设置逻辑")
                                    // 在此处添加设置窗口的逻辑
                                }
                            }
                        }
                    }
                }
            }
        }
        //软件图标
        Rectangle{
            id:softIcon
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 40
            color:"transparent"
            Image {
                id: iconImage
                anchors.centerIn: parent
                source: "qrc:/image/Icon"
            }

        }

       // 自定义菜单栏

       Rectangle {
           anchors.left: softIcon.right
           anchors.leftMargin: 10
           anchors.top: parent.top
           anchors.bottom: parent.bottom
           width: 300
           color: "transparent"  // 设置父控件背景为黑色


           // 菜单栏中的菜单项
           Row {
               anchors.fill: parent


               Repeater{
                   model: ["文件","编辑","工具","窗口","语言","帮助"]

                   Rectangle {
                       width: 60
                       id:menuRect
                       color: mouseArea.containsMouse ? "#FF2D3541" : "transparent"
                       height: parent.height
                       Popup{
                           id:menuPop
                           x:menuRect.x
                           y:menuRect.height
                           width: 150
                           height: 200
                           background: Rectangle {
                                      color: "white"
                                  }
                        Column{

                            anchors.centerIn: parent
                            Repeater{
                                    model: ["新建","打开","保存","另存为","导出"]
                                    Rectangle{
                                        color: mouse2.containsMouse? "#FFCCCCCC":"#FFE1E1E1"
                                         width: menuPop.width
                                         height: 40
                                         Text {
                                                 anchors.centerIn: parent
                                                 text: modelData
                                                 color: "black"
                                             }

                                             MouseArea {
                                                id:mouse2
                                                 anchors.fill: parent
                                                 hoverEnabled: true


                                                 onClicked: {
                                                     console.log("text:"+modelData)
                                                     menuPop.close()
                                                 }
                                             }
                                    }
                                }

                           }

                       }


                       Text{
                           anchors.centerIn: parent
                           text:modelData
                           font.pixelSize: 16
                           color:"white"
                       }
                       MouseArea{
                           id:mouseArea
                           hoverEnabled: true
                           cursorShape: Qt.PointingHandCursor
                           anchors.fill: parent

                           onClicked: {
                               console.log(modelData+"被点击")
                               if(modelData==="文件")
                               {
                                    menuPop.open()
                               }
                               else if(modelData==="编辑")
                               {

                               }
                               else if(modelData==="工具")
                               {

                               }
                               else if(modelData==="窗口")
                               {

                               }
                               else if(modelData==="语言")
                               {

                               }
                               else if(modelData==="帮助")
                               {

                               }
                           }
                       }
                   }

               }

           }

       }

    }
    //图纸操作行
    Rectangle{
        id:selectRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top:topRect.bottom
        height: 40
        color:"#E0E0E0"
    }
    //软件主题栏
    Rectangle{
        anchors.left: parent.left
        anchors.right: rightRect.left
        anchors.top: selectRect.bottom
        anchors.bottom: parent.bottom
        RowLayout{
            anchors.fill: parent
            //左侧工具栏
            Rectangle{
                id:leftToolBar
                Layout.preferredWidth: 60
                color:"#F0F0F0"
                Column{
                    anchors.centerIn: parent
                    spacing: 10
                    Repeater{
                        model: [
                            {name:"pen",text:"画笔"},
                            {name:"eraser",text:"橡皮"},
                            {name:"clear",text:"清空"}
                        ]

                        Rectangle{
                            width: 40
                            height: 40
                            color:currentTool===modelData.name?"#AAAAAA":"gray"
                            radius: 4
                            Text{
                                anchors.centerIn: parent
                                text: modelData.text
                                font.pixelSize: 12
                                color:"white"
                            }
                            MouseArea{
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    if(modelData.name==="clear")
                                    {
                                        gridCanvas.clearCanvas()
                                    }
                                    else
                                    {
                                        currentTool=modelData.name
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // 中间画布
            Canvas {
                id: gridCanvas
                Layout.fillWidth: true
                Layout.fillHeight: true

                property var lastPoint: null
                property var history: []

                onPaint: {
                    var ctx = getContext("2d")
                    var gridSize = 20
                    var width = gridCanvas.width
                    var height = gridCanvas.height

                    // 背景
                    ctx.fillStyle = "#FFF8F8F8"
                    ctx.fillRect(0, 0, width, height)

                    // 网格
                    ctx.strokeStyle = "#FFE0E0E0"
                    ctx.lineWidth = 1
                    for(var y=0; y<height; y+=gridSize){
                        ctx.beginPath()
                        ctx.moveTo(0,y)
                        ctx.lineTo(width,y)
                        ctx.stroke()
                    }
                    for(var x=0; x<width; x+=gridSize){
                        ctx.beginPath()
                        ctx.moveTo(x,0)
                        ctx.lineTo(x,height)
                        ctx.stroke()
                    }

                    // 绘制历史线条
                    for(var i=0;i<history.length;i++){
                        var item = history[i]
                        ctx.strokeStyle = item.color
                        ctx.lineWidth = item.width
                        ctx.beginPath()
                        ctx.moveTo(item.start.x, item.start.y)
                        ctx.lineTo(item.end.x, item.end.y)
                        ctx.stroke()
                    }
                }

                function drawLine(x1, y1, x2, y2, color, width){
                    history.push({start:{x:x1,y:y1}, end:{x:x2,y:y2}, color: color, width: width})
                    requestPaint()
                }

                function eraseAt(x,y){
                    for(var i=history.length-1;i>=0;i--){
                        var item = history[i]
                        var dx = (item.start.x + item.end.x)/2 - x
                        var dy = (item.start.y + item.end.y)/2 - y
                        if(Math.sqrt(dx*dx + dy*dy) < 10){
                            history.splice(i,1)
                        }
                    }
                    requestPaint()
                }

                function clearCanvas(){
                    history=[]
                    requestPaint()
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: function(mouse){
                        gridCanvas.lastPoint = {x: mouse.x, y: mouse.y}
                        if(currentTool === "eraser"){
                            gridCanvas.eraseAt(mouse.x, mouse.y)
                        }
                    }
                    onPositionChanged: function(mouse){
                        if(gridCanvas.lastPoint){
                            if(currentTool === "pen"){
                                gridCanvas.drawLine(gridCanvas.lastPoint.x, gridCanvas.lastPoint.y, mouse.x, mouse.y, penColor, penWidth)
                                gridCanvas.lastPoint = {x: mouse.x, y: mouse.y}
                            } else if(currentTool === "eraser"){
                                gridCanvas.eraseAt(mouse.x, mouse.y)
                            }
                        }
                    }
                    onReleased: function(mouse){
                        gridCanvas.lastPoint = null
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

    }
    Rectangle{
        id:rightRect1
        anchors.right: parent.right
        anchors.top: rightRect.bottom
        anchors.topMargin: 10
        width: 200
        height: 200
        color:"gray"

    }
    Rectangle{
        id:rightRect2
        anchors.right: parent.right
        anchors.top: rightRect1.bottom
        anchors.topMargin: 10
        width: 200
        height: 200
        color:"gray"

    }



}
