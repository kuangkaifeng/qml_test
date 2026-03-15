#include "CircleEntity.h"

CircleEntity::CircleEntity()
    :Entity(Entity::Circle)
{
}

Entity::Type CircleEntity::type() const
{
    return Entity::Circle;
}

/*
 * 计算圆形包围盒
 */
QRectF CircleEntity::boundingRect() const
{
    return QRectF(m_x-radius,
                  m_y-radius,
                  radius*2,
                  radius*2);
}

bool CircleEntity::hitTest(double x,double y) const
{
    double dx=x-m_x;
    double dy=y-m_y;

    return sqrt(dx*dx+dy*dy)<=radius;
}

void CircleEntity::move(double dx, double dy)
{
    m_x+=dx;
    m_y+=dy;
}
