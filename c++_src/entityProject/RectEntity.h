#ifndef RECTENTITY_H
#define RECTENTITY_H

#include "Entity.h"

/*
 * 矩形图元
 */
class RectEntity : public Entity
{
public:

    RectEntity();

    double width;   // 宽
    double height;  // 高
    /*
     * 返回图元类型
     */
    Entity::Type type() const override;

    QRectF boundingRect() const override;
};

#endif
