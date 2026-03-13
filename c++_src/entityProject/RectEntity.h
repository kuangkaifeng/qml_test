#ifndef RECTENTITY_H
#define RECTENTITY_H

#include "Entity.h"
#include <QColor>
/*
 * 矩形图元
 */
class RectEntity : public Entity
{
    Q_OBJECT
public:

    RectEntity();

    double width;   // 宽
    double height;  // 高
    QString color;

    QString fillColor="";//填充颜色

    int lineWidth=0;
    /*
     * 返回图元类型
     */
    Entity::Type type() const override;

    QRectF boundingRect() const override;
};

#endif
