#import "photosaverservice.h"

#include <QDebug>

#import <Photos/Photos.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

void PhotoSaverService::showToast(const QString &message) {

    qCritical() << "PHOTO SAVER: showToast() " << message;
    NSString* messageToast = message.toNSString();
    qCritical() << messageToast;
//    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
//        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//        UILabel *toastView = [[UILabel alloc] init];

//        toastView.text = messageToast;
//        toastView.frame = CGRectMake(0.0, 0.0, keyWindow.frame.size.width/2.0, 200.0);
//        toastView.textAlignment = NSTextAlignmentCenter;
//        toastView.layer.cornerRadius = 10;
//        toastView.layer.masksToBounds = YES;
//        toastView.backgroundColor = [UIColor grayColor];
//        toastView.textColor = [UIColor whiteColor];
//        toastView.center = keyWindow.center;

//        [keyWindow addSubview:toastView];

//        [UIView animateWithDuration: 3.0f
//                          delay: 0.0
//                        options: UIViewAnimationOptionCurveEaseOut
//                     animations: ^{
//                         toastView.alpha = 0.0;
//                     }
//                     completion: ^(BOOL finished) {
//                         [toastView removeFromSuperview];
//                     }
//         ];
//    }];

//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Artworks"
//                                                      message: messageToast
//                                                      preferredStyle: UIAlertControllerStyleActionSheet ];

//        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                                //button click event
//                            }];
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:cancel];
//        [alert addAction:ok];
//        [alert presentViewController:alert animated:YES completion:nil];
//    });
}

bool PhotoSaverService::checkWritingPermission() {
    __block bool result = true;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if(status != PHAuthorizationStatusAuthorized) {

            QString message = "Permission not granted to save artwork in Photos";
            result = false;
            PhotoSaverService::showToast(message);

            printf("CHECK IOS: Permission not granted.");

        } else {
            QString message = "Permission granted to save artwork in Photos";
            result = true;
            PhotoSaverService:showToast(message);
            printf("CHECK IOS: Permission granted.");
        }
    }];
    return result;
}

void PhotoSaverService::saveImageInPhotos(QImage &artwork, QString &urlImage) {
        CGImageRef imageRef = artwork.toCGImage();
        UIImage* image = [[UIImage alloc] initWithCGImage:imageRef];

        qCritical() << "urlImage" << urlImage;

        NSString* imageName = urlImage.remove(0, 24).toNSString();

        bool res = true;
        if (image == nil) {
            res = false;
        }
        qCritical() << "image name"  << imageName << "image size" << res;


}
