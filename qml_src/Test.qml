import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 1200
    height: 700
    CustCheckbox
    {
        id:root
        // 对外暴露的属性
        property bool checked: false
        property color trackColor: "#ccc"          // 关闭时的轨道颜色
        property color trackCheckedColor: "#4CAF50" // 开启时的轨道颜色
        property color thumbColor: "#fff"           // 滑块颜色
        property int animationDuration: 200         // 动画时长（毫秒）

        // 尺寸建议（可自定义）
        width: 20
        height: 10

        // 信号，当用户切换时发出
        signal toggled(bool checked)
    }


}
