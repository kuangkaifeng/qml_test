#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QDebug>
#include <QDir>

#include <QQmlContext>
#include "datahandler.h"
#include "./c++_src/dxfparser.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    // 设置应用程序的窗口图标
    app.setWindowIcon(QIcon(QGuiApplication::applicationDirPath()+"/../image/icon.ico")); // 从资源文件加载图标




    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    DataHandler dataHandlerManger;
    // 创建示例数据 - 表头: #、层、模式，速度/功率、输出、显示

    engine.rootContext()->setContextProperty("dataHandlerManger",&dataHandlerManger);
    qmlRegisterType<DxfParser>("com.yourcompany.dxfparser", 1, 0, "DxfParser");


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);
    qmlRegisterSingletonType(QUrl("qrc:/BasicConfig.qml"),"BasicConfig",1,0,"BasicConfig");




    return app.exec();
}
