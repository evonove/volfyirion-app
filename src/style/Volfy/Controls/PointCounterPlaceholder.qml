import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.12

Rectangle {
    id: control

    property alias backgroundUrl: img.source
    property alias iconPointUrl: iconPoint.source
    property int score
    property string color

    signal decrementScore
    signal incrementScore

    implicitHeight: 153
    implicitWidth: 363
    radius: 3


    states: State {
        name: "control-down"
        when: control.down
        PropertyChanges {
            target: iconLabel
            explicit: true
            y: iconLabel.y + 2
        }
        PropertyChanges {
            target: background
            y: 2
        }
        PropertyChanges {
            target: dropShadow
            verticalOffset: 1
        }
    }


    // background
    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop

        height: 74
        width: 74

        Rectangle {
            anchors.fill: parent
            color: "#3F3F3F"
            opacity: 0.5
        }
    }

    // content
    Row {
        anchors.fill: parent
        T.Button {
            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 24
                source: "qrc:/assets/minus_icon.svg"

                height: 24
                width: 24

                fillMode: Image.PreserveAspectFit
            }

            height: parent.height
            width: parent.width / 3

            enabled: control.score > 0

            onClicked: control.decrementScore()
        }

        Item {
            anchors.bottomMargin: 40
            anchors.topMargin: 40

            height: parent.height
            width: parent.width / 3

            Image {
                id: iconPoint
                anchors.centerIn: parent
                width: 74
                height: 74

                fillMode: Image.PreserveAspectFit
            }


            Label {
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

        T.Button {
            id: plusButton
            Image {
                id: plusIcon
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 24
                source: "qrc:/assets/plus_icon.svg"

                height: 24
                width: 24

                fillMode: Image.PreserveAspectFit
            }


            height: parent.height
            width: parent.width / 3

            onClicked: control.incrementScore()
        }
    }
}
