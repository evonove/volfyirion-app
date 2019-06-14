import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Page {
    width: 600
    height: 400

    property string text: qsTr("Page 1")
    property bool hasToolBar: false

    header: Ui.Header {
        title: stack.currentItem.title

        leftAction: stack.currentItem.leftAction
        rightAction: stack.currentItem.rightAction

        visible: stack.currentItem.hasToolbar
        enabled: stack.currentItem.hasToolbar
    }

    StackView {
        id: stack
        anchors.fill: parent
        anchors.topMargin: stack.currentItem.hasToolbar ? header.implicitHeight : 0
        initialItem: setupContentPage
    }

    Component {
        id: setupContentPage
        SetupContent {
            anchors.fill: parent
        }
    }
}
