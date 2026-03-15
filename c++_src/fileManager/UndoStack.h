#ifndef UNDOSTACK_H
#define UNDOSTACK_H

#include <QObject>
#include <QStack>
#include "command.h"

class UndoStack : public QObject
{
    Q_OBJECT

public:
    explicit UndoStack(QObject *parent = nullptr);

    void push(Command* cmd);

    void undo();
    void redo();

private:
    QStack<Command*> m_undoStack;
    QStack<Command*> m_redoStack;
};

#endif
