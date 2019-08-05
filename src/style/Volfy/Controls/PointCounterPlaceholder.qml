import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.12

Item {
    id: control

    property alias backgroundUrl: img.source
    property alias iconPointUrl: iconPoint.source
    property int score
    property string color

    signal decrementScore
    signal incrementScore


    implicitHeight: 153
    implicitWidth: 363

    SequentialAnimation on scale {
        running: incrementButton.pressed || decrementButton.pressed
        loops: Animation.Infinite
        alwaysRunToEnd: true

        ParallelAnimation {
            PropertyAnimation {
                target: iconPoint
                properties: "width, height"
                to: 84
                duration: 100
            }

            PropertyAnimation {
                target: scoreLabel
                properties: "font.pixelSize"
                to: 30
                duration: 150
            }
        }

        ParallelAnimation {
            PropertyAnimation {
                target: iconPoint
                properties: "width, height"
                to: 74
                duration: 100
            }

            PropertyAnimation {
                target: scoreLabel
                properties: "font.pixelSize"
                to: 24
                duration: 150
            }
        }

    }

    // background
    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: img.width
                height: img.height
                Rectangle {
                    anchors.centerIn: parent
                    width:  img.width
                    height: img.height
                    radius: 4
                }
            }
        }

        Rectangle {
            anchors.fill: parent
            color: "#3F3F3F"
            opacity: 0.5
        }
    }

    // content
    RowLayout {
        anchors.fill: parent

        RoundButton {
            id: decrementButton
            icon.source: "qrc:/assets/minus_icon.svg"

            enabled: control.score > 0
            onClicked: control.decrementScore()

            Layout.preferredWidth: 57
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                id: iconPoint
                anchors.centerIn: parent
                width: 74
                height: 74

                fillMode: Image.PreserveAspectFit
            }

            Label {
                id: scoreLabel
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                text: control.score

                font.bold: true
                font.pixelSize: 24
                color: control.color
                background: null
            }
        }

        RoundButton {
            id: incrementButton
            icon.source: "qrc:/assets/plus_icon.svg"

            onClicked: control.incrementScore()

            Layout.preferredWidth: 57
        }
    }
}
