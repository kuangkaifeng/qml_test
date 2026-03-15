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

bool LineEntity::hitTest(double x, double y) const
{
    double dx = x2-x1;
    double dy = y2-y1;

    double len = sqrt(dx*dx+dy*dy);

    double distance =
        fabs(dy*x - dx*y + x2*y1 - y2*x1)/len;

    return distance < 5;
}

void LineEntity::move(double dx, double dy)
{
    x1+=dx;
    y1+=dy;
    x2+=dx;
    y2+=dy;
}


