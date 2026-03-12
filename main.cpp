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

#include "c++_src/entityProject/Renderer.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    // 设置应用程序的窗口图标
    app.setWindowIcon(QIcon(QGuiApplication::applicationDirPath()+"/../image/icon.ico")); // 从资源文件加载图标


    EntityManager manager;

    /*
     * 创建直线
     */
    LineEntity *line=new LineEntity;
    line->x1=100;
    line->y1=100;
    line->x2=400;
    line->y2=200;

    manager.addEntity(line);

    /*
     * 创建矩形
     */
    RectEntity *rect=new RectEntity;
    rect->setPos(200,200);
    rect->width=150;
    rect->height=100;

    manager.addEntity(rect);

    /*
     * 创建圆
     */
    CircleEntity *circle=new CircleEntity;
    circle->setPos(500,200);
    circle->radius=80;

    manager.addEntity(circle);

    /*
     * 创建文本
     */
    TextEntity *text=new TextEntity;
    text->setPos(300,400);
    text->text="Laser Software";

    manager.addEntity(text);

    Renderer renderer;

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.rootContext()->setContextProperty("entityManager",&manager);
    engine.rootContext()->setContextProperty("renderer",&renderer);
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
