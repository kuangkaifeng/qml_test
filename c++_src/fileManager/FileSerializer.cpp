#include "FileSerializer.h"
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>

bool FileSerializer::save(Document *doc, const QString &path)
{
    QFile file(path);

    if(!file.open(QIODevice::WriteOnly))
        return false;

    QJsonObject obj;

    obj["width"] = doc->canvasSettings()->width();
    obj["height"] = doc->canvasSettings()->height();

    QJsonDocument json(obj);

    file.write(json.toJson());

    return true;
}

Document* FileSerializer::load(const QString &path)
{
    QFile file(path);

    if(!file.open(QIODevice::ReadOnly))
        return nullptr;

    QByteArray data = file.readAll();

    QJsonDocument json = QJsonDocument::fromJson(data);

    Document* doc = new Document();

    doc->canvasSettings()->setWidth(
        json.object()["width"].toDouble());

    doc->canvasSettings()->setHeight(
        json.object()["height"].toDouble());

    return doc;
}
