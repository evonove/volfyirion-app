import QtQuick 2.12
import QtQuick.Controls 2.12

ToolBar {
    id: root

    property alias title: _label.text

    property Action leftAction: null

    property Action rightAction: null

    ToolButton {
        action: root.leftAction
        anchors.left: parent.left

        visible: root.leftAction !== null
        enabled: root.leftAction !== null
    }

    Label {
        id: _label
        anchors.centerIn: parent

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        font.capitalization: Font.AllUppercase
        font.pixelSize: 22
    }

    ToolButton {
        action: root.rightAction
        anchors.right: parent.right

        visible: root.rightAction !== null
        enabled: root.rightAction !== null
    }
}
