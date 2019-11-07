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

#ifdef Q_OS_ANDROID
    bool checkAndRequiredWritePermission();
    void showToast(const QString &message);
#endif

signals:

public slots:

private:
#ifdef Q_OS_IOS
    PhotoSaverService m_photoSaver;
#endif
};

#endif // DOWNLOADER_H
