#include "LayerManager.h"

LayerManager::LayerManager(QObject *parent)
    : QObject(parent)
{
}

Layer* LayerManager::addLayer(const QString &name)
{
    Layer* layer = new Layer(this);
    layer->setName(name);
    m_layers.append(layer);
    return layer;
}

void LayerManager::removeLayer(Layer *layer)
{
    m_layers.removeAll(layer);
    delete layer;
}

QList<Layer*> LayerManager::layers() const
{
    return m_layers;
}
