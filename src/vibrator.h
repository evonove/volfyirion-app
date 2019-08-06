#ifndef VIBRATOR_H
#define VIBRATOR_H

#include <QObject>

class Vibrator : public QObject
{
    Q_OBJECT
public:
    explicit Vibrator(QObject *parent = nullptr);

    Q_INVOKABLE void vibrate();

signals:

public slots:
};

#endif // VIBRATOR_H
