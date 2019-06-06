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
    icon.color: control.checked || control.highlighted ? control.palette.brightText :
                control.flat && !control.down ? (control.visualFocus ? control.palette.highlight : control.palette.windowText) : control.palette.buttonText

    font.capitalization: Font.AllUppercase
    font.pixelSize: 18

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
        color: control.checked || control.highlighted ? control.palette.brightText :
               control.flat && !control.down ? (control.visualFocus ? control.palette.highlight : control.palette.windowText) : control.palette.buttonText
    }

    background: Item {
        implicitWidth: 100
        implicitHeight: 50

        DropShadow {
            id: dropShadow
            anchors.fill: buttonShape
            verticalOffset: 3
            radius: 16.0
            samples: 17
            color: "#80000000"
            source: buttonShape
        }

        ButtonShape {
            id: buttonShape
            anchors.fill: parent

            strokeColor: control.palette.mid
            fillColor: control.palette.button
        }
    }
}
