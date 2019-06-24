#pragma once

#include <QObject>
#include <QVariantMap>

class QQuickWindow;

class System : public QObject
{
    Q_OBJECT
public:
    explicit System(QObject* parent = nullptr);

    Q_INVOKABLE QVariantMap getSafeAreaMargins(QQuickWindow *window);
};
