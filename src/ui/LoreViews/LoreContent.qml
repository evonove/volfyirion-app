import QtQuick 2.12
import QtQuick.Controls 2.12

import "../../ui" as Ui
import "./Models" as Models

Ui.BaseContent {
    id: root

    title: qsTr("lore")

    function scrollTo(element) {
        _listView.positionViewAtIndex(element, ListView.SnapPosition)
    }

    ListView {
        id: _listView
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds

        model: Models.LoreModel {
            parentWidth: parent.width
        }
    }
}
