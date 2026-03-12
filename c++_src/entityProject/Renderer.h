#ifndef RENDERER_H
#define RENDERER_H

#include <QObject>
#include <QList>
#include <QJSValue>

class Entity;
class LineEntity;
class RectEntity;
class CircleEntity;
class ImageEntity;
class TextEntity;
/*
 * Renderer 类
 *
 * 作用：
 * 将 Scene 中的所有 Entity 绘制到 QML Canvas 上
 *
 * 工作流程：
 *
 * Canvas.onPaint
 *        ↓
 * Renderer.render()
 *        ↓
 * 遍历 Entity
 *        ↓
 * 调用对应绘制函数
 *
 */

class Renderer : public QObject
{
    Q_OBJECT

public:

    /*
     * 构造函数
     */
    explicit Renderer(QObject *parent=nullptr);

    /*
     * 主渲染函数
     *
     * ctx:
     *     QML Canvas 的 2D Context
     *
     * entities:
     *     Scene 中所有图元
     */
    Q_INVOKABLE void render(QJSValue ctx, QList<Entity*> entities);

private:

    /*
     * 绘制直线
     */
    void drawLine(QJSValue ctx, LineEntity *line);

    /*
     * 绘制矩形
     */
    void drawRect(QJSValue ctx, RectEntity *rect);

    /*
     * 绘制圆
     */
    void drawCircle(QJSValue ctx, CircleEntity *circle);

    /*
     * 绘制图片
     */
    void drawImage(QJSValue ctx, ImageEntity *image);
    /*
 * 绘制文本
 */
    void drawText(QJSValue ctx, TextEntity *text);


};

#endif
