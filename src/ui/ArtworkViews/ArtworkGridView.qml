import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

GridView {
    id: root

    signal artworkClicked(string url)

    bottomMargin: 45
    interactive: true

    Layout.fillWidth: true
    Layout.alignment: Qt.AlignCenter

    delegate: Pane {
        id: _pane
        height: root.cellHeight
        width: root.cellWidth
        topPadding: 3
        bottomPadding: 3
        leftPadding: 3
        rightPadding: 3
        background: null

        ColumnLayout {
            id: col
            anchors.fill: parent
            spacing: 0

            Rectangle {
                color: img.status === Image.Ready ? "transparent" : _pane.palette.mid
                border.color: _pane.palette.mid
                opacity: img.status === Image.Ready ? 1 : 0.5
                Layout.preferredHeight: parent.height
                Layout.maximumWidth: parent.width
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                clip: true

                Image {
                    id: img
                    fillMode: Image.PreserveAspectCrop
                    source: model.thumbUrl
                    asynchronous: true

                    anchors.fill: parent
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                // Unfocuses search field so that keyboard is hidden
                root.artworkClicked(model.bigUrl)
            }
        }
    }
}
