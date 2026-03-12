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
