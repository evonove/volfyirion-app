import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.ItemDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 12
    spacing: 8

    icon.width: 24
    icon.height: 24
    icon.color: control.palette.text

    contentItem: Label {
        wrapMode: Text.Wrap

        text: control.text
        font: control.font
        color: control.highlighted ? control.palette.highlightedText : control.palette.text
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        visible: control.down || control.highlighted || control.visualFocus
        color: Color.blend(control.down ? control.palette.midlight : control.palette.light,
                                          control.palette.highlight, control.visualFocus ? 0.15 : 0.0)
    }
}
