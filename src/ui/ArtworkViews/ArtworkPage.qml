import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Ui.BasePage {
    id: root
    initialItem: artworkContent

    Component {
        id: artworkContent
        ArtworkContent {
            hasToolbar: true
            topPadding: root.headerHeight

            onArtworkDetailClicked: {
                root.push(artworkDetail, {"title": name, "url": url})
            }
        }
    }

    Component {
        id: artworkDetail
        ArtworkDetailContent {
            hasToolbar: true
            topPadding: root.headerHeight + 30

            leftAction: Action {
                id: _backAction
                icon.source: "qrc:/assets/back_icon.svg"
                onTriggered: root.pop()
            }
        }
    }
}
