#include "Entity.h"

/*
 * 构造函数
 */
Entity::Entity(Type type,QObject *parent)
    :QObject(parent),
    m_type(type)
{
}

/*
 * 返回图元类型
 */
Entity::Type Entity::type() const
{
    return m_type;
}

/*
 * 设置位置
 */
void Entity::setPos(double x,double y)
{
    m_x=x;
    m_y=y;
}

/*
 * 获取X
 */
double Entity::x() const
{
    return m_x;
}

/*
 * 获取Y
 */
double Entity::y() const
{
    return m_y;
}

/*
 * 设置选中
 */
void Entity::setSelected(bool s)
{
    m_selected=s;
}

/*
 * 是否选中
 */
bool Entity::selected() const
{
    return m_selected;
}
