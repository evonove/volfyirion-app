import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Ui.BasePage {
    id: root

    width: 600
    height: 400

    initialItem: artworkContent

    Component {
        id: artworkContent
        ArtworkContent {
            hasToolbar: true
            topPadding: root.headerHeight

            onArtworkDetailClicked: {
                root.push(artworkDetail, {"url": url})
            }
        }
    }

    Component {
        id: artworkDetail
        ArtworkDetailContent {
            hasToolbar: true
            topPadding: root.headerHeight

            leftAction: Action {
                id: _backAction
                icon.source: "qrc:/assets/back_icon.svg"
                onTriggered: root.pop()
            }
        }
    }
}
