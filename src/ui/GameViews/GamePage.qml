import QtQuick 2.0
import QtQuick.Controls 2.12
import Volfy.Controls 1.0

import "../" as Ui

import "./Priority" as Priority
import "./PointsCounter" as PointsCounter

Ui.BasePage {
    id: root

    initialItem: gameContent

    Action {
        id: _backAction
        icon.source: "qrc:/assets/back_icon.svg"
        onTriggered: root.pop()
    }

    Component {
        id: gameContent
        GameContent {
            hasToolbar: false

            onPriorityClicked: root.push(priorityContent)
            onPointsCounterClicked: root.push(pointsCounterContent)
        }
    }

    Component {
        id: priorityContent
        Priority.PriorityContent {
            // Padding here is needed when content has no toolbar
            // so that everything can shift down
            topPadding: root.headerHeight
            hasToolbar: true

            leftAction: _backAction

            onWinnerChoosen: {
                root.replace(pointsCounterContent)
            }
        }
    }

    Component {
        id: pointsCounterContent
        PointsCounter.PointsCounterContent {
            // Padding here is needed when content has no toolbar
            // so that everything can shift down
            topPadding: root.headerHeight
            hasToolbar: true

            leftAction: _backAction
        }
    }
}
