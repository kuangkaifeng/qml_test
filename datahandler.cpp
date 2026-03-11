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
    // 初始化数据
    m_data.append({1, "上层", "自动", "100%", true, false});
    m_data.append({2, "中层", "手动", "80%", true, false});
    m_data.append({3, "下层", "自动", "12%", true, false});
    m_data.append({4, "下层", "自动", "11%", true, false});
    m_data.append({5, "下层", "自动", "11%", true, false});
    m_data.append({6, "下层", "自动", "11%", true, false});
    m_data.append({7, "下层", "自动", "23%", true, true});
    m_data.append({8, "下层", "自动", "34%", true, true});
    m_data.append({9, "下层", "自动", "60%", true, true});
    m_data.append({10, "下层", "自动", "99%", true, true});
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
    if (!index.isValid() || index.row() >= m_data.size())
        return QVariant();

    const LayerData &item = m_data[index.row()];

    switch (role)
    {
    case IdRole: return item.id;
    case LayerRole: return item.layer;
    case ModeRole: return item.mode;
    case SpeedRole: return item.speed;
    case OutputRole: return item.output;
    case VisibleRole: return item.visible;
    default: return QVariant();
    }
}

bool DataHandler::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid() || index.row() >= m_data.size())
        return false;

    LayerData &item = m_data[index.row()];
    bool changed = false;

    switch (role)
    {
    case IdRole:
        // ID 通常不允许修改，可以根据需求决定
        // item.id = value.toInt();
        // changed = true;
        return false;  // 禁止修改ID
    case LayerRole:
        item.layer = value.toString();
        changed = true;
        break;
    case ModeRole:
        item.mode = value.toString();
        changed = true;
        break;
    case SpeedRole:
        item.speed = value.toString();
        changed = true;
        break;
    case OutputRole:
        item.output = value.toBool();
        changed = true;
        break;
    case VisibleRole:
        item.visible = value.toBool();
        changed = true;
        break;
    default:
        return false;
    }

    if (changed) {
        emit dataChanged(index, index, {role});
        return true;
    }
    return false;
}

Qt::ItemFlags DataHandler::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    // 允许选择和编辑
    return Qt::ItemIsEnabled | Qt::ItemIsSelectable | Qt::ItemIsEditable;
}

QHash<int, QByteArray> DataHandler::roleNames() const
{
    return {
        {IdRole, "id"},
        {LayerRole, "layer"},
        {ModeRole, "mode"},
        {SpeedRole, "speed"},
        {OutputRole, "output"},
        {VisibleRole, "visible"}
    };
}
