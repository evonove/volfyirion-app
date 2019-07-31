import QtQuick 2.13
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../../" as Ui

Ui.BaseContent {
    id: control
    title: qsTr("priority")

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

        onPressed: {
            if (player1.pressed && player2.pressed) {
                console.log("both pressed")
                pawn1.state = "loading"
                pawn2.state = "loading"
                timer.start()
            }
        }

        onReleased: {
            // Reset default properties to pawns
            timer.stop()
        }
    }

    PlayerIndicator {
        id: pawn1
        playerColor: palette.mid
        xTouch: player1.x
        yTouch: player1.y

        pressedPlayer: player1.pressed
    }

    PlayerIndicator {
        id: pawn2
        playerColor: palette.dark
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
            var winner = Math.floor(Math.random() * 2) + 1;
            console.log(winner)

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
