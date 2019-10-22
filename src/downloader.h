#ifndef DOWNLOADER_H
#define DOWNLOADER_H

#include <QObject>
#include <QBuffer>

class Downloader : public QObject
{
    Q_OBJECT
public:
    explicit Downloader(QObject *parent = nullptr);

    Q_INVOKABLE void downloadArtwork(QString urlImage);
    void saveArtwork(const QString &path, const QBuffer &buffer);

signals:

public slots:
};

#endif // DOWNLOADER_H
