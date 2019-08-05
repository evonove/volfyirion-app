import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.0

T.Button {
    id: control

    property bool running: false
    property bool squared: false

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    horizontalPadding: padding + 2
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: control.checked
                || control.highlighted ? control.palette.brightText : control.flat
                                         && !control.down ? (control.visualFocus ? control.palette.highlight : control.palette.windowText) : control.palette.buttonText

    font.capitalization: Font.AllUppercase
    font.pixelSize: control.squared ? 20 : 13

    states: State {
        name: "control-down"
        when: control.down
        PropertyChanges {
            target: iconLabel
            explicit: true
            opacity: 0.6
        }

        PropertyChanges {
            target: background
            explicit: true
            opacity: 0.6
        }
    }

    contentItem: IconLabel {
        id: iconLabel
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        opacity: 0.8

        icon: control.icon
        text: control.text
        font: control.font
        color: control.checked
               || control.highlighted ? control.palette.brightText : control.flat
                                        && !control.down ? (control.visualFocus ? control.palette.highlight : control.palette.windowText) : control.palette.buttonText
    }

    background: Item {
        implicitHeight: control.squared ? 72 : 76
        implicitWidth: control.squared ? 373 : 76

        opacity: 0.8

        Rectangle {
            id: externalEllipse
            anchors.fill: parent
            color: "transparent"
            border.color: "#FFFFFF"
            border.width: 2
            radius: control.squared ? 4 : 50

            SequentialAnimation on border.width {
                running: control.running
                loops: Animation.Infinite
                alwaysRunToEnd: true

                PropertyAnimation { to: 6 }
                PropertyAnimation { to: 2 }
            }

            Image {
                id: image
                anchors.centerIn: parent
                width: parent.width - 10
                height: parent.height - 10

                fillMode: Image.PreserveAspectCrop
                source: control.squared ? "qrc:/assets/square_growl_background.png" : "qrc:/assets/growl-button-background.png"
            }

            Rectangle {
                id: internalEllipse
                anchors.centerIn: parent
                width: parent.width - 10
                height: parent.height - 10
                color: "transparent"
                border.color: "#FFFFFF"
                border.width: 2
                radius: control.squared ? 2 : 50
            }
        }
    }
}
