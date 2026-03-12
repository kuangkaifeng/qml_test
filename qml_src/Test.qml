import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.VectorImage 6.8   // 用于 SVG，如果 Qt 版本低，可用 Image 替代
import com.yourcompany.dxfparser 1.0   // 注册的 C++ 模块

Window {
    width: 800
    height: 600
    visible: true
    title: "拖拽图片 / SVG / DXF / DWG 到画布"

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
            canvas.visible = true
            cadInfo.visible = false
        }
    }

    // 画布区域（背景）
    Rectangle {
        id: canvasRect
        anchors.fill: parent
        color: "lightgray"
        border.color: dropArea.containsDrag ? "blue" : "black"
        border.width: 2

        // 显示图片（用于普通图像文件）
        Image {
            id: image
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            visible: false   // 默认隐藏
        }

        // 显示 SVG 文件（Qt 6.8+ 使用 VectorImage，否则可用 Image）
        VectorImage {
            id: svgImage
            anchors.fill: parent
            visible: false
            preferredRendererType: VectorImage.CurveRenderer
        }

        // 显示 DXF 绘制结果的 Canvas
        Canvas {
            id: canvas
            anchors.fill: parent
            visible: false   // 默认隐藏
            property var entities: []   // 存储从 C++ 传来的图形数据

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.save()
                ctx.strokeStyle = "black"
                ctx.lineWidth = 1

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
        }

        // 显示 CAD 文件信息（当拖入 DWG 或无法直接显示时提示）
        Rectangle {
            id: cadInfo
            anchors.fill: parent
            color: "lightyellow"
            border.color: "orange"
            visible: false
            Column {
                anchors.centerIn: parent
                spacing: 10
                Text { text: "📁 CAD 文件已接收"; font.pixelSize: 24; color: "brown" }
                Text { id: cadFileName; font.pixelSize: 18; color: "darkorange" }
                Text { text: "（正在转换并显示，请稍候…）"; font.pixelSize: 14; color: "gray" }
            }
        }

        // 提示文字（当没有任何内容显示时）
        Text {
            anchors.centerIn: parent
            text: "拖拽图片 (jpg/png/...)、SVG、DXF 或 DWG 文件到此处"
            font.pixelSize: 20
            color: "gray"
            visible: !image.visible && !svgImage.visible && !canvas.visible && !cadInfo.visible
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
                canvas.visible = false
                cadInfo.visible = false

                if (imageExts.indexOf(ext) !== -1) {
                    // 图片文件
                    image.source = filePath
                    image.visible = true
                } else if (svgExts.indexOf(ext) !== -1) {
                    // SVG 文件
                    svgImage.source = filePath
                    svgImage.visible = true
                } else if (dxfExts.indexOf(ext) !== -1) {
                    // DXF 文件 -> 调用 C++ 解析器
                    var localPath = filePath.toString().replace(/^(file:\/{3})/g, "")
                    dxfParser.loadFile(localPath)
                    // 显示等待提示（可选）
                } else if (dwgExts.indexOf(ext) !== -1) {
                    // DWG 文件 -> 显示提示，并启动转换（需实现 C++ 部分）
                    cadInfo.visible = true
                    cadFileName.text = fileName
                    // 这里应调用 DwgParser 进行转换，见下文说明
                    // dwgParser.loadFile(localPath)
                } else {
                    console.log("不支持的文件格式")
                }

                drop.accept()
            }
        }
    }
}
