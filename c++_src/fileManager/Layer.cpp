#include "Layer.h"

Layer::Layer(QObject *parent)
    : QObject(parent),
    m_visible(true)
{
}

void Layer::setName(const QString &name)
{
    m_name = name;
}

QString Layer::name() const
{
    return m_name;
}

void Layer::setVisible(bool visible)
{
    m_visible = visible;
}

bool Layer::visible() const
{
    return m_visible;
}
