#include "document.h"
#include "../entityProject/EntityManager.h"

Document::Document(QObject *parent)
    : QObject(parent)
{
    m_canvasSettings = new CanvasSettings(this);
    m_layerManager = new LayerManager(this);
    m_undoStack = new UndoStack(this);
    //m_entityManager = new EntityManager(this);
}

Document::~Document()
{
}

CanvasSettings* Document::canvasSettings()
{
    return m_canvasSettings;
}

LayerManager* Document::layerManager()
{
    return m_layerManager;
}

UndoStack* Document::undoStack()
{
    return m_undoStack;
}

EntityManager* Document::entityManager()
{
    return m_entityManager;
}
