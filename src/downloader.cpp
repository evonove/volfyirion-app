#include "downloader.h"

#include <QDebug>
#include <QImage>
#include <QStandardPaths>
#include <QFile>
#include <QtAndroid>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras>
#endif

Downloader::Downloader(QObject *parent) : QObject(parent) {

}

void Downloader::downloadArtwork(QString urlImage) {
    qDebug() << "downloadArtwork" << urlImage;

    QImage img;
    img.load(urlImage.remove(0,3), "JPG");

    qDebug() << "image is null" << img.isNull();

    QByteArray arr;
    QBuffer buffer(&arr);
    buffer.open(QIODevice::WriteOnly);
    bool savingResult = img.save(&buffer, "JPG");
    qDebug() << "saving result" << savingResult;
    buffer.close();

    QString imageName = urlImage.remove(0, 21);
    qDebug() << "imageName" << imageName;

#ifdef Q_OS_ANDROID
    // Retrive activity
    if(QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE") != QtAndroid::PermissionResult::Granted) {
        qDebug() << "permesso non garantito";
        QtAndroid::requestPermissionsSync(QStringList("android.permission.WRITE_EXTERNAL_STORAGE"));
    }

    QString path = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation) + imageName;
    qInfo() << "path" << path;
    saveArtwork(path, buffer);

#endif

}


void Downloader::saveArtwork(const QString &path, const QBuffer &buffer) {
    QFile file(path);
    if(file.open(QIODevice::WriteOnly)) {
        file.write(buffer.buffer());
        file.close();
    }

    if(file.error() != QFileDevice::NoError) {
        qDebug() << QString("Error writing file '%1'").arg(path) << file.errorString();
    } else {
        qDebug() << "Image downloaded in Pictures.";
    }
}
