import QtQuick 2.0
import Volfy.Controls 1.0

import "../" as Ui

Ui.BasePage {
    id: root

    initialItem: gameContent

    Component {
        id: gameContent
        GameContent {
            hasToolbar: false
        }
    }
}
