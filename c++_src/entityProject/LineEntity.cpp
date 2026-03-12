#include "LineEntity.h"

LineEntity::LineEntity()
    :Entity(Entity::Line)
{
}

Entity::Type LineEntity::type() const
{
    return Entity::Line;
}

/*
 * 计算直线的包围矩形
 */
QRectF LineEntity::boundingRect() const
{
    double left=qMin(x1,x2);
    double right=qMax(x1,x2);

    double top=qMin(y1,y2);
    double bottom=qMax(y1,y2);

    return QRectF(left,top,right-left,bottom-top);
}
