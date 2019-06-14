import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "SetupViews" as SetupViews

Page {
    width: 600
    height: 400

    property string text: qsTr("Page 2")

    header: Header {
        title: stack.currentItem.title

        leftAction: stack.currentItem.leftAction
        rightAction: stack.currentItem.rightAction

        visible: stack.currentItem.hasToolbar
        enabled: stack.currentItem.hasToolbar
    }

    StackView {
        id: stack
        anchors.fill: parent
        anchors.topMargin: stack.currentItem.hasToolbar ? 0 : header.implicitHeight
        initialItem: indexView
    }

    Component {
        id: indexView

        Page {
            property bool hasToolbar: false

            property Action leftAction: null

            property Action rightAction: null

            title: "first view"

            ColumnLayout {
                anchors.fill: parent

                Button {
                    text: "hello"
                    onClicked: stack.push(secondView)
                    Layout.preferredWidth: 277
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
            }
        }
    }

    Component {
        id: secondView

        SetupViews.GameSetupContent {
            hasToolbar: true

            leftAction: Action {
                icon.source: "qrc:/assets/back_icon.svg"
                onTriggered: stack.pop()
            }
        }
    }
}
