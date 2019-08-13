import QtQuick 2.12
import QtQuick.Controls 2.12

import "../../ui" as Ui
import "./Models" as Models

Ui.BaseContent {
    id: root

    title: qsTr("lore")
    background: Rectangle {
        color: "#3B3A3A"
    }

    ListView {
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds

        model: Models.LoreModel {
            parentWidth: parent.width
        }
    }
}
