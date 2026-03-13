#include "PolygonEntity.h"

PolygonEntity::PolygonEntity(QObject *parent)
    : Entity(Entity::Polygon)
{
}

void PolygonEntity::setPoints(const QVector<QPointF> &points)
{
    if (m_points == points) return;
    m_points = points;
    emit pointsChanged();
}

void PolygonEntity::setClosed(bool closed)
{
    if (m_closed == closed) return;
    m_closed = closed;
    emit closedChanged();
}

void PolygonEntity::setColor(const QString &color)
{
    if (m_color == color) return;
    m_color = color;
    emit colorChanged();
}

void PolygonEntity::setFillColor(const QString &fillColor)
{
    if (m_fillColor == fillColor) return;
    m_fillColor = fillColor;
    emit fillColorChanged();
}

void PolygonEntity::setLineWidth(int lineWidth)
{
    if (m_lineWidth == lineWidth) return;
    m_lineWidth = lineWidth;
    emit lineWidthChanged();
}
