#include "downloader.h"

#include <QDebug>
#include <QBuffer>
#include <QImage>
#include <QStandardPaths>
#include <QFile>

Downloader::Downloader(QObject *parent) : QObject(parent) {

}

void Downloader::downloadArtwork(QString urlImage) {
    qDebug() << "downloadArtwork" << urlImage;

    QString imageName = urlImage.remove(0, 24);
    qDebug() << "imageName" << imageName;

    QImage img;

    QBuffer buffer;
    buffer.open(QIODevice::WriteOnly);
    img.save(&buffer, "JPG");
    buffer.close();

    QString path = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation) + imageName;
    QFile file(path);
    if(file.open(QIODevice::WriteOnly)) {
        file.write(buffer.buffer());
        file.close();
    }

    if(file.error() != QFileDevice::NoError) {
        qDebug() << QString("Error writing file '%1'").arg(path) << file.errorString();
    }

}
