#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#ifdef Q_OS_ANDROID
#include <QtAndroid>
#endif

#include "system.h"
#include "models/pointsmodel.h"
#include "vibrator.h"
#include "downloader.h"

static QObject *
system_manager_singletontype_provider(QQmlEngine *engine,
                                      QJSEngine *scriptEngine) {
  Q_UNUSED(scriptEngine)
  Q_UNUSED(engine)
  auto system = new System();

  return system;
}
static QObject *
vibrator_manager_singletontype_provider(QQmlEngine *engine,
                                      QJSEngine *scriptEngine) {
  Q_UNUSED(scriptEngine)
  Q_UNUSED(engine)
  auto vibrator = new Vibrator();

  return vibrator;
}
static QObject *
downloader_manager_singletontype_provider(QQmlEngine *engine,
                                      QJSEngine *scriptEngine) {
  Q_UNUSED(scriptEngine)
  Q_UNUSED(engine)
  auto downloader = new Downloader();

  return downloader;
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setApplicationName("Volfyirion");
    QCoreApplication::setOrganizationName("Tabula Games");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterSingletonType<System>(
        "System", 1, 0, "System",
        system_manager_singletontype_provider);

    qmlRegisterSingletonType<Vibrator>(
        "Vibrator", 1, 0, "Vibrator",
        vibrator_manager_singletontype_provider);

    qmlRegisterSingletonType<Vibrator>(
        "Downloader", 1, 0, "Downloader",
        downloader_manager_singletontype_provider);

    engine.addImportPath("qrc:/style");

    qmlRegisterType<PointsModel>("PointsModel", 1, 0, "PointsModel");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

#ifdef Q_OS_ANDROID
    QtAndroid::hideSplashScreen();
#endif
    return app.exec();
}
