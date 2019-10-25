#import "photosaverservice.h"
#import <Photos/Photos.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

bool checkWritingPermission() {
    __block bool result = true;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if(status != PHAuthorizationStatusAuthorized) {
//            NSString *message = @"Permission not granted to save artwork in Photos";

//            UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
//                                                  message:message
//                                                  delegate:nil
//                                                  cancelButtonTitle:nil
//                                                  otherButtonTitles:nil, nil];
//            [toast show];

//            int duration = 3; // duration in seconds

//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                [toast dismissWithClickedButtonIndex:0 animated:YES];
//            });
             result = false;
            printf("CHECK IOS: Permission not granted.");
        } else {
            printf("CHECK IOS: Permission granted.");

            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^ {
                // Request creating an asset from the image.
                UIImage *image = [UIImage imageNamed:@"imageFromBundleOrAsset"];
                PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];



                // Request editing the album.
//                PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection: album];
                // Get placeholder for the new asset and add it to the album editing request.
//                PHObjectPlaceholder * assetPlaceholder = [createAssetRequest placeholderForCreatedAsset];
//                [albumChangeRequest addAssets:@[assetPlaceholder]];
            } completionHandler: ^(BOOL success, NSError *error) {
                NSLog(@"Finished adding asset. %@", (success ? @"Success" : error));
            }];

//            NSString *message = @"Permission granted to save artwork in Photos";

//            UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
//                                                  message:message
//                                                  delegate:nil
//                                                  cancelButtonTitle:nil
//                                                  otherButtonTitles:nil, nil];
//            [toast show];

//            int duration = 3; // duration in seconds

//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                [toast dismissWithClickedButtonIndex:0 animated:YES];
//            });

            UIImage *image = [UIImage imageNamed:@"someImage.png"];
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
    }];
    return result;
}
