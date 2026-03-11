
import QtQuick 2.15

/**
  *         该文件为qml单例文件
  *         负责定义全局变量
  *
  */

pragma Singleton
QtObject{
    id:basicConfig


    /*
    *
    *                    ================数据组和数据模型部分==========
    *
    */
    property var fileModel: ["新建", "打开", "保存", "另存为", "导出"]                                                         //文件数据组
    property var editModel: ["撤销","重做","全选","复制","粘贴","查找","替换"]                                                  //编辑数据组
    property var toolModel: ["选择工具","直线工具","矩形工具","椭圆工具","多边形工具","新建/编辑文本","激光位置"]                 //工具数据组
    property var windowModel: ["设备管理","切割/图层/设置","移动"]                                                              //窗口数据组
    property var languageModel: ["中文（简体）","English"]                                                                    //语言数据组
    property var helpModel: ["案例讨论社区","支持论坛","官网","在线视频教程","检查更新"]                                            //帮助数据组
    property var commonToolbar: [
        {name:"新建",text:"qrc:/image/selectTool.png"},
        {name:"文件夹",text:"qrc:/image/pen.png"},
        {name:"保存",text:"qrc:/image/rect.png"},
        {name:"导入",text:"qrc:/image/circle.png"},
        {name:"撤销",text:"qrc:/image/polygon.png"},
        {name:"重做",text:"qrc:/image/edit.png"},
        {name:"保存GCode",text:"qrc:/image/dirction.png"},
        {name:"运行GCode",text:""},
        {name:"旋转组件",text:""},
        {name:"M7",text:""},
        {name:"M8",text:""},
        {name:"素材库",text:""},
        {name:"相机",text:""},
        {name:"AI",text:""}
    ]                                                                                                                       //常用工具栏
    property var leftContextModel: [
        {name:"选择工具",text:"qrc:/image/selectTool.png"},
        {name:"直线工具",text:"qrc:/image/pen.png"},
        {name:"矩形工具",text:"qrc:/image/rect.png"},
        {name:"椭圆工具",text:"qrc:/image/circle.png"},
        {name:"多边形工具",text:"qrc:/image/polygon.png"},
        {name:"新建/编辑文本",text:"qrc:/image/edit.png"},
        {name:"激光位置",text:"qrc:/image/dirction.png"}
    ]                                                                                                                       //工具栏数据


    property var lastPoint: null                                                                                            //上一次笔画
    property var history: []                                                                                                //历史笔画


    /*
    *
    *                    ================颜色部分==========
    *
    */
    property color penColor: "black"                                                                                        //笔颜色
    property int penWidth: 2
    property string currentTool: ""
    property color btnHoverColor :"#FF534353"                                                                               //菜单栏悬浮颜色
    property color backgropundColor: "#FF525353"                                                                            //背景颜色
    property color textHoverColor: "yellow"                                                                                 //文本悬浮颜色
    property color textColor: "white"                                                                                       //文本原始颜色
    property int textFontSize: 18                                                                                           //文本字体大小
    property color rightProperBarBckColor: "#FFB3B5B6"                                                                      //右侧属性栏背景颜色
    property int tipDelay: 1000                                                                                             //提示延时时间设置（ms）

    /*
    *
    *                    ================属性部分==========
    *
    */
    property real scaleFactor: 1.0                                                                                          //画布比例
    property int gridSize: 25                                                                                               //网格大小
    property int step: 50                                                                                                   //尺寸个数
    property real offsetX: 0                                                                                                //x轴偏移
    property real offsetY: 0                                                                                                //y轴偏移
    property bool drawing: false                                                                                            //受否画线模式
    property real startX : 0                                                                                                //直线的开始x位置
    property real startY: 0                                                                                                 //直线开始的y位置
    property real previewX: 0                                                                                               //当前鼠标x位置
    property real previewY: 0                                                                                               //当前鼠标y位置
    property var headerTitles: [
        {name:"#",text:30},
        {name:"层",text:35},
        {name:"模式",text:45},
        {name:"速度/功率",text:60},
        {name:"输出",text:40},
        {name:"显示",text:40}
    ]
    property int tableheaderFontSize: 12                                                                                    //表头字体大小
    property int headerTableHeight: 20                                                                                      //表头高度
    property int tableItemHeight: 20                                                                                        //表内项内容的高度
    property int deviceOptWidth: 40                                                                                         //操作列表中组件的宽度
    property int deviceOptHeight: 40                                                                                        //操作列表中组件的高度
    property int autoOptFouncsWidth: 60                                                                                    //操作列表中组件中的自动对焦宽度
    property int autoOptFouncsHeight: 130                                                                                   //操作列表中组件中的自动对焦高度
    /*
    *
    *                    ================信号部分==========
    *
    */
    //信号
    signal handleMenuItemClicked(string context)                                                                            //处理下拉选项
    signal handleToolclicked(string context)                                                                                //处理工具栏选项
    signal handleTestButtonClicked()                                                                                        //测试按钮被点击事件

    signal handleAction(var actionType, var context)                                                                        //事件信号

}
