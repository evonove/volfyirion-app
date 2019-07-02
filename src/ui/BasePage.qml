import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    property alias initialItem: _stack.initialItem

    property alias headerHeight: _header.implicitHeight

    function push(component) {
        _stack.push(component)
    }

    function pop() {
        _stack.pop()
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: _stack.currentItem.isLoading

    }

    Header {
        id: _header
        width: parent.width
        height: 58
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
    }
}
