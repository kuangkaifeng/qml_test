#ifndef ENTITY_H
#define ENTITY_H

#include <QObject>
#include <QRectF>

/*
 * Entity 是所有图元的基类
 * 例如：
 * 直线
 * 圆
 * 图片
 * 路径
 *
 * 所有图元都继承自这个类
 */

class Entity : public QObject
{
    Q_OBJECT

public:

    /*
     * 图元类型枚举
     */
    enum Type
    {
        Line,
        Rect,
        Circle,
        Path,
        Image,
        Text,
        Polygon
    };

    /*
     * 构造函数
     */
    explicit Entity(Type type, QObject *parent=nullptr);

    virtual ~Entity(){}

    /*
     * 获取图元类型
     */
    virtual Type type() const=0;

    /*
     * 设置图元位置
     */
    void setPos(double x,double y);


    // 获取图元位置
    QPointF position() const
    {
        return QPointF(this->x(),this->y());
    }
    /*
     * 获取图元位置
     */
    double x() const;
    double y() const;

    /*
     * 设置是否选中
     */
    void setSelected(bool s);

    /*
     * 是否选中
     */
    bool selected() const;


    /*
     * 获取图元边界矩形
     * 用于：
     * 选中
     * 框选
     * 碰撞检测
     */
    virtual QRectF boundingRect() const = 0;
    /**
     * @brief hitTest
     * @param x
     * @param y
     * @return
     */
    virtual bool hitTest(double x,double y)const=0;
    /**
     * @brief move
     * @param dx
     * @param dy
     */
    virtual void move(double dx,double dy)=0;
protected:

    Type m_type;     // 图元类型

    bool m_selected=false; // 是否被选中
    int m_x;
    int m_y;

};

#endif
