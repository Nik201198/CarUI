QT += qml charts quick \
    widgets
QT += quick gui core widgets
QT += quickcontrols2
QT += quick core serialport
CONFIG += c++11
CONFIG += static
CONFIG += qml quick
QT += virtualkeyboard
CONFIG += disable-desktop
static {
    QT += svg
    QTPLUGIN += qtvirtualkeyboardplugin
}
# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

#disable-xcb {
#    message("The disable-xcb option has been deprecated. Please use disable-desktop instead.")
#    CONFIG += disable-desktop
#}

#disable-desktop|android-embedded|!isEmpty(CROSS_COMPILE)|qnx {
#    DEFINES += MAIN_QML =\\\"main.qml\\\"
#}else{
#    DEFINES += MAIN_QML =\\\"main.qml\\\"
#}


# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
        read.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =


# Default rules for deployment.

HEADERS += \
    read.h

target.path += \
    $$[QT_INSTALL_PLUGINS]/qt5pi/platforminputcontext \
    $$[QT_INSTALL_PLUGINS]/qt5pi/plugins/virtualkeyboard \
    $$[QT_INSTALL_QML]/qt5pi/qml/QtQuick/VirtualKeyboard \
    $$[QT_INSTALL_QML]/qt5pi/qml/QtQuick/VirtualKeyboard/Styles
INSTALLS += target

