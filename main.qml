import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: mainWindow
    width: 1400
    height: 900
    visible: true
    title: "QML 画图示例"
    color: "#FFF8F8F8"

    property string currentTool: "pen"
    property color penColor: "black"
    property int penWidth: 2

    RowLayout {
        anchors.fill: parent

        // 左侧工具栏
        Rectangle {
            id: leftToolbar

            Layout.preferredWidth: 60
            color: "#FFF0F0F0"

            Column {
                anchors.centerIn: parent
                spacing: 10

                Repeater {
                    model: [
                        {name: "pen", text: "画笔"},
                        {name: "eraser", text: "橡皮"},
                        {name: "clear", text: "清空"}
                    ]
                    Rectangle {
                        width: 40
                        height: 40
                        radius: 4
                        color: currentTool === modelData.name ? "#AAAAAA" : "gray"

                        Text {
                            anchors.centerIn: parent
                            text: modelData.text
                            font.pixelSize: 12
                            color: "white"
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if(modelData.name === "clear"){
                                    gridCanvas.clearCanvas()
                                } else {
                                    currentTool = modelData.name
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

        // 右侧属性栏
        Rectangle {
            Layout.preferredWidth: 200
            color: "#FFF0F0F0"

            Column {
                anchors.centerIn: parent
                spacing: 20

                Text { text: "颜色选择"; font.bold: true }
                Row {
                    spacing: 10
                    Repeater {
                        model: ["black","red","blue","green","yellow"]
                        Rectangle {
                            width: 30
                            height: 30
                            color: modelData
                            border.color: penColor===modelData ? "black" : "transparent"
                            border.width: penColor===modelData ? 2 : 0

                            MouseArea {
                                anchors.fill: parent
                                onClicked: penColor = modelData
                            }
                        }
                    }
                }

                Text { text: "线宽选择"; font.bold: true }
                Row {
                    spacing: 10
                    Repeater {
                        model: [1,2,4,6,8]
                        Rectangle {
                            width: 30
                            height: 30
                            color: "#AAAAAA"
                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                color: "white"
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: penWidth = modelData
                            }
                        }
                    }
                }
            }
        }
    }
}
