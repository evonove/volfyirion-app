#import "photosaverservice.h"

#include <QDebug>

#import <Photos/Photos.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

void PhotoSaverService::showToast(const QString &message) {

    qCritical() << "PHOTO SAVER: showToast() " << message;
    NSString* messageToast = message.toNSString();
    qCritical() << messageToast;

    [[NSOperationQueue mainQueue] addOperationWithBlock: ^{

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                message: messageToast
                preferredStyle: UIAlertControllerStyleAlert];

        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        [alert addAction:defaultAction];

        // We use [UIApplication sharedApplication].keyWindow.rootViewController instead of 'self' to take the pointer to the current instance.
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
}

bool PhotoSaverService::checkWritingPermission() {
    __block bool result = true;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if(status != PHAuthorizationStatusAuthorized) {

            QString message = "Permission not granted to save artwork in Photos";
            result = false;
            showToast(message);

            printf("CHECK IOS: Permission not granted.");

        } else {
            QString message = "Permission granted to save artwork in Photos";
            result = true;
            showToast(message);
            printf("CHECK IOS: Permission granted.");
        }
    }];
    return result;
}

void PhotoSaverService::saveImageInPhotos(QImage artwork) {
    qCritical() << "PhotoSaverService::saveImageInPhotos image size" << artwork.size();
    // Check permission to write in Photos Library.
    bool hasWritePermission = [PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized;

    if(hasWritePermission) {
        // Save UIImage in Photos Library.
        performChangesInPhotosLibrary(artwork);
    } else {
        // Required permission to write in Photos Library.
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status != PHAuthorizationStatusAuthorized) {
                QString message = "Permission not granted to save artwork in Photos";
                showToast(message);
                printf("CHECK IOS: Permission not granted.");
            } else {
                QString message = "Permission granted to save artwork in Photos";
                showToast(message);
                printf("CHECK IOS: Permission granted.");

                qCritical() << "artwork is valid: " << artwork.size();

                performChangesInPhotosLibrary(artwork);
            }
        }];
    }
}

void PhotoSaverService::performChangesInPhotosLibrary(QImage artwork){
    qCritical() << "PhotoSaverService::performChangesInPhotosLibrary image size" << artwork.size();
    // Save images in PhotoLibrary
    // Convert QImage to CGIImage that can be converted to UIImage.
    CGImageRef imageRef = artwork.toCGImage();
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    bool imageIsValid = image!=nil;

    qCritical() << "image is valid" << imageIsValid;
    if(imageIsValid) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^(void) {

            // Add a request to create an asset from the UIImage.
            PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            PHObjectPlaceholder *assetPlaceHolder = [createAssetRequest placeholderForCreatedAsset];
        } completionHandler:^ (BOOL success, NSError *error) {
            if(success) {
                qCritical() << "Finished adding asset success:" <<  success;
                QString message = "Artwork saved in Photos Library.";
                showToast(message);
            }
        }];
    } else {
        auto errorMessage = "Error occurs during conversion of Image.";
        qCritical() << errorMessage;
        showToast(errorMessage);
    }

}
