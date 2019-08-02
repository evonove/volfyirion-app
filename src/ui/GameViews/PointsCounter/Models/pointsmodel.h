#ifndef POINTSMODEL_H
#define POINTSMODEL_H

#include <QObject>

class PointsModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int knowledge READ knowledge WRITE setKnowledge NOTIFY knowledgeChanged)
    Q_PROPERTY(int battle READ battle WRITE setBattle NOTIFY battleChanged)
    Q_PROPERTY(int command READ command WRITE setCommand NOTIFY commandChanged)
public:

    // getter methods
    int knowledge();
    int battle();
    int command();

    // setter methods
    Q_INVOKABLE void setKnowledge(const int &value);
    Q_INVOKABLE void setBattle(const int &value);
    Q_INVOKABLE void setCommand(const int &value);

    Q_INVOKABLE void resetPoints();

signals:
    void knowledgeChanged();
    void battleChanged();
    void commandChanged();

public slots:

private:
    int m_knowledge = 0;
    int m_battle = 0;
    int m_command = 0;
};

#endif // POINTSMODEL_H
