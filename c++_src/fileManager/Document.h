#ifndef DOCUMENT_H
#define DOCUMENT_H

#include <QObject>
#include "canvassettings.h"
#include "LayerManager.h"
#include "UndoStack.h"

class EntityManager;

class Document : public QObject
{
    Q_OBJECT

public:
    explicit Document(QObject *parent = nullptr);
    ~Document();

    CanvasSettings* canvasSettings();
    LayerManager* layerManager();
    UndoStack* undoStack();
    EntityManager* entityManager();

private:
    CanvasSettings* m_canvasSettings;
    LayerManager* m_layerManager;
    UndoStack* m_undoStack;
    EntityManager* m_entityManager;
};

#endif
