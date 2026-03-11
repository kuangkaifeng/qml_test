import QtQuick 2.15
import QtQuick.Effects 6.0  // 注意导入模块是 QtQuick.Effects


Item {




    // 背景轨道
    Rectangle {
        id: track
        anchors.fill: parent
        radius: height / 2
        color: root.checked ? root.trackCheckedColor : root.trackColor
        Behavior on color { ColorAnimation { duration: root.animationDuration } }
    }

    // 滑块（可拖动的圆形）
    Rectangle {
        id: thumb
        width: parent.height - 4
        height: width
        radius: width / 2
        color: root.thumbColor

        // 初始位置根据 checked 状态决定
        x: root.checked ? parent.width - width - 2 : 2
        y: 2

        Behavior on x {
            NumberAnimation { duration: root.animationDuration; easing.type: Easing.OutQuad }
        }


    }

    // 鼠标交互区域
    MouseArea {
        anchors.fill: parent
        // 点击切换状态
        onClicked: {
            root.checked = !root.checked
            root.toggled(root.checked)
        }

        // 拖动逻辑：允许用户按住滑块左右拖动
        drag.target: thumb
        drag.axis: Drag.XAxis
        drag.minimumX: 2
        drag.maximumX: parent.width - thumb.width - 2

        onPositionChanged: {
            // 拖动过程中实时更新 checked 状态（可选）
            // 如果滑块超过中点，则视为开启，否则关闭
            if (drag.active) {
                var half = parent.width / 2
                root.checked = (thumb.x + thumb.width / 2) > half
            }
        }

        onReleased: {
            // 拖动结束时，根据滑块位置确定最终状态，并平滑移动到位
            var half = parent.width / 2
            root.checked = (thumb.x + thumb.width / 2) > half
            root.toggled(root.checked)
        }
    }

    // 当外部通过设置 checked 属性改变状态时，滑块会自动动画到对应位置（由 Behavior 处理）
}
