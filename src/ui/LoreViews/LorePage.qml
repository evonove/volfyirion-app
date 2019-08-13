import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Ui.BasePage {
    id: root

    width: 600
    height: 400

    initialItem: loreContent

    Component {
        id: loreContent
        LoreContent {
            hasToolbar: true
            topPadding: root.headerHeight
            leftAction: null

            rightAction: Action {
                icon.source: "qrc:/assets/index_icon.svg"
            }
        }
    }
}
