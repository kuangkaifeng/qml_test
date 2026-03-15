#include "Renderer.h"

#include "Entity.h"
#include "LineEntity.h"
#include "RectEntity.h"
#include "CircleEntity.h"
#include "ImageEntity.h"
#include "TextEntity.h"
#include <QDebug>

Renderer::Renderer(QObject *parent)
    :QObject(parent)
{
}

/*
 * 主渲染函数
 *
 * 遍历所有图元
 */
void Renderer::render(QJSValue ctx, QList<Entity*> entities)
{
    for(auto e : entities)
    {
        if(!e)
            continue;
        switch(e->type())
        {

        case Entity::Line:
            drawLine(ctx,(LineEntity*)e);
            break;

        case Entity::Rect:
            drawRect(ctx,(RectEntity*)e);
            break;

        case Entity::Circle:
            drawCircle(ctx,(CircleEntity*)e);
            break;

        case Entity::Image:
            drawImage(ctx,(ImageEntity*)e);
            break;
        case Entity::Text:
            drawText(ctx,(TextEntity*)e);
            break;
        default:
            break;
        }
    }
}

/*
 * 绘制直线
 */
void Renderer::drawLine(QJSValue ctx, LineEntity *line)
{
    qDebug() << "drawLine" << line->x1 << line->y1 << line->x2 << line->y2;

    // 在 Qt6 中，直接调用 ctx 的方法，QJSEngine 会自动处理 this 绑定
    // 因为 ctx 本身就是 CanvasRenderingContext2D 对象

    ctx.property("beginPath").callWithInstance(ctx);

    QJSValueList moveArgs;
    moveArgs << line->x1 << line->y1;
    ctx.property("moveTo").callWithInstance(ctx, moveArgs);

    QJSValueList lineArgs;
    lineArgs << line->x2 << line->y2;
    ctx.property("lineTo").callWithInstance(ctx, lineArgs);

    // 设置样式
    ctx.setProperty("lineWidth", 4);
    ctx.setProperty("strokeStyle", line->color);

    ctx.property("stroke").callWithInstance(ctx);
}

/*
 * 绘制矩形
 */
void Renderer::drawRect(QJSValue ctx, RectEntity *rect)
{
    qDebug() << "drawRect" << rect->x() << rect->y() << rect->width << rect->height;

    // 设置样式
    ctx.setProperty("lineWidth", rect->lineWidth);
    ctx.setProperty("strokeStyle", rect->color);

    // 如果填充色不为空，先填充
    if (!rect->fillColor.isEmpty()) {
        ctx.setProperty("fillStyle", rect->fillColor);
        QJSValueList fillArgs;
        fillArgs << rect->x() << rect->y() << rect->width << rect->height;
        ctx.property("fillRect").callWithInstance(ctx, fillArgs);
    }

    // 绘制边框
    QJSValueList strokeArgs;
    strokeArgs << rect->x() << rect->y() << rect->width << rect->height;
    ctx.property("strokeRect").callWithInstance(ctx, strokeArgs);
}

/*
 * 绘制圆
 */
void Renderer::drawCircle(QJSValue ctx, CircleEntity *circle)
{
    qDebug() << "drawCircle" << circle->x() << circle->y() << circle->radius;

    ctx.property("beginPath").callWithInstance(ctx);

    QJSValueList arcArgs;
    arcArgs << circle->x() << circle->y() << circle->radius << 0 << 6.28318; // 0 到 2π

    // 如果是椭圆，需要额外参数
    if (circle->isEllipse) {
        // 这里可以处理椭圆，但 arc 不支持椭圆，需要使用其他方法
        // 简单起见，这里还是画圆
    }

    ctx.property("arc").callWithInstance(ctx, arcArgs);

    // 设置样式
    ctx.setProperty("lineWidth", circle->lineWidth);
    ctx.setProperty("strokeStyle", circle->color);

    // 如果有填充色，先填充
    if (!circle->fillColor.isEmpty()) {
        ctx.setProperty("fillStyle", circle->fillColor);
        ctx.property("fill").callWithInstance(ctx);
    }

    ctx.property("stroke").callWithInstance(ctx);
}

/*
 * 绘制图片
 */
void Renderer::drawImage(QJSValue ctx, ImageEntity *image)
{
    qDebug() << "drawImage" << image->source << image->x() << image->y();

    QJSValueList args;
    args << image->source << image->x() << image->y() << image->width << image->height;
    ctx.property("drawImage").callWithInstance(ctx, args);
}
/*
 * 绘制多边形
 */
// void Renderer::drawPolygon(QJSValue ctx, PolygonEntity *polygon)
// {
//     qDebug() << "drawPolygon points count:" << polygon->points.size();

//     if (polygon->points.isEmpty()) return;

//     ctx.property("beginPath").callWithInstance(ctx);

//     // 移动到第一个点
//     QJSValueList moveArgs;
//     moveArgs << polygon->points[0].x() << polygon->points[0].y();
//     ctx.property("moveTo").callWithInstance(ctx, moveArgs);

//     // 依次连接到其他点
//     for (int i = 1; i < polygon->points.size(); ++i) {
//         QJSValueList lineArgs;
//         lineArgs << polygon->points[i].x() << polygon->points[i].y();
//         ctx.property("lineTo").callWithInstance(ctx, lineArgs);
//     }

//     // 如果是闭合多边形，连接回第一个点
//     if (polygon->closed) {
//         QJSValueList closeArgs;
//         closeArgs << polygon->points[0].x() << polygon->points[0].y();
//         ctx.property("lineTo").callWithInstance(ctx, closeArgs);
//     }

//     // 设置样式
//     ctx.setProperty("lineWidth", polygon->lineWidth);
//     ctx.setProperty("strokeStyle", polygon->color);

//     // 如果有填充色，先填充
//     if (!polygon->fillColor.isEmpty()) {
//         ctx.setProperty("fillStyle", polygon->fillColor);
//         ctx.property("fill").callWithInstance(ctx);
//     }

//     ctx.property("stroke").callWithInstance(ctx);
// }

/*
 * 绘制文本
 */
void Renderer::drawText(QJSValue ctx, TextEntity *text)
{
    qDebug() << "drawText" << text->text << text->x() << text->y();

    QString font = QString("%1px %2")
                       .arg(text->fontSize)
                       .arg(text->fontFamily);
    ctx.setProperty("font", font);
    ctx.setProperty("fillStyle", text->color);

    QJSValueList args;
    args << text->text << text->x() << text->y();
    ctx.property("fillText").callWithInstance(ctx, args);
}
