#include <QDebug>

#include "pointsmodel.h"

int PointsModel::knowledge(){
    return m_knowledge;
}
int PointsModel::battle(){
    return m_battle;
}
int PointsModel::command(){
    return m_command;
}

void PointsModel::setKnowledge(const int &value){
    m_knowledge = value;
    emit knowledgeChanged();
}
void PointsModel::setBattle(const int &value){
    m_battle = value;
    emit battleChanged();
}
void PointsModel::setCommand(const int &value){
    m_command = value;
    emit commandChanged();
}

void PointsModel::resetPoints() {
    setKnowledge(0);
    setBattle(0);
    setCommand(0);
}
