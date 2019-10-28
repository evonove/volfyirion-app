#include "downloader.h"

#include <QDebug>
#include <QImage>
#include <QStandardPaths>
#include <QFile>

#ifdef Q_OS_ANDROID
#include <QtAndroid>
#include <QtAndroidExtras>
#endif

Downloader::Downloader(QObject *parent) : QObject(parent) {
}

bool Downloader::checkAndRequiredWritePermission() {

#ifdef Q_OS_ANDROID
    // Retrive activity
    if(QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE") != QtAndroid::PermissionResult::Granted) {
        // Permission denied.
        QtAndroid::requestPermissionsSync(QStringList("android.permission.WRITE_EXTERNAL_STORAGE"));
    }

    return QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE") == QtAndroid::PermissionResult::Granted;
#endif

#ifdef Q_OS_IOS
    qCritical() << "Check permission to write in Photos. iOS.";
    bool res = m_photoSaver.checkWritingPermission();
    qCritical() << "res" << res;
    return res;
#endif

}

void Downloader::saveArtworkInPictures(QString urlImage) {

    if(checkAndRequiredWritePermission()) {
        qCritical() << "Downloader: check permission.";

        QImage img;
        // The resource path to retrive artwork image is ":/assets/artworks/big/{image_name}"
        QString internalPathImage = urlImage.remove(0,3);
        img.load(internalPathImage, "JPG");

        QByteArray arr;
        QBuffer buffer(&arr);
        buffer.open(QIODevice::WriteOnly);
        bool savingResult = img.save(&buffer, "JPG");
        qCritical() << "saving result" << savingResult;
        buffer.close();

#ifdef Q_OS_IOS
        m_photoSaver.saveImageInPhotos(img,internalPathImage);
#endif

        QString imageName = urlImage.remove(0, 21);
#ifdef Q_OS_ANDROID
        // Get the path of Pictures Directory and add the name of image to it.
        QString path = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation) + imageName;
        qCritical() << "path: " << path;

        QFile file(path);
        if(file.open(QIODevice::WriteOnly)) {
            bool resultWriting = file.write(buffer.buffer());
            qCritical() << "writing file: " << resultWriting;
            file.close();
        }

        if(file.error() != QFileDevice::NoError) {
            // Error during saving of image.
            auto messageError = QString("Error writing file '%1'").arg(path) + file.errorString();
            qCritical() << messageError;
#ifdef Q_OS_ANDROID
            showToast(messageError);
#endif
        } else {
            // Refresh images in Pictures.
            auto message = QString("Artwork saved in Pictures.");
            qCritical() << message;
#ifdef Q_OS_ANDROID

            QAndroidJniObject activity = QtAndroid::androidActivity();
            if(activity.isValid()){
                activity.callStaticMethod<void>("VolfyActivity", "scanFile", "(Ljava/lang/String;)V", QAndroidJniObject::fromString(path).object<jstring>());
            }

            // Image saved correctly in pictures.
            auto message = QString("Artwork saved in Pictures.");
            showToast(message);
#endif
        }
    } else {
        // Permission denied.
        auto messagePermission = QString("Impossible write image in Pictures. Permission denied.");
        qCritical() << messagePermission;
#ifdef Q_OS_ANDROID
        showToast(messagePermission);
#endif
#endif
    }
}


void Downloader::showToast(const QString &message) {
    qCritical() << "toast message: " << message;
#ifdef Q_OS_ANDROID
        int duration = 0;

        QtAndroid::runOnAndroidThread([message, duration] {
                QAndroidJniObject javaString = QAndroidJniObject::fromString(message);
                QAndroidJniObject toast = QAndroidJniObject::callStaticObjectMethod("android/widget/Toast", "makeText",
                                                                                    "(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;",
                                                                                    QtAndroid::androidActivity().object(),
                                                                                    javaString.object(),
                                                                                    jint(duration));
                toast.callMethod<void>("show");
        });
#endif
}
