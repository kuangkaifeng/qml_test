#ifndef CIRCLEENTITY_H
#define CIRCLEENTITY_H

#include "Entity.h"

/*
 * 圆形图元
 */
class CircleEntity : public Entity
{
    Q_OBJECT
public:

    CircleEntity();

    double radius; // 半径

    /*
     * 返回图元类型
     */
    Entity::Type type() const override;

    QRectF boundingRect() const override;

    bool hitTest(double x,double y)const override;

    void move(double dx,double dy)override;
    bool isEllipse=false;

    int lineWidth;
    QString color;

    QString fillColor;


};

#endif
