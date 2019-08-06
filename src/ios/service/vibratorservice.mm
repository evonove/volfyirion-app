#import "vibratorservice.h"
#import <AudioToolbox/AudioServices.h>

void iOSVibrate() {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
