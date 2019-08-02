TARGET = volfyirion

QT += quick svg gui-private multimedia
CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
        system.cpp \
        ui/GameViews/PointsCounter/Models/pointsmodel.cpp

HEADERS += \
    system.h \
    ui/GameViews/PointsCounter/Models/pointsmodel.h

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $${PWD}/style

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# To upgrade the version change the following variable
VERSION = 1.0.3

android {
    QT += androidextras

    OTHER_FILES += \
        $$PWD/android/src/it/evonove/qt5/* \
        $$PWD/android/AndroidManifest.xml \
        $$PWD/android/build.gradle \
        $$PWD/android/gradle/wrapper/gradle-wrapper.jar \
        $$PWD/android/gradle/wrapper/gradle-wrapper.properties \
        $$PWD/android/gradlew \
        $$PWD/android/gradlew.bat \
        $$PWD/android/res/values/* \
        $$PWD/android/res/values-v21/* \
        $$PWD/android/res/mipmap-hdpi/* \
        $$PWD/android/res/mipmap-mdpi/* \
        $$PWD/android/res/mipmap-xhdpi/* \
        $$PWD/android/res/mipmap-xxhdpi/* \
        $$PWD/android/res/mipmap-xxxhdpi/* \
        $$PWD/android/res/drawable/*

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
    QMAKE_TARGET_BUNDLE_PREFIX = it.evonove
    QMAKE_BUNDLE = volfyirion

    QMAKE_INFO_PLIST = $${PWD}/ios/Info.plist

    OTHER_FILES += \
        $$PWD/ios/Images.xcassets/AppIcon.appiconset/* \
        $$PWD/ios/Images.xcassets/LaunchImage.launchimage/*

    QMAKE_ASSET_CATALOGS = $${PWD}/ios/Images.xcassets
    QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"
    QMAKE_ASSET_CATALOGS_LAUNCH_IMAGE = "LaunchImage"
}
