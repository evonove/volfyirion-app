import QtQuick 2.12
import QtQuick.Controls 2.12

import ".." as Ui

Ui.BasePage {
    id: root

    title: qsTr("game setup")

    Image {
        anchors.fill: parent
        anchors.topMargin: 8
        anchors.bottomMargin: 8
        fillMode: Image.PreserveAspectFit

        source: "qrc:/assets/volf_setup_01.png"
    }
}
