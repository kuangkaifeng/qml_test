#ifndef DATAHANDLER_H
#define DATAHANDLER_H
#include <QObject>

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

class DataHandler:public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit DataHandler(QObject * parent=nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role) const override;

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<LayerData> m_data;
};

#endif // DATAHANDLER_H
