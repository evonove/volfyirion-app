import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.TabButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 4
    topPadding: 8
    spacing: 0

    icon.width: 24
    icon.height: 24
    icon.color: checked ? control.palette.brightText : control.palette.windowText

    display: IconLabel.TextUnderIcon

    font.pixelSize: 12

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: control.display === IconLabel.IconOnly || control.display === IconLabel.TextUnderIcon ? Qt.AlignCenter : Qt.AlignLeft

        icon: control.icon
        text: control.text
        font: control.font
        color: checked ? control.palette.brightText : control.palette.windowText
    }

    background: Rectangle {
        implicitHeight: 44

        color: "transparent"
    }
}
