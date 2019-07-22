import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import System 1.0

import "ui/SetupViews" as SetupViews
import "ui/GameViews" as GameViews
import "ui" as Ui

ApplicationWindow {
    id: root
    visible: true
    width: 375
    height: 667
    title: qsTr("Tabs")
    flags: Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint

    // A top margin added to various components so that they're not covered
    // by the iPhone top notch
    property real safeTopMargin: 0
    property real safeBottomMargin: 0

    Component.onCompleted: {
        let margins = System.getSafeAreaMargins(root)
        root.safeTopMargin = margins.top
        root.safeBottomMargin = margins.bottom
    }

    FontLoader { source: "qrc:/fonts/Oswald/Oswald.ttf" }

    QtObject {
        id: history

        property var items: [0]

        function push(index) {
            let lastIndex = items[items.length - 1]
            if (lastIndex !== index) {
                items.push(index)
                // set current index of the swipe view
                _swipe.currentIndex = index
            }
            _swipe.currentItem.forceActiveFocus()
        }

        function pop() {
            if (items.length > 1) {
                // remove current
                items.pop();
                // set swipe to the last item in the history
                let index = items[items.length - 1]
                _swipe.currentIndex = index
            }
            _swipe.currentItem.forceActiveFocus()
        }
    }

    SwipeView {
        id: _swipe
        anchors.fill: parent
        interactive: false
        focus: true

        // Handles click of back button by popping current page from Swipe
        Keys.onPressed: {
            if (event.key === Qt.Key_Escape || event.key === Qt.Key_Back) {
                if (history.items.length > 1) {
                    history.pop()
                    event.accepted = true
                }
            }
        }

        SetupViews.SetupPage {
            safeTopMargin: root.safeTopMargin
        }

        GameViews.GamePage {
            safeTopMargin: root.safeTopMargin
        }


    }

    footer: TabBar {
        id: tabBar
        currentIndex: _swipe.currentIndex
        bottomPadding: root.safeBottomMargin

        TabButton {
            text: qsTr("Setup")
            icon.source: this.down || this.checked ? _tabIcons.setupFilled : _tabIcons.setup
            onClicked: history.push(TabBar.index)
        }
        TabButton {
            text: qsTr("Game")
            icon.source: this.down || this.checked ? _tabIcons.gameFilled : _tabIcons.game
            onClicked: history.push(TabBar.index)
        }
        TabButton {
            text: qsTr("Artwork")
            icon.source: this.down || this.checked ? _tabIcons.artworkFilled : _tabIcons.artwork
            onClicked: history.push(TabBar.index)
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
}
