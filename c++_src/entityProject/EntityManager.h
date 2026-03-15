#ifndef ENTITYMANAGER_H
#define ENTITYMANAGER_H

#include <QObject>
#include <QList>
#include "Entity.h"
#include "TextEntity.h"
/*
 * 管理所有图元
 */
class EntityManager : public QObject
{
    Q_OBJECT

public:

    explicit EntityManager(QObject *parent=nullptr);

    /*
     * 返回所有图元
     */
    Q_INVOKABLE QList<Entity*> entities() const;

    /*
     * 添加图元
     */
    Q_INVOKABLE void addEntity(Entity *e);

    /**
     * @brief addLine 添加直线图元函数
     * @param x1
     * @param y1
     * @param x2
     * @param y2
     * @param color
     * @param width
     * @param flag
     */
    Q_INVOKABLE void addLine(int x1,int y1,int x2,int y2,QString color,int width,bool flag=false);
    /**
     * @brief addCircle 添加圆图元函数
     * @param x
     * @param y
     * @param r
     * @param color
     * @param width
     * @param flag false是预览图 否则真图
     */
    Q_INVOKABLE void addCircle(int x,int y,int r,QString color,int width,bool flag);
    /**
     * @brief addRect 添加矩形图元函数
     * @param x
     * @param y
     * @param width
     * @param height
     * @param color
     * @param penWidth
     * @param flag
     */
    Q_INVOKABLE void addRect(int x,int y,int width,int height,QString color,int penWidth,bool flag);
    /**
     * @brief clearEntityManager 清除图元管理的所有图
     */
    Q_INVOKABLE void clearEntityManager();
    /**
     * @brief addText
     * @param x
     * @param y
     * @param width
     * @param height
     * @param color
     * @param penWidth
     * @param flag
     */
    Q_INVOKABLE void addText(int x,int y,int width,int height,QString str,QString color,int penWidth,bool flag);
    /**
     * @brief getTextEntities
     * @return
     */
    Q_INVOKABLE QList<TextEntity*> getTextEntities();
signals:
    //图元发生变化
    void entityManagerChanged();

private:

    QList<Entity*> m_entities;
};

#endif
