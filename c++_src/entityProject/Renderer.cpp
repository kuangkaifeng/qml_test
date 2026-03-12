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
    ctx.property("beginPath").call();

    ctx.property("moveTo").call(
        QJSValueList()<<line->x1<<line->y1
        );

    ctx.property("lineTo").call(
        QJSValueList()<<line->x2<<line->y2
        );

    ctx.property("stroke").call();
}

/*
 * 绘制矩形
 */
void Renderer::drawRect(QJSValue ctx, RectEntity *rect)
{
    ctx.property("strokeRect").call(
        QJSValueList()
        << rect->x()
        << rect->y()
        << rect->width
        << rect->height
        );
}

/*
 * 绘制圆
 */
void Renderer::drawCircle(QJSValue ctx, CircleEntity *circle)
{
    ctx.property("beginPath").call();

    ctx.property("arc").call(
        QJSValueList()
        << circle->x()
        << circle->y()
        << circle->radius
        << 0
        << 6.28318
        );

    ctx.property("stroke").call();
}

/*
 * 绘制图片
 */
void Renderer::drawImage(QJSValue ctx, ImageEntity *image)
{
    ctx.property("drawImage").call(
        QJSValueList()
        << image->source
        << image->x()
        << image->y()
        << image->width
        << image->height
        );
}

/*
 * 绘制文本
 */
void Renderer::drawText(QJSValue ctx, TextEntity *text)
{
    /*
     * 设置字体
     */
    QString font = QString("%1px %2")
                       .arg(text->fontSize)
                       .arg(text->fontFamily);

    ctx.setProperty("font", font);

    /*
     * 绘制文字
     */
    ctx.property("fillText").call(
        QJSValueList()
        << text->text
        << text->x()
        << text->y()
        );
}
