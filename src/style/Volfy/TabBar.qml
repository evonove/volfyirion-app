import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.0

T.TabBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: 1

    contentItem: ListView {
        model: control.contentModel
        currentIndex: control.currentIndex

        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.AutoFlickIfNeeded
        snapMode: ListView.SnapToItem

        highlightMoveDuration: 0
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: 40
        preferredHighlightEnd: width - 40
    }

    background: Item {

        DropShadow {
            id: dropShadow
            anchors.fill: backgroundRect
            verticalOffset: -2
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
                anchors.top: parent.top
                color: control.palette.mid
            }
        }
    }
}
