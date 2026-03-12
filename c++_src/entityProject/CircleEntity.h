#ifndef CIRCLEENTITY_H
#define CIRCLEENTITY_H

#include "Entity.h"

/*
 * 圆形图元
 */
class CircleEntity : public Entity
{
public:

    CircleEntity();

    double radius; // 半径

    /*
     * 返回图元类型
     */
    Entity::Type type() const override;

    QRectF boundingRect() const override;
};

#endif
