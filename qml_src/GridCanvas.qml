import QtQuick 2.15
import QtQuick.Layouts 2.15
import QtQuick.VectorImage 6.8   // 用于 SVG，如果 Qt 版本低，可用 Image 替代
import com.yourcompany.dxfparser 1.0   // 注册的 C++ 模块

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
            property var entities: []   // 存储从 C++ 传来的图形数据
            property  alias inputText:textEdit.text
            property alias inputVisible: textEditor.visible
            property alias inputTextColor:textEdit.color
            property alias inputTextSize : textEdit.font.pixelSize
            property alias inputTextX: textEditor.x
            property alias inputTextY: textEditor.y
            property alias inputTextZ: textEditor.z
            onPaint: {
                var ctx=getContext("2d")
                ctx.clearRect(0,0,width,height)
                ctx.save()
                ctx.lineWidth=1
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
                ctx.strokeStyle=BasicConfig.penColor
                ctx.lineWidth=BasicConfig.penWidth
                //预览图--线段
                if(BasicConfig.drawing && BasicConfig.currentTool==="linePen")
                {
                    ctx.beginPath()
                    ctx.moveTo(BasicConfig.startX,BasicConfig.startY)
                    ctx.lineTo(BasicConfig.previewX,BasicConfig.previewY)
                    ctx.stroke()
                }
                //预览图 --圆
                if(BasicConfig.drawing && BasicConfig.currentTool==="circlePen")
                {
                    // 计算圆心和半径（假设你有起始点和当前点）
                    const centerX = BasicConfig.startX
                    const centerY = BasicConfig.startY
                    const radius = Math.sqrt(Math.pow(BasicConfig.previewX - BasicConfig.startX, 2) +
                                             Math.pow(BasicConfig.previewY - BasicConfig.startY, 2))

                    ctx.beginPath()
                    ctx.arc(centerX,centerY,radius,0,Math.PI*2)
                    ctx.stroke()
                }
                if(BasicConfig.drawing && BasicConfig.currentTool==="rectPen")
                {
                    ctx.beginPath()
                    ctx.strokeRect(BasicConfig.startX,BasicConfig.startY,BasicConfig.previewX-BasicConfig.startX
                                   ,BasicConfig.previewY-BasicConfig.startY,BasicConfig.penColor,BasicConfig.penWidth,
                                   false)
                }

                renderer.render(ctx,entityManager.entities())
                //画文本


            }


            Connections{
                target: entityManager
                function onEntityManagerChanged()
                {
                    canvas.requestPaint()
                    console.log("width:"+canvas.width+"height:"+canvas.height)
                }
            }
            Component.onCompleted: {
                requestPaint()
                //docManager.setCanvasset(canvas.width,canvas.height)
            }
            Item {
                id: textEditor

                x: BasicConfig.startX
                y: BasicConfig.startY
                width: 100
                height: 40
                visible: false

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"      // 背景透明
                    border.width: 1
                    border.color: "#4A90E2"   // 边框颜色
                    radius: 2
                }

                TextEdit {
                    id: textEdit
                    anchors.fill: parent
                    anchors.margins: 4

                    font.pixelSize: BasicConfig.textFontSize
                    color: BasicConfig.textColor
                    text: ""

                    focus: true
                    wrapMode: TextEdit.WrapAnywhere
                    Keys.onReturnPressed: {
                        textEditor.visible=false
                        entityManager.addText(textEditor.x+10,textEditor.y+20,textEditor.width,textEditor.height,textEdit.text,
                                              textEdit.color,textEdit.font.pixelSize,true)
                        canvas.requestPaint()
                    }
                }
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
                    BasicConfig.currentTool=""
                    canvas.requestPaint()
                    return
                }

                if(BasicConfig.currentTool === "")
                    return

                if(!BasicConfig.drawing)
                {
                    BasicConfig.startX = mouse.x
                    BasicConfig.startY = mouse.y

                    BasicConfig.previewX = mouse.x
                    BasicConfig.previewY = mouse.y

                    BasicConfig.drawing = true
                }
                //画线段
                else if(BasicConfig.currentTool==="linePen")
                {
                    entityManager.addLine(BasicConfig.startX,BasicConfig.startY,mouse.x,mouse.y,BasicConfig.penColor,BasicConfig.penWidth,true)

                }
                //画圆
                else if(BasicConfig.currentTool==="circlePen")
                {
                    var dx = mouse.x-BasicConfig.startX
                    var dy = mouse.y-BasicConfig.startY
                    entityManager.addCircle(BasicConfig.startX,BasicConfig.startY,Math.sqrt(dx * dx + dy * dy),BasicConfig.penColor,BasicConfig.penWidth,true)
                    BasicConfig.drawing = false
                }
                //画矩形
                else if(BasicConfig.currentTool==="rectPen")
                {
                    entityManager.addRect(BasicConfig.startX,BasicConfig.startY,BasicConfig.previewX-BasicConfig.startX
                                          ,BasicConfig.previewY-BasicConfig.startY,BasicConfig.penColor,BasicConfig.penWidth,
                                          true)
                    BasicConfig.drawing = false
                }
                else if(BasicConfig.currentTool==="textPen")
                {
                    var x=mouse.x
                    var y=mouse.y
                    if(mouse.x>canvas.inputTextX&&mouse.y>canvas.inputTextY
                            &&mouse.x<canvas.inputTextX+100&&mouse.y<canvas.inputTextY+40)
                    {
                        //点击了同一个

                    }
                    else
                    {
                        canvas.inputText=""
                        canvas.inputTextColor="black"
                        canvas.inputTextSize=17
                        canvas.inputTextX=mouse.x
                        canvas.inputTextY=mouse.y
                        canvas.inputVisible=true
                        canvas.inputTextZ=1
                        textEdit.forceActiveFocus()
                    }

                    //entityManager.addText(BasicConfig.startX,BasicConfig.startY,"",100,40,BasicConfig.penColor,BasicConfig.penWidth,true)

                }

                BasicConfig.startX = mouse.x
                BasicConfig.startY = mouse.y
                canvas.requestPaint()

            }
            onPositionChanged: function(mouse)
            {
                //console.log("drawing:"+BasicConfig.drawing+"currentTool:"+BasicConfig.currentTool)
                if(BasicConfig.drawing)
                {
                    // BasicConfig.offsetX-=mouse.x-lastX
                    // BasicConfig.offsetY-=mouse.y-lastY
                    // lastX=mouse.x
                    // lastY=mouse.y
                    if(BasicConfig.currentTool==="linePen")
                    {
                        entityManager.addLine(BasicConfig.startX,BasicConfig.startY,mouse.x,mouse.y,BasicConfig.penColor,BasicConfig.penWidth,false);

                    }
                    else if(BasicConfig.currentTool==="circlePen")
                    {
                        var dx = mouse.x - BasicConfig.startX
                        var dy = mouse.y-BasicConfig.startY
                        entityManager.addCircle(mouse.x,mouse.y,Math.sqrt(dx * dx + dy * dy),BasicConfig.penColor,BasicConfig.penWidth,false)
                    }


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
