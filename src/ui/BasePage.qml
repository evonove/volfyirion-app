import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: root

    property real safeTopMargin: 0

    property alias initialItem: _stack.initialItem

    property real headerHeight: 58 + root.safeTopMargin

    function push(component) {
        _stack.push(component)
        _stack.forceActiveFocus()
    }

    function pop() {
        _stack.pop()
        _stack.forceActiveFocus()
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: _stack.currentItem.isLoading

    }

    Header {
        id: _header
        width: parent.width
        topPadding: root.safeTopMargin
        height: root.headerHeight
        z: 2

        position: ToolBar.Header

        title: _stack.currentItem.title

        leftAction: _stack.currentItem.leftAction
        rightAction: _stack.currentItem.rightAction

        opacity: _stack.currentItem.hasToolbar ? 1.0 : 0.0
        enabled: _stack.currentItem.hasToolbar

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    StackView {
        id: _stack
        anchors.fill: parent
        focus: true

        // Handles click of back button by popping current page from Swipe
        Keys.onPressed: {
            if (event.key === Qt.Key_Escape || event.key === Qt.Key_Back) {
                if (_stack.depth > 1) {
                    _stack.pop()
                    event.accepted = true
                }
            }
        }
    }
}
