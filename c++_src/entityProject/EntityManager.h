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
    Q_INVOKABLE void addLine(qreal x1, qreal y1, qreal x2, qreal y2)
    {
        LineEntity* line = new LineEntity();
        line->start = QPointF(x1, y1);
        line->end   = QPointF(x2, y2);
        entityList.append(line);
        emit entityListChanged();  // 通知 QML
    }

    Q_INVOKABLE void addText(qreal x, qreal y, const QString& text)
    {
        TextEntity* t = new TextEntity();
        t->setPosition(QPointF(x, y));
        t->text = text;
        entityList.append(t);
        emit entityListChanged();
    }
private:

    QList<Entity*> m_entities;
};

#endif
