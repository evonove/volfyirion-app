import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "ui" as Ui

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")

    FontLoader { source: "qrc:/fonts/Oswald/Oswald.ttf" }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "<"
            }
        }
        Label {
            anchors.centerIn: parent
            text: swipeView.currentItem.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Ui.Page1Form {
        }

        Ui.Page2Form {
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Page 1")
        }
        TabButton {
            text: qsTr("Page 2")
        }
    }
}
