#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QDebug>
#include <QDir>
<<<<<<< HEAD
#include <QQmlContext>
#include "datahandler.h"

=======
>>>>>>> 1f580ed4d676dc983e06fb6a486bc5e397e37e63

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    // 设置应用程序的窗口图标
    app.setWindowIcon(QIcon(QGuiApplication::applicationDirPath()+"/../image/icon.ico")); // 从资源文件加载图标

<<<<<<< HEAD


    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    DataHandler dataHandlerManger;
    // 创建示例数据 - 表头: #、层、模式，速度/功率、输出、显示
    QList<QVariantList> sampleData;
    sampleData.append({QVariant(1), QVariant("上层"), QVariant("自动"), QVariant("1000 rpm"), true, false});
    sampleData.append({QVariant(2), QVariant("中层"), QVariant("手动"), QVariant("800 rpm"), true, true});
    sampleData.append({QVariant(3), QVariant("下层"), QVariant("自动"), QVariant("1200 rpm"), true, true});
    sampleData.append({QVariant(4), QVariant("上层"), QVariant("手动"), QVariant("600 rpm"), true, true});

    dataHandlerManger.setTableData(sampleData);
    engine.rootContext()->setContextProperty("dataHandlerManger",&dataHandlerManger);

=======
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
>>>>>>> 1f580ed4d676dc983e06fb6a486bc5e397e37e63
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
<<<<<<< HEAD


=======
>>>>>>> 1f580ed4d676dc983e06fb6a486bc5e397e37e63
    return app.exec();
}
