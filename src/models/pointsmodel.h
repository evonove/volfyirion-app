#ifndef POINTSMODEL_H
#define POINTSMODEL_H

#include <QObject>
#include <QSettings>

class PointsModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int knowledge READ knowledge WRITE setKnowledge NOTIFY knowledgeChanged)
    Q_PROPERTY(int battle READ battle WRITE setBattle NOTIFY battleChanged)
    Q_PROPERTY(int command READ command WRITE setCommand NOTIFY commandChanged)

public:
    PointsModel(QObject* parent = nullptr);

    // getter methods
    int knowledge();
    int battle();
    int command();

    // setter methods
    void setKnowledge(const int &value);
    void setBattle(const int &value);
    void setCommand(const int &value);

    Q_INVOKABLE void resetPoints();

signals:
    void knowledgeChanged();
    void battleChanged();
    void commandChanged();

public slots:

private:
    int m_knowledge;
    int m_battle;
    int m_command;

    QSettings m_settings;
};

#endif // POINTSMODEL_H
