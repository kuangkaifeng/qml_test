#ifndef LINEENTITY_H
#define LINEENTITY_H

#include "Entity.h"

/*
 * 直线图元
 */
class LineEntity : public Entity
{
public:

    LineEntity();

    double x1; // 起点X
    double y1; // 起点Y

    double x2; // 终点X
    double y2; // 终点Y
    /*
     * 返回图元类型
     */
    Entity::Type type() const override;

    /*
     * 返回直线的包围盒
     */
    QRectF boundingRect() const override;
};

#endif
