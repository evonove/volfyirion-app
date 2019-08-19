import QtQuick 2.0
import QtQuick.Controls 2.12


ListView {
    id: root

    property ListModel artModel

    anchors.fill: parent
    anchors.topMargin: 24

    model: artModel
    spacing: 24
    delegate: Column {
        width: parent.width
        Label {
            width: parent.width
            text: qsTr(model.title)
            font.pixelSize: 23
            font.letterSpacing: 0.5

            horizontalAlignment: Qt.AlignHCenter
        }
        Image {
            width: parent.width
            source: model.url
            fillMode: Image.PreserveAspectFit
        }
    }
}
