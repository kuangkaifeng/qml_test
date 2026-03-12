#ifndef ENTITYMANAGER_H
#define ENTITYMANAGER_H

#include <QObject>
#include <QList>
#include "Entity.h"

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
    QList<Entity*> entities() const;

    /*
     * 添加图元
     */
    void addEntity(Entity *e);

private:

    QList<Entity*> m_entities;
};

#endif
