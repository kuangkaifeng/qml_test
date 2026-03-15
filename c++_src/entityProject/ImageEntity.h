#ifndef IMAGEENTITY_H
#define IMAGEENTITY_H

#include "Entity.h"
#include <QString>

/*
 * 图片图元
 * 用于激光雕刻
 */
class ImageEntity : public Entity
{
public:

    ImageEntity();

    QString source; // 图片路径

    double width;   // 宽
    double height;  // 高
    /*
     * 返回图元类型
     */
    Entity::Type type() const override;

    QRectF boundingRect() const override;

    bool hitTest(double x,double y)const override;

    void move(double dx,double dy)override;
};

#endif
