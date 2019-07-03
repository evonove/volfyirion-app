import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtMultimedia 5.13

import "ui/SetupViews" as SetupViews
import "ui" as Ui

ApplicationWindow {
    visible: true
    width: 375
    height: 667
    title: qsTr("Tabs")

    FontLoader { source: "qrc:/fonts/Oswald/Oswald.ttf" }


    SwipeView {
        id: swipeView
        anchors.fill: parent
        interactive: false
        currentIndex: tabBar.currentIndex

        SetupViews.SetupPage {
            onGrowlClicked: {
                _player.play()
                _player.playlist.shuffle()
            }
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
            enabled: false
        }
        TabButton {
            text: qsTr("Artwork")
            icon.source: this.down || this.checked ? _tabIcons.artworkFilled : _tabIcons.artwork
            enabled: false
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

    Audio {
        id: _player

        loops: 0
        playlist: Playlist {
            playbackMode: Playlist.CurrentItemOnce

            PlaylistItem { source: "qrc:/music/growl_A.mp3" }
            PlaylistItem { source: "qrc:/music/growl_B.mp3" }
        }
    }
}
