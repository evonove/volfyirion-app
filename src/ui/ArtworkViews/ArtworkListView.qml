import QtQuick 2.0
import QtQuick.Controls 2.12

ListView {
    id: root

    property ListModel artModel

    anchors.fill: parent
    anchors.topMargin: 24

    model: artModel
    spacing: 24
    delegate: Image {
        width: parent.width
        source: model.bigUrl
        fillMode: Image.PreserveAspectFit
    }
}
