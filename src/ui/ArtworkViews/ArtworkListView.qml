import QtQuick 2.0
import QtQuick.Controls 2.12

ListView {
    id: root

    signal artworkClicked(string url)

    spacing: 24
    delegate: Image {
        width: root.width
        source: model.bigUrl
        fillMode: Image.PreserveAspectCrop

        MouseArea {
            anchors.fill: parent

            onClicked: {
                // Unfocuses search field so that keyboard is hidden
                root.artworkClicked(model.bigUrl)
            }
        }
    }
}
