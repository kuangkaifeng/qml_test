#include "EntityManager.h"

EntityManager::EntityManager(QObject *parent)
    :QObject(parent)
{
}

QList<Entity*> EntityManager::entities() const
{
    return m_entities;
}

void EntityManager::addEntity(Entity *e)
{
    m_entities.append(e);
}
