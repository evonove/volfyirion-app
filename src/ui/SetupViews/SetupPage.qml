import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui
import "./GameSetup" as GameSetup
import "./Rulebook" as Rulebook

Ui.BasePage {
    id: root

    signal openSection(int element)
    signal growlClicked

    width: 600
    height: 400

    initialItem: setupContent

    Action {
        id: _backAction
        icon.source: "qrc:/assets/back_icon.svg"
        onTriggered: root.pop()
    }

    Component {
        id: setupContent

        SetupContent {
            hasToolbar: false
            onGameSetupClicked: root.push(gameSetupContent)
            onRulebookClicked: root.push(rulebookContent)
            onGrowlClicked: root.growlClicked()
        }
    }

    Component {
        id: gameSetupContent

        GameSetup.GameSetupContent {
            // Padding here is needed when content has no toolbar
            // so that everything can shift down
            topPadding: root.headerHeight
            hasToolbar: true

            leftAction: _backAction
        }

    }

    Component {
        id: rulebookContent

        Rulebook.RulebookContent {
            topPadding: root.headerHeight
            hasToolbar: true

            leftAction: _backAction
            rightAction: Action {
                icon.source: "qrc:/assets/index_icon.svg"
                onTriggered: root.push(rulebookIndex)
            }

            Connections {
                target: root
                onOpenSection: scrollTo(element)
            }
        }
    }

    Component {
        id: rulebookIndex

        Rulebook.RulebookIndexContent {
            topPadding: root.headerHeight
            hasToolbar: true

            leftAction: _backAction

            onOpenSection: {
                root.openSection(element)
                root.pop()
            }
        }
    }
}
