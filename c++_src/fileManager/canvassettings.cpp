#include "canvassettings.h"

CanvasSettings::CanvasSettings(QObject *parent)
    : QObject(parent),
    m_width(500),
    m_height(500)
{
}

void CanvasSettings::setWidth(double w)
{
    m_width = w;
}

void CanvasSettings::setHeight(double h)
{
    m_height = h;
}

double CanvasSettings::width() const
{
    return m_width;
}

double CanvasSettings::height() const
{
    return m_height;
}
