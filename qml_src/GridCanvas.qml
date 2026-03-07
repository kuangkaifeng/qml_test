import QtQuick 2.15
import QtQuick.Layouts 2.15

Canvas {
        id: gridCanvas
        anchors.centerIn: parent
        width: parent.width - 40   // 画布宽度
        height: parent.height - 40 // 画布高度

        onPaint: {
            var ctx = getContext("2d")
            var gridSize = 20
            var width = gridCanvas.width
            var height = gridCanvas.height

            // 背景
            ctx.fillStyle = "#FFF8F8F8"
            ctx.fillRect(0, 0, width, height)

            // 网格
            ctx.strokeStyle = "#E0E0E0"
            ctx.lineWidth = 1
            for (var y = 0; y < height; y += gridSize) {
                ctx.beginPath()
                ctx.moveTo(0, y)
                ctx.lineTo(width, y)
                ctx.stroke()
            }
            for (var x = 0; x < width; x += gridSize) {
                ctx.beginPath()
                ctx.moveTo(x, 0)
                ctx.lineTo(x, height)
                ctx.stroke()
            }

            // 绘制坐标轴
            ctx.strokeStyle = "black"
            ctx.lineWidth = 2

            // 绘制底部坐标轴
            ctx.beginPath()
            ctx.moveTo(0, height - 5)
            ctx.lineTo(width, height - 5)
            ctx.stroke()

            // 绘制右侧坐标轴
            ctx.beginPath()
            ctx.moveTo(width - 5, 0)
            ctx.lineTo(width - 5, height)
            ctx.stroke()

            // 绘制坐标文字
            ctx.fillStyle = "black"
            ctx.font = "12px Arial"
            for (var x = 0; x < width; x += gridSize) {
                ctx.fillText(x, x + 2, height - 10)  // 在底部显示坐标
            }
            for (var y = 0; y < height; y += gridSize) {
                ctx.fillText(y, 10, y + 10)  // 在左侧显示坐标
            }
        }
    }
