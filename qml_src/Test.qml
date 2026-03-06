import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 1000
    height: 700
    title: "Canvas Ruler Demo"

    property real scaleFactor: 1.0
    property real offsetX: 0
    property real offsetY: 0

    Column {
        anchors.fill: parent
        spacing: 0

        // ====================
        // 顶部坐标尺
        // ====================
        Rectangle {
            height: 30
            width: parent.width
            color: "#eeeeee"

            Canvas {
                id: rulerX
                anchors.fill: parent

                Component.onCompleted: requestPaint()

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0,0,width,height)

                    ctx.strokeStyle = "black"
                    ctx.fillStyle = "black"

                    var step = 50 * scaleFactor

                    for(var x = -offsetX % step; x < width; x += step)
                    {
                        ctx.beginPath()
                        ctx.moveTo(x,height)
                        ctx.lineTo(x,height-10)
                        ctx.stroke()

                        ctx.fillText(Math.round((x+offsetX)/scaleFactor),x+2,10)
                    }
                }
            }
        }

        Row {
            width: parent.width
            height: parent.height-30
            // ====================
            // 左侧坐标尺
            // ====================
            Rectangle {
                width: 40
                height: parent.height
                color: "#eeeeee"

                Canvas {
                    id: rulerY
                    anchors.fill: parent

                    Component.onCompleted: requestPaint()

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0,0,width,height)

                        ctx.strokeStyle = "black"
                        ctx.fillStyle = "black"

                        var step = 50 * scaleFactor

                        for(var y = -offsetY % step; y < height; y += step)
                        {
                            ctx.beginPath()
                            ctx.moveTo(width,y)
                            ctx.lineTo(width-10,y)
                            ctx.stroke()

                            ctx.fillText(Math.round((y+offsetY)/scaleFactor),2,y+10)
                        }
                    }
                }
            }

            // ====================
            // 中间画布
            // ====================
            Rectangle {
                id: canvasArea
                width: parent.width - 40
                height: parent.height
                color: "white"
                border.color: "#999"

                Canvas {
                    id: canvas
                    anchors.fill: parent

                    Component.onCompleted: requestPaint()

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0,0,width,height)

                        ctx.strokeStyle = "#e0e0e0"

                        var step = 50 * scaleFactor

                        for(var x = -offsetX % step; x < width; x += step)
                        {
                            ctx.beginPath()
                            ctx.moveTo(x,0)
                            ctx.lineTo(x,height)
                            ctx.stroke()
                        }

                        for(var y = -offsetY % step; y < height; y += step)
                        {
                            ctx.beginPath()
                            ctx.moveTo(0,y)
                            ctx.lineTo(width,y)
                            ctx.stroke()
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    property real lastX
                    property real lastY

                    onPressed: {
                        lastX = mouse.x
                        lastY = mouse.y
                    }

                    onPositionChanged: {
                        if(mouse.buttons === Qt.LeftButton)
                        {
                            offsetX -= mouse.x-lastX
                            offsetY -= mouse.y-lastY

                            lastX = mouse.x
                            lastY = mouse.y

                            canvas.requestPaint()
                            rulerX.requestPaint()
                            rulerY.requestPaint()
                        }
                    }

                    onWheel: function(wheel){
                        if(wheel.angleDelta.y>0)
                            scaleFactor *=1.1
                        else
                            scaleFactor /=1.1

                        canvas.requestPaint()
                        rulerX.requestPaint()
                        rulerY.requestPaint()
                    }
                }
            }
        }
    }

}
