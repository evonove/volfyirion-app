import QtQuick 2.0

Rectangle {
    id: pawn

    property color playerColor: "transparent"
    property int xTouch: -1
    property int yTouch: -1

    property bool pressedPlayer: false

    x: pawn.xTouch - (pawn.width / 2)
    y: pawn.yTouch - (pawn.height / 2)

    Behavior on width {
        NumberAnimation {
            duration: 200
        }
    }
    Behavior on height {
        NumberAnimation {
            duration: 200
        }
    }
    SequentialAnimation on scale {
        running: state === "loading"
        loops: Animation.Infinite
        alwaysRunToEnd: true

        PropertyAnimation {
            to: 1.2
        }
        PropertyAnimation {
            to: 1
        }
    }

    state: "hidden"

    states: [
        State {
            name: "hidden"
            PropertyChanges {
                target: pawn
                width: 0
                height: 0
                radius: 135
                color: "transparent"
                border.width: 8
                border.color: pawn.playerColor
            }
        },
        State {
            name: "normal"
            PropertyChanges {
                target: pawn
                width: 100
                height: 100
                radius: 50
                color: "transparent"
                border.width: 8
                border.color: pawn.playerColor
            }
        },
        State {
            name: "loading"
            PropertyChanges {
                target: pawn
                height: 136
                width: 136
                radius: 68
                color: pawn.playerColor
                border.color: "transparent"
            }
        },
        State {
            name: "winner"
            PropertyChanges {
                target: pawn
                height: 270
                width: 270
                radius: 135
                color: pawn.playerColor
                border.color: "transparent"
            }
        }
    ]

    transitions: [
        Transition {
            from: "winner"
            to: "hidden"
            enabled: pawn.state === "winner"
            SequentialAnimation {
                alwaysRunToEnd: true

                NumberAnimation {
                    properties: "radius"
                    from: pawn.radius
                    to: 0
                }
                NumberAnimation {
                    properties: "scale"
                    to: 0
                }
                PropertyAction {
                    property: "visible"
                    value: false
                }
            }
        },
        Transition {
            from: "loading"
            to: "normal"
            PropertyAnimation {
                properties: "radius, scale, color"
            }
        },
        Transition {
            from: "winner"
            to: "normal"
            PropertyAnimation {
                properties: "radius, scale, color"
            }
        }
    ]
}
