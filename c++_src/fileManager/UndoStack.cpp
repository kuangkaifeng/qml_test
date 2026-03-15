#include "UndoStack.h"

UndoStack::UndoStack(QObject *parent)
    : QObject(parent)
{
}

void UndoStack::push(Command *cmd)
{
    m_undoStack.push(cmd);
    m_redoStack.clear();
    cmd->redo();
}

void UndoStack::undo()
{
    if(m_undoStack.isEmpty())
        return;

    Command* cmd = m_undoStack.pop();
    cmd->undo();
    m_redoStack.push(cmd);
}

void UndoStack::redo()
{
    if(m_redoStack.isEmpty())
        return;

    Command* cmd = m_redoStack.pop();
    cmd->redo();
    m_undoStack.push(cmd);
}
