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

    Header {
        id: _header
        width: parent.width
        height: 58
        z: 2

        position: ToolBar.Header

        title: _stack.currentItem.title

        leftAction: _stack.currentItem.leftAction
        rightAction: _stack.currentItem.rightAction

        visible: _stack.currentItem.hasToolbar
        enabled: _stack.currentItem.hasToolbar
    }

    StackView {
        id: _stack
        anchors.fill: parent
    }
}
