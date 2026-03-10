#ifndef DATAHANDLER_H
#define DATAHANDLER_H
#include <QObject>
#include <QQmlListProperty>
#include <QList>

class DataHandler:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QVariantList> tableData READ tableData WRITE setTableData NOTIFY tableDataChanged FINAL)
public:
    explicit DataHandler(QObject * parent=nullptr);
    /**
     * @brief setTableData 设置表格数据
     * @param tableData     需要设置的数据
     */
    void setTableData(const QList<QVariantList> tableData);
    /**
     * @brief tableData 获取表格数据
     * @return  返回 QList<QVariant>
     */
    QList<QVariantList> tableData();
signals:
    /**
     * @brief tableDataChanged 表格数据发生变化触发信号
     */
    void tableDataChanged();
private:
    QList<QVariantList> m_tableData;                //存储表格数据
};

#endif // DATAHANDLER_H
