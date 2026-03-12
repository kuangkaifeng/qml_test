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
