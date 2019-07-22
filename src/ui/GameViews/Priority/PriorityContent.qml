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

    ColumnLayout {
        anchors.fill: parent

        MultiPointTouchArea {
            Layout.fillWidth: true
            Layout.fillHeight: true
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

            Rectangle {
                id:pawn1
                width: 100
                height: 100
                radius: 50
                border.color: "#49C5B1"
                border.width: 8
                color: "transparent"
                x: player1.x - (pawn1.width/2)
                y: player1.y - (pawn1.height/2)
                visible: player1.pressed
            }

            Rectangle {
                id:pawn2
                width: 100
                height: 100
                radius: 50
                color: palette.mid
                x: player2.x - (pawn2.width/2)
                y: player2.y - (pawn2.height/2)
                visible: player2.pressed
            }

            onPressed: {
                if(player1.pressed && player2.pressed) {
                    pawn1.width = 136;
                    pawn1.height = 136;
                    pawn1.radius = 68;
                    pawn1.color = pawn1.border.color;
                    pawn2.width = 136;
                    pawn2.height = 136;
                    pawn2.radius = 68;
                    pawn2.color = pawn2.border.color;

                }
            }

            onReleased: {
                console.log("released");
            }
        }

    }
}
