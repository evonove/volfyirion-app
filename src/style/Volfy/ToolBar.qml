import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.0

T.ToolBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    background: Item {
        implicitHeight: 58

        DropShadow {
            id: dropShadow
            anchors.fill: backgroundRect
            verticalOffset: 2
            radius: 20.0
            samples: 17
            color: "#80000000"
            source: backgroundRect
        }

        Rectangle {
            id: backgroundRect
            anchors.fill: parent
            color: control.palette.window

            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: control.palette.mid
            }
        }
    }
}
