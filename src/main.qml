import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "ui" as Ui

ApplicationWindow {
    visible: true
    width: 375
    height: 667
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

        Ui.Page2Form {
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Setup")
            icon.source: this.down || this.checked ? _tabIcons.setupFilled : _tabIcons.setup
        }
        TabButton {
            text: qsTr("Game")
            icon.source: this.down || this.checked ? _tabIcons.gameFilled : _tabIcons.game
        }
        TabButton {
            text: qsTr("Artwork")
            icon.source: this.down || this.checked ? _tabIcons.artworkFilled : _tabIcons.artwork
        }
    }

    QtObject {
        id: _tabIcons

        property url artwork: "qrc:/assets/artwork_icon.svg"
        property url artworkFilled: "qrc:/assets/artwork_icon_filled.svg"
        property url game: "qrc:/assets/game_icon.svg"
        property url gameFilled: "qrc:/assets/game_icon_filled.svg"
        property url setup: "qrc:/assets/setup_icon.svg"
        property url setupFilled: "qrc:/assets/setup_icon_filled.svg"
    }
}