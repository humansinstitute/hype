QT += core gui qml quick quickcontrols2 multimedia concurrent dbus widgets
# Like Qt's own modules, Hype never throws or catches. Without unwinding tables and with
# link-time optimization, the installed binary is about a quarter smaller.
CONFIG += c++17 release ltcg exceptions_off
TARGET = hype
TEMPLATE = app
VERSION = 0.4.1
QMAKE_TARGET_BUNDLE_PREFIX = com.humansinstitute
QMAKE_MACOSX_DEPLOYMENT_TARGET = 15.0
macx: QMAKE_INFO_PLIST = $$PWD/pkgbuild/Info.plist
macx: ICON = $$PWD/pkgbuild/hype.icns
HEADERS += src/deck.h src/renderer.h
SOURCES += src/main.cpp src/deck.cpp src/renderer.cpp
RESOURCES += src/resources.qrc

SOURCES += src/syntax.cpp
HEADERS += src/syntax.h
SOURCES += src/pptx.cpp
HEADERS += src/pptx.h
LIBS += -lz -lwebpdemux -lwebp

macx {
    WEBP_PREFIX = $$system(brew --prefix webp 2>/dev/null)
    !isEmpty(WEBP_PREFIX) {
        INCLUDEPATH += $$WEBP_PREFIX/include
        LIBS += -L$$WEBP_PREFIX/lib
    }
}

SOURCES += src/animationexport.cpp
HEADERS += src/animationexport.h

SOURCES += src/apptheme.cpp
HEADERS += src/apptheme.h
SOURCES += src/images.cpp
HEADERS += src/images.h
SOURCES += src/filedialog.cpp
HEADERS += src/filedialog.h
SOURCES += src/recovery.cpp
SOURCES += src/cli.cpp
HEADERS += src/cli.h
