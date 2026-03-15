#include <QApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QDebug>
#include <QDir>

#include <QQmlContext>
#include "datahandler.h"
#include "./c++_src/dxfparser.h"

#include "c++_src/entityProject/EntityManager.h"
#include "c++_src/entityProject/LineEntity.h"
#include "c++_src/entityProject/RectEntity.h"
#include "c++_src/entityProject/CircleEntity.h"
#include "c++_src/entityProject/TextEntity.h"
#include "c++_src/entityProject/ImageEntity.h"
#include "c++_src/entityProject/Renderer.h"
#include "c++_src/fileManager/DocumentManager.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    // 设置应用程序的窗口图标
    app.setWindowIcon(QIcon(QGuiApplication::applicationDirPath()+"/../image/icon.ico")); // 从资源文件加载图标


    EntityManager manager;
    Renderer renderer;
    DocumentManager docManager;
    docManager.newDocument();

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.rootContext()->setContextProperty("entityManager",&manager);
    engine.rootContext()->setContextProperty("renderer",&renderer);
    engine.rootContext()->setContextProperty("docManager",&docManager);



    DataHandler dataHandlerManger;

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
