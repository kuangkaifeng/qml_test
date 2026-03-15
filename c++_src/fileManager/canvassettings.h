#ifndef CANVASSETTINGS_H
#define CANVASSETTINGS_H

#include <QObject>

class CanvasSettings : public QObject
{
    Q_OBJECT

public:
    explicit CanvasSettings(QObject *parent = nullptr);

    void setWidth(double w);
    void setHeight(double h);

    double width() const;
    double height() const;

private:
    double m_width;
    double m_height;
};

#endif
