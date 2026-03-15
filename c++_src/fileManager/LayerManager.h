#ifndef LAYERMANAGER_H
#define LAYERMANAGER_H

#include <QObject>
#include <QList>
#include "Layer.h"

class LayerManager : public QObject
{
    Q_OBJECT

public:
    explicit LayerManager(QObject *parent = nullptr);

    Layer* addLayer(const QString &name);
    void removeLayer(Layer* layer);

    QList<Layer*> layers() const;

private:
    QList<Layer*> m_layers;
};

#endif
