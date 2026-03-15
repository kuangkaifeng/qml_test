#include "EntityManager.h"
#include "LineEntity.h"
#include "CircleEntity.h"
#include "RectEntity.h"


#include <QDebug>

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
        for(auto e:m_entities)
        {
            CircleEntity* e1=qobject_cast<CircleEntity*>(e);
            if(e1)
            {
                if(e1->x()==x&&e1->y()==y)
                {
                    e1->radius=r;
                }
            }
        }

    }
}

void EntityManager::addRect(int x, int y, int width, int height, QString color, int penWidth, bool flag)
{
    if(flag)
    {
        RectEntity *rect=new RectEntity;
        rect->color=color;
        rect->lineWidth=penWidth;
        rect->width=width;
        rect->height=height;
        rect->setPos(x,y);

        this->addEntity(rect);
    }
    else
    {
        for(auto e:m_entities)
        {
            RectEntity* e1=qobject_cast<RectEntity*>(e);
            if(e1)
            {
                if(e1->x()==x&&e1->y()==y)
                {
                    e1->width=width;
                    e1->height=height;
                }
            }
        }

    }
}

void EntityManager::clearEntityManager()
{
    m_entities.clear();

    qDebug()<<"m_entities size:"<<m_entities.size();
    emit entityManagerChanged();
}

void EntityManager::addText(int x, int y,int width,int height,QString str, QString color, int penWidth, bool flag)
{
    if(flag)
    {
        TextEntity *text=new TextEntity;
        text->color=color;
        text->width=width;
        text->height=height;
        text->text=str;
        text->fontSize=penWidth;
        text->setPos(x,y);

        this->addEntity(text);
    }
    // else
    // {
    //     for(auto e:m_entities)
    //     {
    //         RectEntity* e1=qobject_cast<RectEntity*>(e);
    //         if(e1)
    //         {
    //             if(e1->x()==x&&e1->y()==y)
    //             {
    //                 e1->width=width;
    //                 e1->height=height;
    //             }
    //         }
    //     }

    // }
}

QList<TextEntity *> EntityManager::getTextEntities()
{
    QList<TextEntity *> result;
    for(auto e:m_entities)
    {
        TextEntity* e1=qobject_cast<TextEntity*>(e);
        if(e1)
        {
            result.append(e1);
        }
    }
    return result;
}



