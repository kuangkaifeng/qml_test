#include "datahandler.h"
#include <qvariant.h>



DataHandler::DataHandler(QObject *parent)
{

}

void DataHandler::setTableData(const QList<QVariantList> tableData)
{
    if(m_tableData!=tableData)
    {
        m_tableData=tableData;
        emit tableDataChanged();
    }
}

QList<QVariantList> DataHandler::tableData()
{
    return m_tableData;
}
