#include "pointsmodel.h"

PointsModel::PointsModel(QObject * parent) : QObject (parent) {
    m_knowledge = m_settings.value("knowledge", 0).toInt();
    m_battle = m_settings.value("battle", 0).toInt();
    m_command = m_settings.value("command", 0).toInt();
}

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
    m_settings.setValue("knowledge", value);
    emit knowledgeChanged();
}
void PointsModel::setBattle(const int &value){
    m_battle = value;
    m_settings.setValue("battle", value);
    emit battleChanged();
}
void PointsModel::setCommand(const int &value){
    m_command = value;
    m_settings.setValue("command", value);
    emit commandChanged();
}

void PointsModel::resetPoints() {
    setKnowledge(0);
    setBattle(0);
    setCommand(0);
}
