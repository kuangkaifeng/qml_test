#ifndef DOCUMENTMANAGER_H
#define DOCUMENTMANAGER_H

#include <QObject>
#include "Document.h"

class DocumentManager : public QObject
{
    Q_OBJECT

public:
    explicit DocumentManager(QObject *parent = nullptr);

    Document* currentDocument();

    Q_INVOKABLE void newDocument();
    Q_INVOKABLE void closeDocument();
    /**
     * @brief saveDocument
     */
    Q_INVOKABLE void saveDocument();
    /**
     * @brief setCanvasset
     * @param size
     */
    Q_INVOKABLE void setCanvasset(QSize size);


signals:
    void documentChanged();

private:
    Document* m_currentDocument;
};

#endif
