import QtQuick 2.15
import QtQuick.Layouts 2.15

Rectangle{



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

                    //var step = 100

                    for(var x = 0; x < width; x += BasicConfig.step)
                    {
                        ctx.beginPath()
                        ctx.moveTo(x,height)
                        ctx.lineTo(x,height-10)
                        ctx.stroke()
                        var value=Math.round(x/BasicConfig.scaleFactor)

                        ctx.fillText(value,x,10)
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

                        //var step = 100

                        for(var y = 0; y < height; y += BasicConfig.step)
                        {
                            ctx.beginPath()
                            ctx.moveTo(width,y)
                            ctx.lineTo(width-10,y)
                            ctx.stroke()
                            var value=Math.round(y/BasicConfig.scaleFactor)
                            ctx.fillText(value,2,y+10)

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



                        for(var x = 0; x < width; x += BasicConfig.gridSize)
                        {
                            ctx.beginPath()
                            ctx.moveTo(x,0)
                            ctx.lineTo(x,height)
                            ctx.stroke()
                        }

                        for(var y = 0 ; y < height; y += BasicConfig.gridSize)
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

                    onPressed: function(mouse){
                        lastX = mouse.x
                        lastY = mouse.y
                    }

                    onPositionChanged:function(mouse) {
                        if(mouse.buttons === Qt.LeftButton)
                        {
                            BasicConfig.offsetX -= mouse.x-lastX
                            BasicConfig.offsetY -= mouse.y-lastY

                            lastX = mouse.x
                            lastY = mouse.y

                            canvas.requestPaint()
                            rulerX.requestPaint()
                            rulerY.requestPaint()
                        }
                    }

                    onWheel: function(wheel){
                        if(wheel.angleDelta.y>0)
                            BasicConfig.scaleFactor *=1.1
                        else
                            BasicConfig.scaleFactor /=1.1

                        canvas.requestPaint()
                        rulerX.requestPaint()
                        rulerY.requestPaint()
                    }
                }
            }
        }
    }

}
