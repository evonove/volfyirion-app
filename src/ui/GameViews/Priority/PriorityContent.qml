import QtQuick 2.13
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../../" as Ui

Ui.BaseContent {
    id: control
    title: qsTr("priority")

    signal transitionFinished

    background: Image {
        source: "qrc:/assets/priority_background.png"
        fillMode: Image.PreserveAspectCrop

        Rectangle {
            anchors.fill: parent
            color: "#2C2B2B"
            opacity: 0.7
        }
    }
    MultiPointTouchArea {
        id: multiTouch
        anchors.fill: parent
        maximumTouchPoints: 2
        mouseEnabled: false

        touchPoints: [
            TouchPoint {
                id: player1
            },
            TouchPoint {
                id: player2
            }
        ]

        Label {
            id: rulesPriorityGame
            anchors.fill: parent
            text: qsTr("Each player holds a finger on screen")
            font.pixelSize: 36
            font.capitalization: Font.AllUppercase
            font.letterSpacing: 0.05

            visible: pawn1.state === "hidden" && pawn2.state === "hidden"

            wrapMode: Text.WordWrap

            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            anchors.leftMargin: 84
            anchors.rightMargin: 84
        }

        onPressed: {
            if (player1.pressed && player2.pressed) {
                pawn1.state = "loading"
                pawn2.state = "loading"
                timer.start()
            }
        }

        onReleased: {
            timer.stop()
            pawn1.state = player1.pressed ? "normal" : "hidden"
            pawn2.state = player2.pressed ? "normal" : "hidden"
        }
    }

    PlayerIndicator {
        id: pawn1
        playerColor: "#59BCAD" // light blue
        xTouch: player1.x
        yTouch: player1.y

        pressedPlayer: player1.pressed
    }

    PlayerIndicator {
        id: pawn2
        playerColor: "#B289BD" // light violet
        xTouch: player2.x
        yTouch: player2.y

        pressedPlayer: player2.pressed
    }

    Timer {
        id: timer
        interval: 2000
        onTriggered: {
            // To get a random number between a range we use that formula
            // Math.random() * (max - min) + min
            //In our case max = 2 and min = 1.
            var winner = Math.floor(Math.random() * 2) + 1

            switch (winner) {
            case 1:
                pawn2.state = "hidden"
                pawn1.state = "winner"
                break
            case 2:
                pawn1.state = "hidden"
                pawn2.state = "winner"
                break
            }
        }
    }
}
