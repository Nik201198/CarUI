#include <QtWidgets/QApplication>
#include <QtQuick/QQuickView>
#include <QtCore/QDir>
#include <QtQml/QQmlEngine>

#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QObject>
#include <QtQuick/QQuickItem>
#include <QQuickItem>
#include <QQuickStyle>
#include <QQuickView>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include "read.h"



int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    qputenv("QT_QUICK_CONTROLS_1_STYLE", "Flat");
    QApplication app(argc, argv);
    app.setOverrideCursor(QCursor(Qt::BlankCursor));
    read val;
    QQmlApplicationEngine engine;
//    QQuickStyle::setStyle("material");
    engine.rootContext()->setContextProperty("serial_data", &val);
    QObject::connect(&engine, &QQmlApplicationEngine::quit, &app, &QApplication::quit);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
      return -1;
    return app.exec();
}
