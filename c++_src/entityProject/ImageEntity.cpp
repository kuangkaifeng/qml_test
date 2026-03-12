#include "ImageEntity.h"

ImageEntity::ImageEntity()
    :Entity(Entity::Image)
{
}

Entity::Type ImageEntity::type() const
{
    return Entity::Image;
}

/*
 * 图片包围盒
 */
QRectF ImageEntity::boundingRect() const
{
    return QRectF(m_x,m_y,width,height);
}
