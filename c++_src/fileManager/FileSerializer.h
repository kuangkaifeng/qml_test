#ifndef FILESERIALIZER_H
#define FILESERIALIZER_H

#include <QObject>
#include "Document.h"

class FileSerializer
{
public:
    static bool save(Document* doc,const QString& path);
    static Document* load(const QString& path);
};

#endif
