#include "TextEntity.h"
#include <QFont>
#include <QFontMetricsF>
#include <QRectF>

/*
 * 构造函数
 */
TextEntity::TextEntity()
    :Entity(Entity::Line)
{
}

/*
 * 返回图元类型
 */
Entity::Type TextEntity::type() const
{
    return Entity::Text;
}
QRectF TextEntity::boundingRect() const
{
    // 使用默认字体测量文本大小
    QFont font;  // 可以换成实际字体
    QFontMetricsF fm(font);
    QSizeF size = fm.size(Qt::TextSingleLine, text);

    // 返回包围矩形，左上角是 position()
    QPointF pos = position();
    return QRectF(QPointF(pos.x(), pos.y()), size);

}

bool TextEntity::hitTest(double x, double y) const
{
    return x>=m_x && x<=m_x+width &&
           y>=m_y && y<=m_y+height;
}

void TextEntity::move(double x, double y)
{
    m_x+=x;
    m_y+=y;

}
