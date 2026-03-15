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

bool ImageEntity::hitTest(double x, double y) const
{
    return x>=m_x && x<=m_x+width &&
           y>=m_y && y<=m_y+height;


}

void ImageEntity::move(double dx, double dy)
{
    m_x+=dx;
    m_y+=dy;
}
