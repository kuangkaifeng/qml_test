#ifndef TEXTENTITY_H
#define TEXTENTITY_H

#include "Entity.h"
#include <QString>

/*
 * TextEntity
 *
 * 作用：
 * 表示画布上的文本对象
 *
 * 例如：
 * Hello
 * 激光软件
 * Laser Software
 */

class TextEntity : public Entity
{
    Q_OBJECT
public:

    /*
     * 构造函数
     */
    TextEntity();

    /*
     * 返回图元类型
     */
    Entity::Type type() const override;

    QRectF boundingRect() const override;

    bool hitTest(double x,double y)const override;

    void move(double x,double y)override;

public:

    /*
     * 文本内容
     */
    QString text;

    /*
     * 字体大小
     */
    int fontSize = 20;
    //输入框的宽度
    int width=100;
    //输入框的高度
    int height=40;
    /*
     * 字体名称
     */
    QString fontFamily = "Arial";

    QString color;

};

#endif
