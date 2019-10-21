TARGET = volfyirion

QT += quick svg gui-private multimedia
CONFIG += c++11 resources_big

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        downloader.cpp \
        main.cpp \
        system.cpp \
        models/pointsmodel.cpp \
        vibrator.cpp

HEADERS += \
    downloader.h \
    system.h \
    models/pointsmodel.h \
    vibrator.h

OTHER_FILES += \
    $$files($$PWD/*.qml, true)

RESOURCES += qml.qrc \
             artworks.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $${PWD}/style

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

android {
    QT += androidextras

    # To upgrade the version change the following variable
    VERSION = 1.3.0

    OTHER_FILES += \
        $$files($$PWD/android/*, true)

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

    # This is needed to automate version code increment for 54bit builds
    # Reference: https://blog.qt.io/blog/2019/06/28/comply-upcoming-requirements-google-play/
    defineReplace(droidVersionCode) {
        segments = $$split(1, ".")
        for (segment, segments): vCode = "$$first(vCode)$$format_number($$segment, width=3 zeropad)"

        contains(ANDROID_TARGET_ARCH, arm64-v8a): \
            suffix = 1
        else:contains(ANDROID_TARGET_ARCH, armeabi-v7a): \
            suffix = 0
        # add more cases as needed

        return($$first(vCode)$$first(suffix))
    }

    ANDROID_VERSION_NAME = $$VERSION
    ANDROID_VERSION_CODE = $$droidVersionCode($$ANDROID_VERSION_NAME)
}

ios {
    # To upgrade the version change the following variable
    # For iOS the value of ShortVersionString must contain a higher version
    # than that of the previosly approved version.
    VERSION = 1.3.0

    QMAKE_TARGET_BUNDLE_PREFIX = it.evonove
    QMAKE_BUNDLE = volfyirion

    OBJECTIVE_SOURCES += ios/service/vibratorservice.mm
    OBJECTIVE_HEADERS += ios/service/vibratorservice.h

    QMAKE_INFO_PLIST = $${PWD}/ios/Info.plist

    OTHER_FILES += \
        $$files($$PWD/ios/*, true)

    QMAKE_ASSET_CATALOGS = $${PWD}/ios/Images.xcassets
    QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"

    app_launch_images.files = $$PWD/ios/LaunchScreen.storyboard
    QMAKE_BUNDLE_DATA += app_launch_images
}
