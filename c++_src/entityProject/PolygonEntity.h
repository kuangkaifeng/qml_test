#ifndef POLYGONENTITY_H
#define POLYGONENTITY_H

#include "Entity.h"
#include <QVector>
#include <QPointF>

class PolygonEntity : public Entity
{
    Q_OBJECT
    Q_PROPERTY(QVector<QPointF> points READ points WRITE setPoints NOTIFY pointsChanged)
    Q_PROPERTY(bool closed READ closed WRITE setClosed NOTIFY closedChanged)
    Q_PROPERTY(QString color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(QString fillColor READ fillColor WRITE setFillColor NOTIFY fillColorChanged)
    Q_PROPERTY(int lineWidth READ lineWidth WRITE setLineWidth NOTIFY lineWidthChanged)

public:
    explicit PolygonEntity(QObject *parent = nullptr);
    /*
     * 返回图元类型
     */
    Entity::Type type() const override{return Entity::Polygon;}


    QVector<QPointF> points() const { return m_points; }
    void setPoints(const QVector<QPointF> &points);

    bool closed() const { return m_closed; }
    void setClosed(bool closed);

    QString color() const { return m_color; }
    void setColor(const QString &color);

    QString fillColor() const { return m_fillColor; }
    void setFillColor(const QString &fillColor);

    int lineWidth() const { return m_lineWidth; }
    void setLineWidth(int lineWidth);

signals:
    void pointsChanged();
    void closedChanged();
    void colorChanged();
    void fillColorChanged();
    void lineWidthChanged();

private:
    QVector<QPointF> m_points;
    bool m_closed = true;
    QString m_color = "#000000";
    QString m_fillColor;
    int m_lineWidth = 1;
};

#endif // POLYGONENTITY_H
