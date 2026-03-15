#include "DocumentManager.h"
#include <QFileDialog>
#include <QApplication>
#include <QJsonObject>
#include <QMessageBox>

DocumentManager::DocumentManager(QObject *parent)
    : QObject(parent),
    m_currentDocument(nullptr)
{
}

Document* DocumentManager::currentDocument()
{
    return m_currentDocument;
}

void DocumentManager::newDocument()
{

    if(m_currentDocument)
        delete m_currentDocument;


    m_currentDocument = new Document(this);

    emit documentChanged();
}

void DocumentManager::closeDocument()
{
    if(m_currentDocument)
    {
        delete m_currentDocument;
        m_currentDocument = nullptr;
        emit documentChanged();
    }
}

void DocumentManager::saveDocument()
{
    QString path=QFileDialog::getSaveFileName(nullptr,tr("Save file"),QApplication::applicationDirPath(),
                                                "*txt *.c");
    if(!path.isEmpty())
    {
        QFileInfo info(path);
        QString suffix = info.suffix();

        if(suffix.isEmpty())
        {
            // 没写后缀，默认用第一个过滤器
            suffix = "txt";
            path += "." + suffix;
        }

        qDebug() << "保存路径:" << path << ", 后缀:" << suffix;
    }
    QFile file(path);

    if(!file.open(QIODevice::WriteOnly))
        return ;

    QJsonObject obj;

    obj["width"] = m_currentDocument->canvasSettings()->width();
    obj["height"] = m_currentDocument->canvasSettings()->height();

    QJsonDocument json(obj);

    file.write(json.toJson());

    QMessageBox::information(nullptr,tr("提示"),tr("保存文件成功"),QMessageBox::Ok);
}

void DocumentManager::setCanvasset(QSize size)
{
    m_currentDocument->canvasSettings()->setHeight(size.height());
    m_currentDocument->canvasSettings()->setWidth(size.width());
}
