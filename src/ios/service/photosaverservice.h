#ifndef PHOTOSAVERSERVICE_H
#define PHOTOSAVERSERVICE_H

#include <QString>
#include <QImage>

class PhotoSaverService {

public:
    void saveImageInPhotos(QImage artwork);
    void performChangesInPhotosLibrary(QImage artwork);
    // Function to show a toast to the user
    static void showToast(const QString &message);
};

#endif // PHOTOSAVERSERVICE_H
