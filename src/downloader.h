#ifndef DOWNLOADER_H
#define DOWNLOADER_H

#include <QObject>
#include <QBuffer>

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
};

#endif // DOWNLOADER_H
