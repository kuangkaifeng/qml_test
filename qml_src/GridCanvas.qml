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
        // 创建 DXF 解析器（C++ 对象）
        DxfParser {
            id: dxfParser
            onParseFinished: function(entities) {
                console.log("DXF 解析完成，实体数量:", entities.length)
                canvas.entities = entities
                canvas.requestPaint()
                // 隐藏其他显示元素
                image.visible = false
                svgImage.visible = false
                //canvas.visible = true

            }
        }

        Canvas{
            id:canvas
            anchors.fill: parent
            Component.onCompleted: requestPaint()
            property var entities: []   // 存储从 C++ 传来的图形数据
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
                //画历史线
                for(var k=0;k<BasicConfig.history.length;k++)
                {

                    var line=BasicConfig.history[k]
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
                ctx.strokeStyle="black"
                for (var i = 0; i < entities.length; i++) {
                    var e = entities[i]
                    ctx.beginPath()
                    if (e.type === "line") {
                        ctx.moveTo(e.x1, e.y1)
                        ctx.lineTo(e.x2, e.y2)
                        ctx.stroke()
                    } else if (e.type === "circle") {
                        ctx.arc(e.cx, e.cy, e.r, 0, 2 * Math.PI)
                        ctx.stroke()
                    } else if (e.type === "arc") {
                        ctx.arc(e.cx, e.cy, e.r, e.startAngle, e.endAngle)
                        ctx.stroke()
                    } else if (e.type === "lwpolyline") {
                        var pts = e.points
                        if (pts.length > 0) {
                            ctx.moveTo(pts[0].x, pts[0].y)
                            for (var j = 1; j < pts.length; j++)
                                ctx.lineTo(pts[j].x, pts[j].y)
                            if (e.closed) ctx.closePath()
                            ctx.stroke()
                        }
                    }
                }
                ctx.restore()
            }
            function drawLine(x1,y1,x2,y2,color,width)
            {
                BasicConfig.history.push({start:{x:x1,y:y1}, end:{x:x2,y:y2}, color: color, width: width})
                requestPaint()
            }
            // 拖放区域
            DropArea {
                id: dropArea
                anchors.fill: parent

                onEntered: function(drag) {
                    if (drag.hasUrls) drag.accept()
                }

                onDropped: function(drop) {
                    if (!drop.hasUrls) {
                        drop.accept()
                        return
                    }

                    var url = drop.urls[0]
                    var filePath = url.toString()
                    var fileName = filePath.split('/').pop()
                    var ext = fileName.split('.').pop().toLowerCase()

                    console.log("拖入文件:", fileName, "扩展名:", ext)

                    // 图片格式列表
                    var imageExts = ["jpg", "jpeg", "png", "gif", "bmp"]
                    // SVG 格式
                    var svgExts = ["svg"]
                    // DXF 格式
                    var dxfExts = ["dxf"]
                    // DWG 格式
                    var dwgExts = ["dwg"]

                    // 隐藏所有显示元素
                    image.visible = false
                    svgImage.visible = false

                    //cadInfo.visible = false
                    BasicConfig.dragX=drop.x
                    BasicConfig.dragY=drop.y
                    console.log("drogX:"+BasicConfig.dragX+"drogY:"+BasicConfig.dragY)
                    if (imageExts.indexOf(ext) !== -1) {
                        // 图片文件
                        image.source = filePath
                        image.visible = true
                        //canvas.visible=true
                    } else if (svgExts.indexOf(ext) !== -1) {
                        // SVG 文件
                        svgImage.source = filePath
                        svgImage.visible = true
                    } else if (dxfExts.indexOf(ext) !== -1) {
                        // DXF 文件 -> 调用 C++ 解析器
                        var localPath = filePath.toString().replace(/^(file:\/{3})/g, "")
                        dxfParser.loadFile(localPath)
                        svgImage.visible = true
                        // 显示等待提示（可选）
                    } else {
                        dxfParser.onDrogError("DrogEvent","不支持该文件格式")

                    }

                    drop.accept()
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
        // 显示图片（用于普通图像文件）
        Image {
            id: image
            x:BasicConfig.dragX
            y:BasicConfig.dragY
            width: implicitWidth
            height: implicitHeight
            scale: 0.5
            fillMode: Image.PreserveAspectCrop
            visible: false   // 默认隐藏
        }
        // 显示 SVG 文件（Qt 6.8+ 使用 VectorImage，否则可用 Image）
        VectorImage {
            id: svgImage
            x:BasicConfig.dragX
            y:BasicConfig.dragY
            width: implicitWidth
            height: implicitHeight
            visible: false
            scale: 0.5
            preferredRendererType: VectorImage.PreserveAspectCrop
        }
    }


}
