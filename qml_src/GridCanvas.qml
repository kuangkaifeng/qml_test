import QtQuick 2.15
import QtQuick.Layouts 2.15

Rectangle{

    //顶部尺寸
    Rectangle{
        id:rulerTop
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40
        color:"#eeeeee"
        Canvas{
            id:topCanvas
            anchors.fill: parent
            Component.onCompleted: requestPaint()
            onPaint: {
                var ctx=getContext("2d")
                ctx.clearRect(0,0,width,height)
                ctx.strokeStyle="black"
                ctx.fillStyle="black"
                for(var x=10;x<width;x+=BasicConfig.step)
                {
                    ctx.beginPath()
                    ctx.moveTo(x,0)
                    ctx.lineTo(x,10)
                    ctx.stroke()
                    var value=Math.round(x/BasicConfig.scaleFactor)
                    ctx.fillText(value,x-5,20)
                }
            }
        }
    }
    //左侧尺寸
    Rectangle{
        id:rulerLeft
        anchors.left: parent.left
        anchors.top: rulerTop.bottom
        anchors.bottom: parent.bottom
        width: 50
        color:"#eeeeee"
        Canvas{
            id:leftCanvas
            anchors.fill: parent
            Component.onCompleted: requestPaint()
            onPaint: {
                var ctx=getContext("2d")
                ctx.clearRect(0,0,width,height)
                ctx.strokeStyle="black"
                ctx.fillStyle="black"

                for(var y=10;y<height;y+=BasicConfig.step)
                {
                    ctx.beginPath()
                    ctx.moveTo(0,y)
                    ctx.lineTo(10,y)
                    ctx.stroke()
                    var value=Math.round(y/BasicConfig.scaleFactor)
                    ctx.fillText(value,12,y+5)

                }
            }
        }
    }
    //右侧尺寸
    Rectangle{
        id:rulerRight
        anchors.right: parent.right
        anchors.top: rulerTop.bottom
        anchors.bottom: parent.bottom
        width: 50
        color:"#eeeeee"
        Canvas{
            id:rightCanvas
            anchors.fill: parent
            Component.onCompleted: requestPaint()
            onPaint: {
                var ctx=getContext("2d")
                ctx.clearRect(0,0,width,height)
                ctx.strokeStyle="black"
                ctx.fillStyle="black"

                for(var y=10;y<height;y+=BasicConfig.step)
                {
                    ctx.beginPath()
                    ctx.moveTo(width,y)
                    ctx.lineTo(width-10,y)
                    ctx.stroke()
                    var value=Math.round(y/BasicConfig.scaleFactor)
                    ctx.fillText(value,12,y+5)

                }
            }
        }
    }
    //底层尺寸
    Rectangle{
        id:rulerBottom
        anchors.left: rulerLeft.right
        anchors.right: rulerRight.left
        anchors.bottom: parent.bottom
        height: 40
        color:"#eeeeee"
        Canvas{
            id:bottomCanvas
            anchors.fill: parent
            Component.onCompleted: requestPaint()
            onPaint: {
                var ctx=getContext("2d")
                ctx.clearRect(0,0,width,height)
                ctx.strokeStyle="black"
                ctx.fillStyle="black"
                for(var x=10;x<width;x+=BasicConfig.step)
                {
                    ctx.beginPath()
                    ctx.moveTo(x,height)
                    ctx.lineTo(x,height-10)
                    ctx.stroke()
                    var value=Math.round(x/BasicConfig.scaleFactor)
                    ctx.fillText(value,x-5,20)
                }
            }
        }
    }
    //中间画布
    Rectangle{
        id:rulerMid
        anchors.left: rulerLeft.right
        anchors.right: rulerRight.left
        anchors.top: rulerTop.bottom
        anchors.bottom: rulerBottom.top
        width: parent.width-rulerLeft.width-rulerRight.width
        height: parent.height-rulerTop.height-rulerBottom.height
        color: "white"
        border.color: "#999"
        Canvas{
            id:canvas
            anchors.fill: parent
            Component.onCompleted: requestPaint()
            onPaint: {
                var ctx=getContext("2d")
                ctx.clearRect(0,0,width,height)
                ctx.strokeStyle="#e0e0e0"
                //竖线
                for(var x=0;x<width;x+=BasicConfig.gridSize)
                {
                    ctx.beginPath()
                    ctx.moveTo(x,0)
                    ctx.lineTo(x,height)
                    ctx.stroke()

                }
                //横线
                for(var y=0;y<height;y+=BasicConfig.gridSize)
                {
                    ctx.beginPath()
                    ctx.moveTo(0,y)
                    ctx.lineTo(width,y)
                    ctx.stroke()
                }
                //画历史线
                for(var i=0;i<BasicConfig.history.length;i++)
                {

                    var line=BasicConfig.history[i]
                    ctx.strokeStyle=line.color
                    ctx.lineWidth=line.width
                    ctx.beginPath()
                    ctx.moveTo(line.start.x,line.start.y)
                    ctx.lineTo(line.end.x,line.end.y)
                    ctx.stroke()
                }
                //console.log("drawing:"+BasicConfig.drawing+"currentTool:"+BasicConfig.currentTool)
                if(BasicConfig.drawing && BasicConfig.currentTool==="linePen")
                {
                    ctx.strokeStyle=BasicConfig.penColor
                    ctx.lineWidth=BasicConfig.penWidth

                    ctx.beginPath()
                    ctx.moveTo(BasicConfig.startX,BasicConfig.startY)
                    ctx.lineTo(BasicConfig.previewX,BasicConfig.previewY)
                    ctx.stroke()
                }
            }
            function drawLine(x1,y1,x2,y2,color,width)

            {
                BasicConfig.history.push({start:{x:x1,y:y1}, end:{x:x2,y:y2}, color: color, width: width})
                requestPaint()
            }
        }
        MouseArea{
            anchors.fill: parent
            property real lastX
            property real lastY
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton|Qt.RightButton
            onPressed: function(mouse)
            {
                if(mouse.button === Qt.RightButton)
                {
                    console.log("鼠标点击了右键")
                    BasicConfig.drawing = false
<<<<<<< HEAD
                    BasicConfig.currentTool=""
=======
>>>>>>> 1f580ed4d676dc983e06fb6a486bc5e397e37e63
                    canvas.requestPaint()
                    return
                }

                if(BasicConfig.currentTool !== "linePen")
                    return

                if(!BasicConfig.drawing)
                {
                    BasicConfig.startX = mouse.x
                    BasicConfig.startY = mouse.y

                    BasicConfig.previewX = mouse.x
                    BasicConfig.previewY = mouse.y

                    BasicConfig.drawing = true
                }
                else
                {
                    canvas.drawLine(
                        BasicConfig.startX,
                        BasicConfig.startY,
                        mouse.x,
                        mouse.y,
                        BasicConfig.penColor,
                        BasicConfig.penWidth
                    )

                    BasicConfig.startX = mouse.x
                    BasicConfig.startY = mouse.y
                }

                canvas.requestPaint()

            }
            onPositionChanged: function(mouse)
            {
                //console.log("drawing:"+BasicConfig.drawing+"currentTool:"+BasicConfig.currentTool)
                if(BasicConfig.drawing&&BasicConfig.currentTool==="linePen")
                {
                    // BasicConfig.offsetX-=mouse.x-lastX
                    // BasicConfig.offsetY-=mouse.y-lastY
                    // lastX=mouse.x
                    // lastY=mouse.y

                    BasicConfig.previewX=mouse.x
                    BasicConfig.previewY=mouse.y


                    canvas.requestPaint()
                    leftCanvas.requestPaint()
                    rightCanvas.requestPaint()
                    topCanvas.requestPaint()
                    bottomCanvas.requestPaint()
                }
            }

            onWheel: function(wheel)
            {
                if(wheel.angleDelta.y>0)
                {
                    BasicConfig.scaleFactor*=1.1
                }
                else
                {
                    BasicConfig.scaleFactor/=1.1
                }
                canvas.requestPaint()
                leftCanvas.requestPaint()
                rightCanvas.requestPaint()
                topCanvas.requestPaint()
                bottomCanvas.requestPaint()
            }
        }
    }

}
