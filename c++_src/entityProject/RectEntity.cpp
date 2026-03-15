#include "RectEntity.h"

RectEntity::RectEntity()
    :Entity(Entity::Rect)
{
}

Entity::Type RectEntity::type() const
{
    return Entity::Rect;
}

/*
 * 返回矩形边界
 */
QRectF RectEntity::boundingRect() const
{
    return QRectF(m_x,m_y,width,height);
}

bool RectEntity::hitTest(double x, double y) const
{
    return x>=m_x && x<=m_x+width &&
           y>=m_y && y<=m_y+height;
}

void RectEntity::move(double dx, double dy)
{
    m_x+=dx;
    m_y+=dy;
}
