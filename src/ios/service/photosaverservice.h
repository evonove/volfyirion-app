#ifndef PHOTOSAVERSERVICE_H
#define PHOTOSAVERSERVICE_H

#include <QString>
#include <QImage>

class PhotoSaverService {

public:
    bool checkWritingPermission ();
    void saveImageInPhotos(QImage artwork, QString &urlImage);
    void performChangesInPhotosLibrary(QImage artwork);
    // Function to show a toast to the user
    static void showToast(const QString &message);
};

#endif // PHOTOSAVERSERVICE_H
