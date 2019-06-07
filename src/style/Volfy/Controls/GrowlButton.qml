import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.0

T.Button {
    id: control

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
    font.pixelSize: 13

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

    contentItem: IconLabel {
        id: iconLabel
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text
        font: control.font
        color: control.checked
               || control.highlighted ? control.palette.brightText : control.flat
                                        && !control.down ? (control.visualFocus ? control.palette.highlight : control.palette.windowText) : control.palette.buttonText
    }

    background: Item {
        implicitHeight: 76
        implicitWidth: 76
        opacity: 0.5

        DropShadow {
            id: dropShadow
            anchors.fill: externalEllipse
            verticalOffset: 3
            radius: 16.0
            samples: 17
            color: "#80000000"
            source: externalEllipse
        }

        Rectangle {
            id: externalEllipse
            anchors.fill: parent
            color: "transparent"
            border.color: "#FFFFFF"
            border.width: 2
            radius: 50

            Image {
                id: image
                anchors.centerIn: parent
                width: parent.width - 10
                height: parent.height - 10

                fillMode: Image.PreserveAspectFit
                source: "qrc:/assets/growl-button-background.png"
            }
            Rectangle {
                id: internalEllipse
                anchors.centerIn: parent
                width: parent.width - 10
                height: parent.height - 10
                color: "transparent"
                border.color: "#FFFFFF"
                border.width: 2
                radius: 50
            }
        }
    }
}
