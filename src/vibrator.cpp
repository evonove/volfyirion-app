#include "vibrator.h"

#include <QtAndroidExtras>

Vibrator::Vibrator(QObject *parent) : QObject(parent)
{

}

void Vibrator::vibrate() {
    // Retrive activity
    QAndroidJniObject activity = QtAndroid::androidActivity();
    if(activity.isValid()) {
        activity.callMethod<void>("vibrate", "()V");
    }

}
