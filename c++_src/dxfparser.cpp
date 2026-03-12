#include "dxfparser.h"
#include <QJsonObject>
#include <QJsonArray>
#include <QFile>
#include <QDebug>
#include <fstream>
#include <QMessageBox>

DxfParser::DxfParser(QObject *parent) : QObject(parent)
{
}

void DxfParser::clear()
{
    m_entities = QJsonArray();
}

void DxfParser::loadFile(const QString &filePath)
{
    clear();
    qDebug() << "开始解析 DXF 文件:" << filePath;

    std::ifstream ifs(filePath.toLocal8Bit().toStdString(), std::ios::binary);
    if (!ifs) {
        qWarning() << "无法打开文件:" << filePath;
        emit parseFinished(m_entities);
        return;
    }

    dxfRW dxf(filePath.toLocal8Bit().toStdString().c_str());
    bool success = dxf.read(this, false);  // false = 不应用 extrusion 转换
    ifs.close();

    if (success) {
        qDebug() << "DXF 解析成功，实体数量:" << m_entities.size();
    } else {
        qWarning() << "DXF 解析失败";
    }

    emit parseFinished(m_entities);
}

// --------------------- 以下是 DRW_Interface 纯虚函数的实现 ---------------------
// 大部分函数仅用于收集图形数据，其他可以留空或打印调试信息

void DxfParser::addHeader(const DRW_Header* /*data*/)
{
    // 可忽略
}

void DxfParser::addLType(const DRW_LType& /*data*/) {}
void DxfParser::addLayer(const DRW_Layer& /*data*/) {}
void DxfParser::addDimStyle(const DRW_Dimstyle& /*data*/) {}
void DxfParser::addVport(const DRW_Vport& /*data*/) {}
void DxfParser::addTextStyle(const DRW_Textstyle& /*data*/) {}
void DxfParser::addAppId(const DRW_AppId& /*data*/) {}

void DxfParser::addBlock(const DRW_Block& /*data*/) {}
void DxfParser::setBlock(int /*handle*/) {}
void DxfParser::endBlock() {}

void DxfParser::addPoint(const DRW_Point& /*data*/)
{
    // 可收集点数据，如果需要
}

void DxfParser::addLine(const DRW_Line& data)
{
    QJsonObject obj;
    obj["type"] = "line";
    obj["x1"] = data.basePoint.x;
    obj["y1"] = data.basePoint.y;
    obj["x2"] = data.secPoint.x;
    obj["y2"] = data.secPoint.y;
    m_entities.append(obj);
}

void DxfParser::addRay(const DRW_Ray& /*data*/) {}
void DxfParser::addXline(const DRW_Xline& /*data*/) {}

void DxfParser::addArc(const DRW_Arc& data)
{
    QJsonObject obj;
    obj["type"] = "arc";
    obj["cx"] = data.basePoint.x;
    obj["cy"] = data.basePoint.y;
    obj["r"] = data.radious;
    obj["startAngle"] = data.staangle;   // 弧度
    obj["endAngle"] = data.endangle;
    m_entities.append(obj);
}

void DxfParser::addCircle(const DRW_Circle& data)
{
    QJsonObject obj;
    obj["type"] = "circle";
    obj["cx"] = data.basePoint.x;
    obj["cy"] = data.basePoint.y;
    obj["r"] = data.radious;
    m_entities.append(obj);
}

void DxfParser::addEllipse(const DRW_Ellipse& /*data*/)
{
    // 可添加椭圆支持
}

void DxfParser::addLWPolyline(const DRW_LWPolyline& data)
{
    QJsonObject obj;
    obj["type"] = "lwpolyline";
    QJsonArray points;
    for (const auto& v : data.vertlist) {
        QJsonObject pt;
        pt["x"] = v->x;
        pt["y"] = v->y;
        points.append(pt);
    }
    obj["points"] = points;
    obj["closed"] = (data.flags & 1) != 0;   // 闭合标志
    m_entities.append(obj);
}

void DxfParser::addPolyline(const DRW_Polyline& /*data*/) {}
void DxfParser::addSpline(const DRW_Spline* /*data*/) {}
void DxfParser::addKnot(const DRW_Entity& /*data*/) {}
void DxfParser::addInsert(const DRW_Insert& /*data*/) {}
void DxfParser::addTrace(const DRW_Trace& /*data*/) {}
void DxfParser::add3dFace(const DRW_3Dface& /*data*/) {}
void DxfParser::addSolid(const DRW_Solid& /*data*/) {}
void DxfParser::addMText(const DRW_MText& /*data*/) {}
void DxfParser::addText(const DRW_Text& /*data*/) {}

void DxfParser::addDimAlign(const DRW_DimAligned* /*data*/) {}
void DxfParser::addDimLinear(const DRW_DimLinear* /*data*/) {}
void DxfParser::addDimRadial(const DRW_DimRadial* /*data*/) {}
void DxfParser::addDimDiametric(const DRW_DimDiametric* /*data*/) {}
void DxfParser::addDimAngular(const DRW_DimAngular* /*data*/) {}
void DxfParser::addDimAngular3P(const DRW_DimAngular3p* /*data*/) {}
void DxfParser::addDimOrdinate(const DRW_DimOrdinate* /*data*/) {}

void DxfParser::addLeader(const DRW_Leader* /*data*/) {}
void DxfParser::addHatch(const DRW_Hatch* /*data*/) {}
void DxfParser::addViewport(const DRW_Viewport& /*data*/) {}
void DxfParser::addImage(const DRW_Image* /*data*/) {}
void DxfParser::linkImage(const DRW_ImageDef* /*data*/) {}
void DxfParser::addComment(const char* /*comment*/) {}
void DxfParser::addPlotSettings(const DRW_PlotSettings* /*data*/) {}

// Write 函数全部留空（我们只读不写）
void DxfParser::writeHeader(DRW_Header& /*data*/) {}
void DxfParser::writeBlocks() {}
void DxfParser::writeBlockRecords() {}
void DxfParser::writeEntities() {}
void DxfParser::writeLTypes() {}
void DxfParser::writeLayers() {}
void DxfParser::writeTextstyles() {}
void DxfParser::writeVports() {}
void DxfParser::writeDimstyles() {}
void DxfParser::writeObjects() {}
void DxfParser::writeAppId() {}

void DxfParser::onDrogError(QString eventType, QString context)
{
    QMessageBox::warning(nullptr,"警告",context,QMessageBox::Ok);
}
