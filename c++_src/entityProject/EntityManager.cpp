#include "EntityManager.h"
#include "LineEntity.h"
#include "CircleEntity.h"

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

void EntityManager::addLine(int x1, int y1, int x2, int y2, QString color, int width,bool flag)
{
    if(flag)
    {
        LineEntity *line=new LineEntity;
        line->x1=x1;
        line->y1=y1;
        line->x2=x2;
        line->y2=y2;
        line->color=color;

        this->addEntity(line);
    }
    else
    {
        for(auto e:m_entities)
        {
            LineEntity *e1=qobject_cast<LineEntity*>(e);
            if(e1)
            {
                if(e1->x1==x1&&e1->y1==y1)
                {
                    e1->x2=x2;
                    e1->y2=y2;
                }
            }

        }
    }

}

void EntityManager::addCircle(int x, int y, int r, QString color, int width, bool flag)
{
    if(flag)
    {
        CircleEntity *circle=new CircleEntity;
        circle->color=color;
        circle->lineWidth=width;
        circle->radius=r;
        circle->setPos(x,y);

        this->addEntity(circle);
    }
    else
    {
        // for(auto e:m_entities)
        // {
        //     LineEntity *e1=qobject_cast<LineEntity*>(e);
        //     if(e1)
        //     {
        //         if(e1->x1==x1&&e1->y1==y1)
        //         {
        //             e1->x2=x2;
        //             e1->y2=y2;
        //         }
        //     }

        // }
    }
}



