//=============================================================================
// Copyright (c) 2016-present Allan CORNET (Nelson)
//=============================================================================
// This file is part of the Nelson.
//=============================================================================
// LICENCE_BLOCK_BEGIN
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// Alternatively, you can redistribute it and/or
// modify it under the terms of the GNU General Public License as
// published by the Free Software Foundation; either version 2 of
// the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this program. If not, see <http://www.gnu.org/licenses/>.
// LICENCE_BLOCK_END
//=============================================================================
#include "DispQmlHandleObject.hpp"
#include "Error.hpp"
#include "HandleManager.hpp"
#include "QStringConverter.hpp"
#include "QmlHandleObject.hpp"
#include "characters_encoding.hpp"
#include "fieldnamesQmlHandleObject.hpp"
#include <QtCore/QBitArray>
#include <QtCore/QDateTime>
#include <QtCore/QLine>
#include <QtCore/QLineF>
#include <QtCore/QRect>
#include <QtCore/QStringList>
#include <QtCore/QUrl>
#include <QtCore/QUuid>
#include <QtGui/QColor>
#include <QtGui/QMatrix4x4>
#include <QtGui/QMatrix>
#include <QtGui/QQuaternion>
#include <QtGui/QTransform>
#include <QtGui/QVector2D>
#include <QtQml/QQmlComponent>
//=============================================================================
namespace Nelson {
//=============================================================================
static void
dispParent(QObject* qobj, std::wstring& msg)
{
    QObject* parent = qobj->parent();
    std::wstring line;
    if (parent) {
        line = L"\t" + utf8_to_wstring(QOBJECT_PROPERTY_PARENT_STR) + L": " + L"handle" + L"\n";
    }
    msg = msg + line;
}
//=============================================================================
static void
dispChildren(QObject* qobj, std::wstring& msg)
{
    QObjectList childs = qobj->children();
    int s = childs.size();
    std::wstring line;
    if (s > 0) {
        line = L"\t" + utf8_to_wstring(QOBJECT_PROPERTY_CHILDREN_STR) + L": " + L"handle 1x"
            + std::to_wstring(s) + L"\n";
        msg = msg + line;
    }
}
//=============================================================================
static void
dispQRect(const QRect& qrect, const std::wstring& fieldname, std::wstring& msg)
{
    int x = qrect.x();
    int y = qrect.y();
    int w = qrect.width();
    int h = qrect.height();
    std::wstring wstr = L"x:" + std::to_wstring(x) + L" " + L"y:" + std::to_wstring(y) + L" "
        + L"w:" + std::to_wstring(w) + L" " + L"h:" + std::to_wstring(h);
    msg = msg + L"\t" + fieldname + L": " + wstr + L"\n";
}
//=============================================================================
static void
dispQRectF(const QRectF& qrectf, const std::wstring& fieldname, std::wstring& msg)
{
    double x = qrectf.x();
    double y = qrectf.y();
    double w = qrectf.width();
    double h = qrectf.height();
    double intpart;
    std::wstring wstr;
    std::wstring wstr_x;
    std::wstring wstr_y;
    std::wstring wstr_w;
    std::wstring wstr_h;
    if (std::modf(x, &intpart) == 0.0) {
        wstr_x = std::to_wstring(int(x));
    } else {
        wstr_x = std::to_wstring(x);
    }
    if (std::modf(y, &intpart) == 0.0) {
        wstr_y = std::to_wstring(int(y));
    } else {
        wstr_y = std::to_wstring(y);
    }
    if (std::modf(w, &intpart) == 0.0) {
        wstr_w = std::to_wstring(int(w));
    } else {
        wstr_w = std::to_wstring(w);
    }
    if (std::modf(h, &intpart) == 0.0) {
        wstr_h = std::to_wstring(int(h));
    } else {
        wstr_h = std::to_wstring(h);
    }
    wstr = L"x:" + wstr_x + L" " + L"y:" + wstr_y + L" " + L"w:" + wstr_w + L" " + L"h:" + wstr_h;
    msg = msg + L"\t" + fieldname + L": " + L"QRectF" + L" " + wstr + L"\n";
}
//=============================================================================
static void
dispQPoint(QPoint qpoint, const std::wstring& fieldname, std::wstring& msg)
{
    int x = qpoint.x();
    int y = qpoint.y();
    std::wstring wstr = L"x:" + std::to_wstring(x) + L" " + L"y:" + std::to_wstring(y);
    msg = msg + L"\t" + fieldname + L": " + wstr + L"\n";
}
//=============================================================================
static void
dispQPointF(const QPointF& qpointf, const std::wstring& fieldname, std::wstring& msg)
{
    double x = qpointf.x();
    double y = qpointf.y();
    double intpart;
    std::wstring wstr;
    if (std::modf(x, &intpart) == 0.0 && std::modf(y, &intpart) == 0.0) {
        wstr = L"x:" + std::to_wstring(int(x)) + L" " + L"y:" + std::to_wstring(int(y));
    } else {
        wstr = L"x:" + std::to_wstring(x) + L" " + L"y:" + std::to_wstring(y);
    }
    msg = msg + L"\t" + fieldname + L": " + L"QRectF" + L" " + wstr + L"\n";
}
//=============================================================================
static void
dispQColor(const QColor& qcolor, const std::wstring& fieldname, std::wstring& msg)
{
    int r = qcolor.red();
    int g = qcolor.green();
    int b = qcolor.blue();
    int a = qcolor.alpha();
    std::wstring wstr = L"r:" + std::to_wstring(r) + L" " + L"g:" + std::to_wstring(g) + L" "
        + L"b:" + std::to_wstring(b) + L" " + L"a:" + std::to_wstring(a);
    msg = msg + L"\t" + fieldname + L": " + L"QColor" + L" " + wstr + L"\n";
}
//=============================================================================
static void
DispQmlHandleObject(Interface* io, QmlHandleObject* qmlHandle)
{
    if (qmlHandle != nullptr) {
        wstringVector wfieldnames;
        fieldnamesQmlHandleObject(qmlHandle, false, wfieldnames);
        QObject* qobj = (QObject*)qmlHandle->getPointer();
        if (qobj) {
            std::wstring msg;
            for (std::wstring wfieldname : wfieldnames) {
                if (wfieldname == utf8_to_wstring(QOBJECT_PROPERTY_PARENT_STR)) {
                    dispParent(qobj, msg);
                } else if (wfieldname == utf8_to_wstring(QOBJECT_PROPERTY_CHILDREN_STR)) {
                    dispChildren(qobj, msg);
                } else if (wfieldname == utf8_to_wstring(QOBJECT_PROPERTY_CLASSNAME_STR)) {
                    std::string name = qobj->metaObject()->className();
                    msg = msg + L"\t" + wfieldname + L": " + utf8_to_wstring(name) + L"\n";
                } else {
                    QVariant propertyValue = qobj->property(wstring_to_utf8(wfieldname).c_str());
                    if (propertyValue.isValid()) {
                        QMetaType metaType = QMetaType(propertyValue.type());
                        switch (metaType.id()) {
                        case QMetaType::Type::QRect: {
                            QRect qrect = propertyValue.toRect();
                            dispQRect(qrect, wfieldname, msg);
                        } break;
                        case QMetaType::Type::QRectF: {
                            QRectF qrect = propertyValue.toRectF();
                            dispQRectF(qrect, wfieldname, msg);
                        } break;
                        case QMetaType::Type::QPoint: {
                            QPoint qpoint = propertyValue.toPoint();
                            dispQPoint(qpoint, wfieldname, msg);
                        } break;
                        case QMetaType::Type::QPointF: {
                            QPointF qpointf = propertyValue.toPointF();
                            dispQPointF(qpointf, wfieldname, msg);
                        } break;
                        case QMetaType::Type::QColor: {
                            QColor qcolor = qvariant_cast<QColor>(propertyValue);
                            dispQColor(qcolor, wfieldname, msg);
                        } break;
                        case QMetaType::Type::Bool:
                        case QMetaType::Type::Int:
                        case QMetaType::Type::UInt:
                        case QMetaType::Type::LongLong:
                        case QMetaType::Type::ULongLong:
                        case QMetaType::Type::Double:
                        case QMetaType::Type::Char:
                        case QMetaType::Type::QString:
                        case QMetaType::Type::QStringList:
                        case QMetaType::Type::QByteArray:
                        case QMetaType::Type::QBitArray:
                        case QMetaType::Type::QDate:
                        case QMetaType::Type::QTime:
                        case QMetaType::Type::QDateTime:
                        case QMetaType::Type::QUrl:
                        case QMetaType::Type::QSize:
                        case QMetaType::Type::QSizeF:
                        case QMetaType::Type::QLine:
                        case QMetaType::Type::QLineF:
                        case QMetaType::Type::QUuid:
                        case QMetaType::Type::QMatrix:
                        case QMetaType::Type::QTransform:
                        case QMetaType::Type::QMatrix4x4:
                        case QMetaType::Type::QVector2D:
                        case QMetaType::Type::QVector3D:
                        case QMetaType::Type::QVector4D:
                        case QMetaType::Type::QQuaternion:
                        default: {
                            if (propertyValue.canConvert<QString>()) {
                                msg = msg + L"\t" + wfieldname + L": "
                                    + QStringTowstring(propertyValue.typeName()) + L" "
                                    + QStringTowstring(propertyValue.toString()) + L"\n";
                            } else {
                                msg = msg + L"\t" + wfieldname + L": "
                                    + QStringTowstring(propertyValue.typeName()) + L" " + L"handle"
                                    + L"\n";
                            }
                        } break;
                        }
                    }
                }
            }
            if (!msg.empty()) {
                io->outputMessage(msg);
            }
        }
        io->outputMessage("\n");
    }
}
//=============================================================================
void
DispQmlHandleObject(Evaluator* eval, ArrayOf A)
{
    if (eval != nullptr) {
        Interface* io = eval->getInterface();
        if (io) {
            if (A.isHandle()) {
                if (A.isScalar()) {
                    if (A.getHandleCategory() != QOBJECT_CATEGORY_STR) {
                        Error(_W("QObject handle expected."));
                    }
                    Dimensions dimsA = A.getDimensions();
                    io->outputMessage(L"[QObject] - size: ");
                    dimsA.printMe(io);
                    io->outputMessage("\n");
                    io->outputMessage("\n");
                    QmlHandleObject* qmlhandleobj = (QmlHandleObject*)A.getContentAsHandleScalar();
                    DispQmlHandleObject(io, qmlhandleobj);
                } else {
                    Dimensions dimsA = A.getDimensions();
                    io->outputMessage(L"[QObject] - size: ");
                    dimsA.printMe(io);
                    io->outputMessage("\n");
                }
            } else {
                Error(_W("QObject handle expected."));
            }
        }
    }
}
//=============================================================================
}
//=============================================================================
