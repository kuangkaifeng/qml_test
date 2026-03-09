#include "datahandler.h"

enum Roles
{
    IdRole = Qt::UserRole + 1,
    LayerRole,
    ModeRole,
    SpeedRole,
    OutputRole,
    VisibleRole
};

DataHandler::DataHandler(QObject *parent)
    : QAbstractTableModel(parent)
{
    m_data.append({1,"上层","自动","1000 rpm",true,false});
    m_data.append({2,"中层","手动","800 rpm",true,true});
    m_data.append({3,"下层","自动","1200 rpm",true,true});
    m_data.append({3,"下层","自动","1200 rpm",true,true});
    m_data.append({3,"下层","自动","1200 rpm",true,true});
    m_data.append({3,"下层","自动","1200 rpm",true,true});
    m_data.append({3,"下层","自动","1200 rpm",true,true});
    m_data.append({3,"下层","自动","1200 rpm",true,true});
    m_data.append({3,"下层","自动","1200 rpm",true,true});
    m_data.append({3,"下层","自动","1200 rpm",true,true});
}

int DataHandler::rowCount(const QModelIndex &) const
{
    return m_data.size();
}

int DataHandler::columnCount(const QModelIndex &) const
{
    return 6;
}

QVariant DataHandler::data(const QModelIndex &index, int role) const
{
    const LayerData &item = m_data[index.row()];

    switch(role)
    {
    case IdRole: return item.id;
    case LayerRole: return item.layer;
    case ModeRole: return item.mode;
    case SpeedRole: return item.speed;
    case OutputRole: return item.output;
    case VisibleRole: return item.visible;
    }

    return QVariant();
}

QHash<int, QByteArray> DataHandler::roleNames() const
{
    return {
        {IdRole,"id"},
        {LayerRole,"layer"},
        {ModeRole,"mode"},
        {SpeedRole,"speed"},
        {OutputRole,"output"},
        {VisibleRole,"visible"}
    };
}
