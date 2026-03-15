#ifndef LAYER_H
#define LAYER_H

#include <QObject>

class Layer : public QObject
{
    Q_OBJECT

public:
    explicit Layer(QObject *parent = nullptr);

    void setName(const QString &name);
    QString name() const;

    void setVisible(bool visible);
    bool visible() const;

private:
    QString m_name;
    bool m_visible;
};

#endif
