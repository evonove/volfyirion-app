import QtQuick 2.0
import QtQuick.Controls 2.12
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
        }
    }
}
