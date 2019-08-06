#include "vibrator.h"

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras>
#endif

#ifdef Q_OS_IOS
#include "ios/service/vibratorservice.h"
#endif

Vibrator::Vibrator(QObject *parent) : QObject(parent)
{

}

void Vibrator::vibrate() {
#ifdef Q_OS_ANDROID
    // Retrive activity
    QAndroidJniObject activity = QtAndroid::androidActivity();
    if(activity.isValid()) {
        activity.callMethod<void>("vibrate", "()V");
    }
#endif

#ifdef Q_OS_IOS
    iOSVibrate();
#endif
}
