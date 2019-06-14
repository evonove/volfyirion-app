import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Page {
    width: 600
    height: 400

    property string text: qsTr("Page 1")

    Ui.Header {
        id: _header
        position: ToolBar.Header
        z:2
        width: parent.width
        height: 58
        title: stack.currentItem.title

        leftAction: stack.currentItem.leftAction
        rightAction: stack.currentItem.rightAction

        visible: stack.currentItem.hasToolbar
        enabled: stack.currentItem.hasToolbar
    }

    StackView {
        id: stack
        anchors.fill: parent

        initialItem: setupContent
    }

    Component {
        id: setupContent
        SetupContent {
            hasToolbar: false
            onGameSetupClicked: stack.push(gameSetupContent)
        }
    }

    Component {
        id: gameSetupContent

        GameSetupContent {
            topPadding: _header.implicitHeight
            hasToolbar: true

            leftAction: Action {
                icon.source: "qrc:/assets/back_icon.svg"
                onTriggered: stack.pop()
            }
        }
    }
}
