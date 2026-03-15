#ifndef LINEENTITY_H
#define LINEENTITY_H

#include "Entity.h"
#include <QDebug>
#include <windows.h>
#include <dbghelp.h>
#include <QDebug>
#pragma comment(lib,"dbghelp.lib")
/*
 * 直线图元
 */
class LineEntity : public Entity
{
    Q_OBJECT
public:

    void printStack()
    {
        void* stack[64];
        unsigned short frames;

        frames = CaptureStackBackTrace(0, 64, stack, NULL);

        HANDLE process = GetCurrentProcess();

        SYMBOL_INFO* symbol =
            (SYMBOL_INFO*)calloc(sizeof(SYMBOL_INFO) + 256 * sizeof(char),1);

        symbol->MaxNameLen = 255;
        symbol->SizeOfStruct = sizeof(SYMBOL_INFO);

        SymInitialize(process, NULL, TRUE);

        qDebug() << "====== Call Stack ======";

        for(int i = 0; i < frames; i++)
        {
            SymFromAddr(process,(DWORD64)(stack[i]),0,symbol);

            qDebug() << i << ":" << symbol->Name;
        }

        qDebug() << "========================";

        free(symbol);
    }
    LineEntity();

    ~LineEntity(){

        printStack();
        qDebug() << "Entity::~Entity() destroyed:" << static_cast<void*>(this) << "type=" << m_type;


    }

    double x1; // 起点X
    double y1; // 起点Y

    double x2; // 终点X
    double y2; // 终点Y
    /*
     * 返回图元类型
     */
    Entity::Type type() const override;

    /*
     * 返回直线的包围盒
     */
    QRectF boundingRect() const override;

    QString color="black";

    bool hitTest(double x,double y)const override;

    void move(double dx,double dy) override;

};

#endif
