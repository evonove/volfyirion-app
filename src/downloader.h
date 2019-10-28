#ifndef DOWNLOADER_H
#define DOWNLOADER_H

#include <QObject>
#include <QBuffer>

#ifdef Q_OS_IOS
#include "ios/service/photosaverservice.h"
#endif

class Downloader : public QObject
{
    Q_OBJECT
public:
    explicit Downloader(QObject *parent = nullptr);

    Q_INVOKABLE void saveArtworkInPictures(QString urlImage);

    bool checkAndRequiredWritePermission();
    void showToast(const QString &message);

signals:

public slots:
private:
    PhotoSaverService m_photoSaver;
};

#endif // DOWNLOADER_H
