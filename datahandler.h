#ifndef DATAHANDLER_H
#define DATAHANDLER_H

#include <QAbstractTableModel>
#include <QVector>

struct LayerData
{
    int id;
    QString layer;
    QString mode;
    QString speed;
    bool output;
    bool visible;
};

class DataHandler : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit DataHandler(QObject *parent = nullptr);

    // 必须实现的纯虚函数
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    // 为使模型可写，需要重写以下函数
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<LayerData> m_data;
};

#endif // DATAHANDLER_H
