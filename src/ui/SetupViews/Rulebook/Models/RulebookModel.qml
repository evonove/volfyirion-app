import QtQml.Models 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

import ".."

ObjectModel {
    id: root
    signal downloadAreaClicked()

    property var searchable: initSearchable()

    property real width: 100

    function initSearchable() {
        let results = []
        for(let i = 0; i < root.count; i++) {
            let node = root.get(i);
            searchableNodesInTree(node, results)
        }
        return results
    }

    function searchableNodesInTree(node, results) {
        if (node.hasOwnProperty("text") && node.hasOwnProperty("select")) {
            results.push(node)
        }

        for(let i = 0; i < node.children.length; i++) {
            searchableNodesInTree(node.children[i], results)
        }
    }

    // 0
    Item {
        width: root.width
        height: _background.paintedHeight

        Image {
            id: _background
            height: 437
            source: "qrc:/assets/rulebook/rulebook_page_background.png"
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        DropShadow {
            id: dropShadow
            anchors.fill: _logo
            verticalOffset: 3
            radius: 16.0
            samples: 17
            color: "#80000000"
            source: _logo
        }

        Image {
            id: _logo
            width: 226
            fillMode: Image.PreserveAspectFit

            source: "qrc:/assets/rulebook/logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 72
        }

        Image {
            id: userImg
            width: 119
            fillMode: Image.PreserveAspectFit

            source: "qrc:/assets/rulebook/00_game-conditions-main-ruleb.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: _logo.bottom
            anchors.topMargin: 89
        }

        Button {
            width: 277
            height: 50

            text: qsTr("Download area")
            onClicked: root.downloadAreaClicked()

            icon.source: "qrc:/assets/right_arrow.svg"

            LayoutMirroring.enabled: true
            LayoutMirroring.childrenInherit: true

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: userImg.bottom
            anchors.topMargin: 36
        }
    }

    // 1
    Item {
        height: 144
    }

    // 2
    ColumnLayout {
        id: _introduction
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.bottomMargin: 48

            text: qsTr("introduction")
        }

        RulebookText {
            Layout.fillWidth: true
            text: qsTr("The unspoken rivalry between House Volarees and House Rorius escalated into war once they "
                       + "learned that it was possible to control Volfyirion, the dreadful dragon inhabiting the ruins"
                       + " of Kyradar. The desire to gain complete dominion over the powerful beast resulted in a "
                       + "conflict between the two forces, who were ready to employ any means necessary to stop the other."
                       + " Their Cities are now nearly completely besieged while the battles rage on. Everyone tries to "
                       + "do their part: troops are stationed at the high walls, scouts venture to the ruins of Kyradar, "
                       + "civilians build anew what was destroyed, and scholars research forbidden tomes. However, the war "
                       + "is far from being over, because as long as a single enemy City is still standing, neither House"
                       + " will ever surrender. ")
        }
    }

    // 3
    Item {
        height: 48
    }

    // 4
    ColumnLayout {
        id: _contents
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 216
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 48

            text: qsTr("contents")
        }

        GridView {
            id: _grid

            cellWidth: root.width / 2
            cellHeight: 200

            Layout.preferredHeight: Math.ceil(_contentsModel.count / 2) * 200
            Layout.fillWidth: true

            model: RulebookContentsModel {
                id: _contentsModel
            }

            delegate: RulebookCardDelegate {
                width: _grid.cellWidth
                height: _grid.cellHeight

                source: model.source
                title: model.title
                description: model.description
            }
        }
    }

    // 5
    Item {
        height: 48
    }

    // 6
    ColumnLayout {
        id: _extra
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 216
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 48

            text: qsTr("extra cards")
        }

        GridView {
            id: _extraGrid

            cellWidth: root.width / 2
            cellHeight: 200

            Layout.preferredHeight: Math.ceil(_extraCardsModel.count / 2) * 200
            Layout.fillWidth: true

            model: RulebookExtraCardsModel {
                id: _extraCardsModel
            }

            delegate: RulebookCardDelegate {
                width: _extraGrid.cellWidth
                height: _extraGrid.cellHeight

                source: model.source
                title: model.title
                description: model.description
            }
        }
    }

    // 7
    Item {
        height: 48
    }

    // 8
    ColumnLayout {
        id: _gameOverview
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.bottomMargin: 48

            text: qsTr("game overview")
        }

        RulebookText {
            Layout.fillWidth: true
            text: qsTr(
                      "In Volfyirion, each player represents one of two Houses of Mysthea."
                      + " The goal is to defeat the other player by destroying all of their "
                      + "Cities. This is done by playing cards to gain points which can be "
                      + "spent to deploy strategic assets and to attack. Players gain resources "
                      + "and take actions by playing cards from their personal decks, which are "
                      + "upgraded with additional cards during the course of a game.")

            Layout.bottomMargin: 20
        }

        RulebookSubtitle {
            Layout.preferredWidth: 216
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 20

            text: qsTr("how to win")
        }

        RulebookText {
            text: qsTr("A player immediately wins the game after destroying all enemy Cities.")

            Layout.fillWidth: true
            Layout.bottomMargin: 20
        }
    }

    // 9
    Item {
        height: 28
    }

    // 10
    ColumnLayout {
        id: _gameSetup
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.bottomMargin: 48

            text: qsTr("game setup")
        }

        RulebookText {
            text: qsTr(
                      "Players sit across from each other. A player’s deck is called House Deck."
                      + " At the start of the game it is composed of ten Command Cards: eight "
                      + "Prospector, one Captain, and one Diviner.")

            Layout.fillWidth: true
            Layout.bottomMargin: 20
        }

        Image {
            source: "qrc:/assets/starting_composition.png"
            fillMode: Image.PreserveAspectFit

            Layout.preferredHeight: 127
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.bottomMargin: 20
        }

        RulebookText {
            text: qsTr("Both players shuffle their own House Deck then place it in front of themselves.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            Image {
                source: "qrc:/assets/troop_icon.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
            }
            Image {
                source: "qrc:/assets/building_icon.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
            }
            Image {
                source: "qrc:/assets/command_icon.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
            }
        }

        RulebookText {
            text: qsTr("Shuffle all Troop, Building and the remaining Command Cards to form the Asset Deck.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            Image {
                source: "qrc:/assets/wonder_icon.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
            }
        }

        RulebookText {
            text: qsTr("Shuffle all Wonder Cards together to form the Wonder Deck. "
                       + "Asset and Wonder Decks are shared between players.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("Place the Asset Deck face down on the side of the gaming area. "
                       + "Asset Deck’s top card is always flipped face up.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("NOTE: To add a bit more of unpredictability to the game, keep "
                       + "the Asset Deck’s top card face down during the game.")

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                opacity: 0.3
            }

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            inputMethodHints: Qt.ImhMultiLine
            text: qsTr("Draw the top five cards from the Asset Deck and place them face"
                       + " up in a row to form the “Asset Row”.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Place the Volfyirion’s Lair Card face up at the end of the Asset Row. "
                      + "Put the Volfyirion Token on the Volfyirion’s Lair Card. ")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Place the Wonder Deck face down next to the Volfyirion’s Lair Card. "
                      + "Draw cards until you reveal two that cost no more than 3 Battle Points each, "
                      + "then place them on the spaces of the Volfyirion’s Lair Card, face up. "
                      + "Put the other revealed cards, if any, on the bottom of the Wonder Deck.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Each player has three City Cards which represent vital strategic points to defend." + " Cities have a Defence Value of 8, 9, and 10. Players arrange their three Cities "
                      + "in a line in front of them, which forms the “Cities Area”.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "The two players have both a “Discard Area” and a “Playing Area”. Discarded Cards "
                      + "are stacked in a Pile in the respective Discard Area. ")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "NOTE: In Volfyirion, “Discard” and “Remove” are two different operations. "
                      + "Removed cards (and tokens) leave the game and are put back into the box.")

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                opacity: 0.3
            }

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }
    }

    // 11
    Item {
        height: 28
    }

    // 12
    ColumnLayout {
        id: _cards
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.bottomMargin: 48

            text: qsTr("cards")
        }
    }

    // 13
    ColumnLayout {
        id: _commandBattlePoints
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 216
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 20

            text: qsTr("command, battle and\nknowledge points")
            wrapMode: Text.Wrap
            font.pixelSize: 14
        }

        RulebookText {
            text: qsTr("Cards in the game provide three resources that can be used in multiple ways.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            Image {
                source: "qrc:/assets/command.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 114
                Layout.preferredHeight: 114
            }
        }

        RulebookText {
            text: qsTr("Command Points are used by players to:")
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("- Acquire cards from the Asset Row")
            Layout.leftMargin: 8
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("- Redeploy Troops between Cities.")
            Layout.bottomMargin: 15
            Layout.leftMargin: 8
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Players Gain Command Points by Playing Command Cards or through "
                      + "In-Play cards such as Building Cards and Wonder Cards.")
            Layout.bottomMargin: 28
            Layout.fillWidth: true
        }
    }

    // 14
    ColumnLayout {
        id: _commandBuildingTroop
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 216
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 20

            text: qsTr("command, building and\ntroop cards")
            wrapMode: Text.Wrap
            font.pixelSize: 14
        }

        RulebookText {
            text: qsTr("The banner in the upper left corner represents the color of a Minor House.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("The grey banner represents cards that are considered neutral.")
            Layout.fillWidth: true
        }

        RowLayout {
            spacing: 0
            Image {
                source: "qrc:/assets/flag_red.png"
                fillMode: Image.PreserveAspectFit
                Layout.fillWidth: true
                Layout.preferredHeight: 333
            }
            Image {
                source: "qrc:/assets/flag_blue.png"
                fillMode: Image.PreserveAspectFit
                Layout.fillWidth: true
                Layout.preferredHeight: 333
            }
            Image {
                source: "qrc:/assets/flag_purple.png"
                fillMode: Image.PreserveAspectFit
                Layout.fillWidth: true
                Layout.preferredHeight: 333
            }
            Image {
                source: "qrc:/assets/flag_grey.png"
                fillMode: Image.PreserveAspectFit
                Layout.fillWidth: true
                Layout.preferredHeight: 333
            }
        }

        RulebookText {
            text: qsTr("Command and Building Cards grant you Points via their Main Ability.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("The majority of cards also have a Secondary Ability (explained at p. 27).")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Whenever you Play a Building Card, you need to choose the relative slot "
                      + "in a City (see City Cards at p. 14) to place the card. If there is already " + "another Building Card on the Building slot, the previously placed Building "
                      + "Card is removed from the game and replaced by the new one.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Whenever you Play a Troop Card, you need to choose the relative slot in a "
                      + "City to place the card. If there is already another Troop Card on the Troop " + "slot, the previously placed Troop Card is removed from the game and replaced " + "by the new one.")
            Layout.bottomMargin: 28
            Layout.fillWidth: true
        }
    }

    // 15
    ColumnLayout {
        id: _actions
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 216
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 20

            text: qsTr("actions")
            wrapMode: Text.Wrap
        }

        RulebookText {
            text: qsTr("acquire a wonder card")
            font.capitalization: Font.AllUppercase
            font.bold: true
            font.pixelSize: 18
            font.letterSpacing: 1
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "To Acquire a Wonder Card from the Volfyirion’s Lair, you must pay the amount " + "of Battle Points depicted on the Wonder Card’s Cost icon. The newly acquired " + "card is immediately moved to your Discard Pile. The empty space on the Volfyirion’s "
                      + "Lair Card is not refilled until the End of a Turn Phase.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        Image {
            source: "qrc:/assets/volf_display_app_2.png"
            fillMode: Image.PreserveAspectFit

            Layout.preferredHeight: 320
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.bottomMargin: 20
        }

        Image {
            source: "qrc:/assets/volf_display_app_3.png"
            fillMode: Image.PreserveAspectFit

            Layout.preferredHeight: 320
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.bottomMargin: 20
        }

        RulebookText {
            text: qsTr(
                      "Following the example from p. 19, Player 1 places the Elite Trooper Card "
                      + "and the Apothecary Card [A] in two of their cities [B]. Then decides to "
                      + "Acquire cards by spending the Points they just gained. With 5 Command Points, "
                      + "they Acquire Suicide Mission for 3CP [C] and Hidden Cache for 2CP [D]. "
                      + "For 2 Battle Points, they Acquire Sharp Qoam [E]. These new cards are put "
                      + "directly onto the Discard Pile [F]. The player is left with 1 Battle Point "
                      + "and 6 Knowledge Points to spend for other actions.")
            Layout.bottomMargin: 28
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("seal/unseal a wonder card")
            font.capitalization: Font.AllUppercase
            font.bold: true
            font.pixelSize: 18
            font.letterSpacing: 1
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You may Seal or Unseal a Wonder Card in either Playing Area by paying the "
                      + "equivalent of the card’s Cost in Knowledge Points, as reminded by the icon " + "on each Wonder Card.")
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.bottomMargin: 15
            Layout.alignment: Qt.AlignHCenter

            Image {
                source: "qrc:/assets/tap_icon.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
            }
        }

        RulebookText {
            text: qsTr(
                      "When you Seal a card, rotate it on one side. When a Wonder is sealed, "
                      + "neither of its Abilities may be used until it is unsealed. You may only "
                      + "Unseal cards that are sealed. Rotate them back to vertical position to "
                      + "represent this.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("All Wonders are put into play “Unsealed”.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        Pane {
            Layout.fillWidth: true
            Layout.bottomMargin: 15

            background: Rectangle {
                color: "#90433b"
                opacity: 0.3
            }

            ColumnLayout {
                spacing: 0
                anchors.fill: parent

                RulebookText {
                    text: qsTr("Unsealed wonder")
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                    font.underline: true
                    font.pixelSize: 20

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Image {
                    source: "qrc:/assets/wn02.png"
                    fillMode: Image.PreserveAspectFit

                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    Layout.preferredHeight: 153
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr("Sealed wonder")
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                    font.underline: true
                    font.pixelSize: 20

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Image {
                    source: "qrc:/assets/wn02.png"
                    fillMode: Image.PreserveAspectFit
                    rotation: 90

                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    Layout.preferredHeight: 153
                }
            }
        }

        ColumnLayout {
            spacing: 0

            RulebookText {
                text: qsTr("secondary abilities effects are listed below")
                wrapMode: Text.Wrap
                font.capitalization: Font.AllUppercase
                font.bold: true
                font.pixelSize: 18
                font.letterSpacing: 1
                horizontalAlignment: Text.AlignHCenter

                Layout.fillWidth: true
                Layout.bottomMargin: 15
            }

            RulebookText {
                text: qsTr("Draw a card")
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.underline: true
                font.pixelSize: 20

                Layout.fillWidth: true
                Layout.bottomMargin: 15
            }

            Image {
                source: "qrc:/assets/icon_draw_card.png"
                fillMode: Image.PreserveAspectFit

                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.preferredHeight: 105
                Layout.bottomMargin: 15
            }

            RulebookText {
                text: qsTr("Remove a card")
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.underline: true
                font.pixelSize: 20

                Layout.fillWidth: true
                Layout.bottomMargin: 15
            }

            Image {
                source: "qrc:/assets/icon_remove_card.png"
                fillMode: Image.PreserveAspectFit

                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.preferredHeight: 105
                Layout.bottomMargin: 20
            }
        }
    }

    // 16
    Item {
        height: 28
    }

    // 17
    ColumnLayout {
        id: _extraCards
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.bottomMargin: 48

            text: qsTr("extra cards")
        }

        RulebookSubtitle {
            Layout.preferredWidth: 216
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 28

            text: qsTr("game variants")
        }

        Pane {
            Layout.fillWidth: true
            Layout.bottomMargin: 28
            clip: true

            background: Item {
                opacity: 0.3

                Image {
                    anchors.fill: parent
                    source: "qrc:/assets/veteran_background.png"
                    fillMode: Image.PreserveAspectCrop
                }
            }

            ColumnLayout {
                anchors.fill: parent

                RulebookText {
                    text: qsTr("mercenary troop cards (x4)")
                    horizontalAlignment: Text.AlignHCenter
                    font.capitalization: Font.AllUppercase
                    font.bold: true
                    font.underline: true
                    font.pixelSize: 20
                    color: "#FACDAA"

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr(
                              "During setup, shuffle them into the Asset Deck. "
                              + "Just like a standard Troop, a Mercenary Card adds its Defence Value "
                              + "to the one of the City it is guarding. If a legit Attack a City "
                              + "action is performed against a City guarded by a Mercenary, first "
                              + "shuffle the Mercenary Troop Card back into the Asset Deck, then destroy the City.")

                    Layout.fillWidth: true
                }
            }
        }

        Pane {
            Layout.fillWidth: true
            clip: true

            background: Item {
                opacity: 0.3

                Image {
                    anchors.fill: parent
                    source: "qrc:/assets/event_background.png"
                    fillMode: Image.PreserveAspectCrop
                }
            }

            ColumnLayout {
                anchors.fill: parent

                RulebookText {
                    text: qsTr("ascension path wonder cards (x2)")
                    horizontalAlignment: Text.AlignHCenter
                    font.capitalization: Font.AllUppercase
                    font.bold: true
                    font.underline: true
                    font.pixelSize: 20
                    color: "#FACDAA"

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr(
                              "During setup, shuffle them into the Wonder Deck. Ascension Path "
                              + "cannot be Sealed by any means. You may pay to move the Card from "
                              + "your opponent’s Playing Area to yours, gaining control of it.")

                    Layout.fillWidth: true
                }
            }
        }
    }

    // 18
    Item {
        height: 28
    }
}
