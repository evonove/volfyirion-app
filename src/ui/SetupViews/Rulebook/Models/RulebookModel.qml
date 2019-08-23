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

    // element: 0
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
            width: 193
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

    // element: 1
    Item {
        height: 48
    }

    // element: 2 - Introduction
    ColumnLayout {
        id: _introduction
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.bottomMargin: 27

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
            wrapMode: Text.WordWrap
        }
    }

    // element: 3
    Item {
        height: 48
    }

    // element: 4 - Contents Card
    ColumnLayout {
        id: _contents
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 216
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 16

            text: qsTr("contents")
        }

        GridLayout {
            id: _contentsGrid
            columns: 2
            columnSpacing: 0
            rowSpacing: 0

            Layout.fillWidth: true

            Repeater {
                model: RulebookContentsModel {
                    id: _contentsModel
                }

                delegate: RulebookCardDelegate {
                    source: model.source
                    title: model.title
                    description: model.description

                    Layout.fillWidth: true
                    Layout.preferredHeight: 200
                }
            }
        }
    }

    // element: 5
    Item {
        height: 48
    }

    // element: 6 - Extra Cards
    ColumnLayout {
        id: _extra
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 216
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 16

            text: qsTr("extra cards")
        }

        GridLayout {
            id: _extraGrid
            columns: 2
            rowSpacing: 0
            columnSpacing: 0
            Layout.fillWidth: true

            Repeater {
                model: RulebookExtraCardsModel {
                    id: _extraCardsModel
                }

                delegate: RulebookCardDelegate {
                    source: model.source
                    title: model.title
                    description: model.description

                    Layout.fillWidth: true
                    Layout.preferredHeight: 200
                }
            }
        }
    }

    // element: 7
    Item {
        height: 48
    }

    // element: 8
    ColumnLayout {
        id: _gameOverview
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.bottomMargin: 27

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
            wrapMode: Text.WordWrap
        }

        RulebookText {
            text: qsTr("how to win")
            wrapMode: Text.WordWrap
            font.bold: true
            font.capitalization: Font.AllUppercase

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("A player immediately wins the game after destroying all enemy Cities.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }
    }

    // element: 9
    Item {
        height: 48
    }

    // element: 10
    ColumnLayout {
        id: _gameSetup
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.bottomMargin: 27

            text: qsTr("game setup")
        }

        RulebookText {
            text: qsTr(
                      "Players sit across from each other. A player’s deck is called House Deck."
                      + " At the start of the game it is composed of ten Command Cards: eight "
                      + "Prospector, one Captain, and one Diviner.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        Image {
            source: "qrc:/assets/rulebook/03_game-setup/game-setup_composition.png"
            fillMode: Image.PreserveAspectFit

            Layout.preferredHeight: 141
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("Both players shuffle their own House Deck then place it in front of themselves.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("Shuffle all Troop, Building and the remaining Command Cards to form the Asset Deck.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        GridLayout {
            columns: 3
            columnSpacing: 20

            Layout.leftMargin: 26
            Layout.rightMargin: 26
            Layout.alignment: Qt.AlignHCenter

            Image {
                source: "qrc:/assets/rulebook/03_game-setup/troop-icon.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 1

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }

            Image {
                source: "qrc:/assets/rulebook/03_game-setup/building-icon.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 1

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }

            Image {
                source: "qrc:/assets/rulebook/03_game-setup/command-icon.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 1

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }

            RulebookText {
                text: qsTr("troop card")
                font.capitalization: Font.AllUppercase
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter

                Layout.fillWidth: true
                Layout.preferredWidth: 1
            }

            RulebookText {
                text: qsTr("building card")
                font.capitalization: Font.AllUppercase
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter

                Layout.fillWidth: true
                Layout.preferredWidth: 1
            }

            RulebookText {
                text: qsTr("command card")
                font.capitalization: Font.AllUppercase
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter

                Layout.fillWidth: true
                Layout.preferredWidth: 1
            }
        }

        RulebookText {
            text: qsTr("Shuffle all Wonder Cards together to form the Wonder Deck. Asset and Wonder Decks are shared between players.")
            wrapMode: Text.WordWrap


            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 26
            Layout.rightMargin: 26
            Layout.alignment: Qt.AlignHCenter

            Image {
                id: img
                source: "qrc:/assets/rulebook/03_game-setup/wonders-icon.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 43
                Layout.preferredHeight: 43

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }

            RulebookText {
                id: wonder
                text: qsTr("wonder card")
                font.capitalization: Font.AllUppercase

                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter

                Layout.preferredWidth: 83
                Layout.alignment: Qt.AlignHCenter
            }
        }

        RulebookText {
            text: qsTr("Place the Asset Deck face down on the side of the gaming area. "
                       + "Asset Deck’s top card is always flipped face up.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("NOTE: To add a bit more of unpredictability to the game, keep "
                       + "the Asset Deck’s top card face down during the game.")
            font.letterSpacing: 0.05
            wrapMode: Text.WordWrap
            leftPadding: 17
            rightPadding: 17
            topPadding: 15
            bottomPadding: 15

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            inputMethodHints: Qt.ImhMultiLine
            text: qsTr("Draw the top five cards from the Asset Deck and place them face"
                       + " up in a row to form the “Asset Row”.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Place the Volfyirion’s Lair Card face up at the end of the Asset Row. "
                      + "Put the Volfyirion Token on the Volfyirion’s Lair Card. ")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Place the Wonder Deck face down next to the Volfyirion’s Lair Card. "
                      )
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Draw cards until you reveal two that cost no more than 3 Battle Points each, "
                      + "then place them on the spaces of the Volfyirion’s Lair Card, face up. "
                      + "Put the other revealed cards, if any, on the bottom of the Wonder Deck.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Each player has three City Cards which represent vital strategic points to defend." + " Cities have a Defence Value of 8, 9, and 10. Players arrange their three Cities "
                      + "in a line in front of them, which forms the “Cities Area”.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "The two players have both a “Discard Area” and a “Playing Area”. Discarded Cards "
                      + "are stacked in a Pile in the respective Discard Area. ")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "NOTE: In Volfyirion, “Discard” and “Remove” are two different operations. "
                      + "Removed cards (and tokens) leave the game and are put back into the box.")
            wrapMode: Text.WordWrap
            leftPadding: 17
            rightPadding: 17
            topPadding: 15
            bottomPadding: 15

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }

            Layout.fillWidth: true
        }
    }

    // element: 11
    Item {
        height: 48
    }

    // element: 12
    ColumnLayout {
        id: _cards
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.bottomMargin: 27

            text: qsTr("cards")
        }
    }

    // element: 13
    ColumnLayout {
        id: _commandBattlePoints
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 16

            text: qsTr("command, battle and knowledge points")
            wrapMode: Text.WordWrap
            font.pixelSize: 16
        }

        RulebookText {
            text: qsTr("Cards in the game provide three resources that can be used in multiple ways.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        // Command
        ColumnLayout {
            width: root.width
            spacing: 0

            Layout.alignment: Qt.AlignHCenter

            Image {
                source: "qrc:/assets/rulebook/04_cards_chpt/command-big_1.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 61
                Layout.preferredHeight: 61

                Layout.alignment: Qt.AlignHCenter
            }
            RulebookText {
                text: qsTr("command points")
                font.capitalization: Font.AllUppercase
                horizontalAlignment: Text.AlignHCenter

                Layout.fillWidth: false
                Layout.alignment: Qt.AlignHCenter
            }
        }

        RulebookText {
            text: qsTr("Command Points are used by players to:")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("- Acquire cards from the Asset Row")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 0
        }

        RulebookText {
            text: qsTr("- Redeploy Troops between Cities.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.topMargin: 0
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "Players Gain Command Points by Playing Command Cards or through "
                      + "In-Play cards such as Building Cards and Wonder Cards.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        // Battle
        ColumnLayout {
            width: root.width
            spacing: 0

            Layout.alignment: Qt.AlignHCenter

            Image {
                source: "qrc:/assets/rulebook/04_cards_chpt/attack-big_1.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 61
                Layout.preferredHeight: 61

                Layout.alignment: Qt.AlignHCenter
            }
            RulebookText {
                text: qsTr("battle points")
                font.capitalization: Font.AllUppercase
                horizontalAlignment: Text.AlignHCenter

                Layout.alignment: Qt.AlignHCenter
            }
        }

        RulebookText {
            text: qsTr("Battle Points are used by players to:")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("- Acquire Wonder Cards from Volfyirion’s Lair")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("- Attack a City")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Players Gain Battle Points by Playing Command Cards or through"
                      + " In-Play cards such as Building Cards, Troop Cards, and Wonder Cards.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        // Knowledge
        ColumnLayout {
            width: root.width
            spacing: 0

            Layout.alignment: Qt.AlignHCenter

            Image {
                source: "qrc:/assets/rulebook/04_cards_chpt/experience-big_1.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 61
                Layout.preferredHeight: 61

                Layout.alignment: Qt.AlignHCenter
            }
            RulebookText {
                text: qsTr("Knowledge points")
                font.capitalization: Font.AllUppercase
                horizontalAlignment: Text.AlignHCenter

                Layout.alignment: Qt.AlignHCenter
            }
        }

        RulebookText {
            text: qsTr("Knowledge Points are used by players to:")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("- Seal/Unseal Wonder Cards in both Playing Areas")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("- Replace a card in the Asset Row with a new one")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("- Move the Volfyirion Token from the Lair Card to an enemy "
                       + "City or from an owned City to the Lair Card")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Players Gain Knowledge Points by Playing Command Cards or "
                      + "through In-Play cards such as Building Cards, Troop Cards, and Wonder Cards.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }
    }

    // element: 14
    Item {
        height: 48
    }

    // element: 15
    ColumnLayout {
        id: _commandBuildingTroop
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 16

            text: qsTr("command, building and troop cards")
            wrapMode: Text.Wrap
            font.pixelSize: 16
        }

        Image {
            source: "qrc:/assets/rulebook/04_cards_chpt/command-b-t-cards.png"
            fillMode: Image.PreserveAspectFit

            Layout.preferredWidth: 287
            Layout.bottomMargin: 27
            Layout.alignment: Qt.AlignHCenter
        }


        RulebookText {
            text: qsTr(
                      "The banner in the upper left corner represents the color of a Minor House. " +
                      "The grey banner represents cards that are considered neutral.")

            topPadding: _flagsImg.height
            leftPadding: 17
            rightPadding: 17
            bottomPadding: 15

            Layout.bottomMargin: 15

            background: Item {
                implicitWidth: 100
                implicitHeight: 100

                Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    color: "#eeeeee"
                    opacity: 0.3
                    radius: 12
                }
                Image {
                    id: _flagsImg
                    anchors.topMargin: 0
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter

                    source: "qrc:/assets/rulebook/04_cards_chpt/flags.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        RulebookText {
            text: qsTr("Command and Building Cards grant you Points via their Main Ability.")
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("The majority of cards also have a Secondary Ability (explained later).")
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Whenever you Play a Building Card, you need to choose the relative slot "
                      + "in a City (see City Cards) to place the card. If there is already "
                      + "another Building Card on the Building slot, the previously placed Building "
                      + "Card is removed from the game and replaced by the new one.")
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Whenever you Play a Troop Card, you need to choose the relative slot in a "
                      + "City to place the card. If there is already another Troop Card on the Troop "
                      + "slot, the previously placed Troop Card is removed from the game and replaced "
                      + "by the new one.")
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "A Troop Card adds its Defence to the Defence Value of the City where it is placed.")
            Layout.fillWidth: true
        }
    }

    // element: 16
    Item {
        height: 48
    }

    // element: 17
    ColumnLayout {
        id: _wonder
        width: root.width
        spacing: 0


        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 35

            text: qsTr("wonder cards")
            wrapMode: Text.WordWrap
        }

       Image {
           source: "qrc:/assets/rulebook/04_cards_chpt/wonder.png"
           fillMode: Image.PreserveAspectFit

           Layout.preferredWidth: 218
           Layout.bottomMargin: 15
           Layout.alignment: Qt.AlignHCenter
       }

        RulebookText {
            text: qsTr("Wonder Cards do not have House colors.")
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Whenever you Acquire a Wonder Card you may immediately remove from "
                      + "the game another card from your Discard Pile, from your hand (no Points "
                      + "will be gained from it), or from your Playing Area (after having gained "
                      + "the card Points).")
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "This is indicated by the following icon:")
            Layout.fillWidth: true
        }

        Image {
            source: "qrc:/assets/rulebook/04_cards_chpt/WONDER-DISCAR-ICON.png"
            fillMode: Image.PreserveAspectFit

            Layout.preferredWidth: 61
            Layout.alignment: Qt.AlignHCenter
        }
    }

    // element: 18
    Item {
        height: 48
    }

    // element: 19
    ColumnLayout {
        id: _cityCards
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 35

            text: qsTr("city cards")
            wrapMode: Text.WordWrap
        }

        Image {
            source: "qrc:/assets/rulebook/04_cards_chpt/city.png"
            fillMode: Image.PreserveAspectFit

            Layout.preferredWidth: 248
            Layout.bottomMargin: 15
            Layout.alignment: Qt.AlignHCenter
        }

        RulebookText {
            text: qsTr("City Cards’ Defence Value is displayed in the upper right corner.")
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "The slot for Troop Cards is on the bottom left, the slot for Building "
                      + "Cards is on the bottom right.")
            Layout.fillWidth: true
        }
    }

    // element: 20
    Item {
        height: 48
    }

    // element: 21
    ColumnLayout {
        id: _inPlayCards
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 35

            text: qsTr("in-play cards")
            wrapMode: Text.WordWrap
        }

        RulebookText {
            text: qsTr("Most cards you play are usually discarded onto the Discard Pile "
                       + "by the End of a Turn. Some cards though are not discarded: Building, "
                       + "Troop, and Wonder Cards remain In-Play and continue to provide you "
                       + "their Main Ability Points during each of your turns’ Main Phases, as "
                       + "long as they are not destroyed or sealed.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Secondary Abilities do also benefit from this same rule and if the "
                      + "requirements are met they may be triggered every turn.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }
    }

    // element: 22
    Item {
        height: 48
    }

    // element: 23
    ColumnLayout {
        id: _howToPlay
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.bottomMargin: 35

            text: qsTr("how to play")
        }

        RulebookText {
            text: qsTr("The player who has most recently seen a dragon, real or fictional, goes first.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("Each player’s turn has 3 Phases. When these 3 Phases are completed,"
                       + " the other player may take their turn. The 3 Phases are:")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("1. Draw Phase")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("2. Main Phase")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("3. End of a Turn")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }
    }

    // element: 24
    Item {
        height: 48
    }

    // element: 25
    ColumnLayout {
        id: _drawPhase
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 35

            text: qsTr("draw phase")
            wrapMode: Text.Wrap
        }

        RulebookText {
            text: qsTr(
                      "Draw five cards from your House Deck.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }


        RulebookText {
            text: qsTr(
                      " NOTE: Only on their first turn, a player may decide to "
                      + "shuffle their starting hand back into the House Deck, then "
                      + "Draw five new cards.")
            wrapMode: Text.WordWrap
            leftPadding: 17
            rightPadding: 17
            topPadding: 15
            bottomPadding: 15

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "During a game, there will often be no cards left to Draw "
                      + "from the House Deck, both during Draw and/or Main Phases. In either "
                      + "Phase, when this happens, shuffle back your Discard Pile into a new "
                      + "House Deck, then Draw the cards you need.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "During a turn Main Phase, if you played all of your cards and "
                      + "there are no more cards left in both the House Deck and the Discard "
                      + "Pile, you will have to continue your turn only with the cards currently"
                      + " in the Playing Area and Cities Area.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      " NOTE: Acquired cards are always put onto the Discard Pile."
                      + " When shuffled back they enhance your House Deck.")
            wrapMode: Text.WordWrap
            leftPadding: 17
            rightPadding: 17
            topPadding: 15
            bottomPadding: 15

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }
            Layout.fillWidth: true
        }
    }

    // element: 26
    Item {
        height: 48
    }

    // element: 27
    ColumnLayout {
        id: _mainPhase
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 35

            text: qsTr("main phase")
            wrapMode: Text.Wrap
        }

        RulebookText {
            text: qsTr(
                      "During the Main Phase you may perform any of the following "
                      + "actions, in any order, as many times as you like:")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "- Play a card from your hand")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- Gain Points from a card")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- Use Command Points to Acquire an Asset Card*")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- Use Command Points to Redeploy a Troop")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- Use Battle Points to Attack a City")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- Use Battle Points to Acquire a Wonder Card*")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "-Use Knowledge Points to Seal/Unseal a Wonder Card")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- Use Knowledge Points to Replace a card in the Asset Row")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- Use Knowledge Points to Move Volfyirion")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- Activate a card’s Secondary Ability")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "*Acquired cards are always put on top of your Discard Pile.")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "As special action, once per game, one of the players may be able to:")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "- Use Battle Points to Defeat Volfyirion")
            wrapMode: Text.WordWrap
            padding: 0

            Layout.fillWidth: true
        }
}

    // element: 28
    Item {
        height: 48
    }

    // element: 29
    ColumnLayout {
        id: _actions
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 35

            text: qsTr("actions")
            wrapMode: Text.Wrap
        }

        RulebookText {
            id: _playACardSubchapter
            text: qsTr(
                      "PLAY A CARD FROM YOUR HAND")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Playing a card means to put it down from your hand into "
                      + "the Playing Area. This is the core mechanic of the game and has"
                      + " no cost. Unplayed cards are kept in your hand and will be "
                      + "discarded to the Discard Pile during the End of a Turn Phase.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "When performing this action, Building and Troop Cards must be assigned"
                      + " to an available slot of your Cities.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            id: _gainPointsSubchapter
            text: qsTr(
                      "GAIN POINTS FROM A CARD")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You Gain as many Command Points, Battle Points, and Knowledge Points as "
                      + "depicted by a card’s Main Ability. You can Gain Points only from cards "
                      + "in your Playing Area or in your Cities Area. ")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You may Gain Points from every card In-Play from previous turns in both "
                      + "Playing and Cities Areas, such as Wonder and Building Cards. ")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You may still Gain Points from cards that are about to leave either "
                      + "Playing or Cities Area, regardless of them being either discarded or "
                      + "removed from the game.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You can Gain Points from a card ability only once per turn.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        Pane {
            id: _noteSection
            Layout.fillWidth: true
            Layout.bottomMargin: 15

            background: Rectangle {
                color: "#eeeeee"
                radius: 12
                opacity: 0.3
            }
            ColumnLayout {
                width: parent.width
                spacing: 0

                RulebookText {
                    text: qsTr(
                              "NOTE: You can Play cards one at the time to trigger specific effects"
                              + " in a precise order. As an example, you may:")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              " 1. Play a card that triggers a Building’s Secondary Ability.")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "2. Gain all bonuses (from both cards).")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "3. Put In-Play a new Building (removing the old one from the game while doing so).")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              " 4. Gain all bonuses from the new Building.")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }
            }
        }

        Pane {
            id: _secondNoteSection
            Layout.fillWidth: true
            Layout.bottomMargin: 15

            background: Rectangle {
                color: "#eeeeee"
                radius: 12
                opacity: 0.1
            }
            ColumnLayout {
                width: parent.width
                spacing: 0

                Image {
                    source: "qrc:/assets/rulebook/05_how-to-play/points-card.png"
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.preferredWidth: 288
                    Layout.alignment: Qt.AlignHCenter

                    Layout.topMargin: 15
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr(
                              "Player 1 has played five cards and gains the following Points "
                              + "from the Main Abilities: ")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr(
                              "- 5 Command Points - 1 from Prospector, 1 from Diviner, "
                              + "1 from Apothecary, 2 from Flawless Deploy.")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "- 3 Battle Points - 3 from Flawless Deploy.")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "- 6 Knowledge Points - 3 from Diviner, 1 from Apothecary, 2 from Flawless Deploy.")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr(
                              "No Secondary Abilities’ Synergy Chains are triggered.")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }
            }
        }

        RulebookText {
            id: _acquireAssetsSubchapter
            text: qsTr(
                      "ACQUIRE AN ASSET CARD")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "To Acquire an Asset Card from the Asset Row you must pay the amount of Command "
                      + "Points depicted on the card’s Cost icon. The newly acquired card is immediately "
                      + "moved onto the Discard Pile. The empty space in the Asset Row is not refilled "
                      + "until the End of a Turn Phase. ")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        Pane {
            id: _acquireNoteSection
            Layout.fillWidth: true
            Layout.bottomMargin: 15

            background: Rectangle {
                color: "#eeeeee"
                radius: 12
                opacity: 0.3
            }
            ColumnLayout {
                width: parent.width
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                spacing: 0

                RulebookText {
                    text: qsTr(
                              "NOTE: Only during their first turn and before acquiring any card:")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr(
                              " - The player who goes first may freely discard a single card in "
                              + "the Asset Row to the bottom of the Asset Deck, then refill the Asset "
                              + "Row with the card at the top of the Deck.")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr(
                              "- The player who goes second may freely discard all cards in the Asset"
                              + " Row to the bottom of the Asset Deck, then refill the Asset Row with "
                              + "another five cards from the top of the Deck.")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }
            }
        }

        RulebookText {
            id: _redeployTroopSubchapter
            text: qsTr(
                      "REDEPLOY A TROOP CARD")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You may pay the cost of an In-Play Troop Card to reassign it"
                      + " to one of your other Cities.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            id: _attackCitySubchapter
            text: qsTr(
                      "ATTACK A CITY")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Attacking a City without a Troop Card: you must spend Battle "
                      + "Points equal to the City’s Defence Value. Resolution: the City "
                      + "is destroyed. Then, if a Building Card is present, remove it "
                      + "from the game. Lastly, flip the City Card on the other side "
                      + "to show that it has been destroyed.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Attacking a City guarded by a Troop Card: you must spend Battle "
                      + "Points equal to the City’s Defence Value plus the stationed Troop’s "
                      + "Defence Value. Resolution: the Troop Card is removed from the game "
                      + "but the City is safe.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            id: _attackCityNoteSection
            text: qsTr(
                      "NOTE: If you have enough Battle Points, you may Attack a City guarded by a "
                      + "Troop twice in a row. First to destroy the Troop Card, then to destroy the "
                      + "City itself while unguarded.")

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                radius: 12
                opacity: 0.3
            }

            wrapMode: Text.WordWrap
            leftPadding: 16
            rightPadding: 16

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            id: _acquireWonderSubchapter
            text: qsTr(
                      "ACQUIRE A WONDER CARD")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "To Acquire a Wonder Card from the Volfyirion’s Lair, you must pay the amount "
                      + "of Battle Points depicted on the Wonder Card’s Cost icon. The newly acquired "
                      + "card is immediately moved to your Discard Pile. The empty space on the "
                      + "Volfyirion’s Lair Card is not refilled until the End of a Turn Phase.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        Pane {
            id: _acquirWonderSection
            Layout.fillWidth: true
            Layout.bottomMargin: 15

            background: Rectangle {
                color: "#eeeeee"
                radius: 12
                opacity: 0.1
            }
            ColumnLayout {
                width: parent.width
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                spacing: 8

                Image {
                    source: "qrc:/assets/rulebook/05_how-to-play/volf_display_app_3.png"
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.preferredWidth: 323
                    Layout.alignment: Qt.AlignHCenter
                }
                Image {
                    source: "qrc:/assets/rulebook/05_how-to-play/volf_display_app_2.png"
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.preferredWidth: 323
                    Layout.alignment: Qt.AlignHCenter
                }

                RulebookText {
                    text: qsTr(
                              "Following the example from p. 19, Player 1 places the Elite Trooper Card and "
                              + "the Apothecary Card [A] in two of their cities [B]. Then decides to Acquire "
                              + "cards by spending the Points they just gained.")
                    wrapMode: Text.WordWrap
                    topPadding: 5
                    padding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "With 5 Command Points, they Acquire Suicide Mission for 3CP [C] and Hidden "
                              + "Cache for 2CP [D].")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "For 2 Battle Points, they Acquire Sharp Qoam [E].")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "These new cards are put directly onto the Discard Pile [F].")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "The player is left with 1 Battle Point and 6 Knowledge Points to spend for "
                              + "other actions.")
                    wrapMode: Text.WordWrap
                    padding: 0

                    Layout.fillWidth: true
                }
            }
        }

        RulebookText {
            id: _defeatVolfySubchapter
            text: qsTr(
                      "DEFEAT VOLFYIRION")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You may pay 16 Battle Points to Defeat Volfyirion.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "If you manage to accomplish this incredible feat, immediately remove the "
                      + "Volfyirion Token from the game, then gain the Wonders on its Lair Card, "
                      + "if any left. After that, you also claim the Volfyirion’s Lair Card as a "
                      + "new City: take the Lair and place it in your Cities Area. Owning the Lair "
                      + "also provides you 4 Battle Points during each and every Main Phase.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "When the Lair is claimed, it is no longer possible to either Acquire Wonders "
                      + "nor Move Volfyirion until the end of the game.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }


        RulebookText {
            id: _sealWonderSubchapter
            text: qsTr(
                      "SEAL/UNSEAL A WONDER CARD")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You may Seal or Unseal a Wonder Card in either Playing Area by paying "
                      + "the equivalent of the card’s Cost in Knowledge Points, as reminded by the icon on "
                      + "each Wonder Card:")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        Image {
            source: "qrc:/assets/rulebook/05_how-to-play/SEAL-WONDER.png"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            Layout.preferredWidth: 61
            Layout.preferredHeight: 61
            Layout.alignment: Qt.AlignHCenter
        }

        RulebookText {
            text: qsTr(
                      "When you Seal a card, rotate it on one side. When a Wonder is sealed, neither "
                      + "of its Abilities may be used until it is unsealed.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You may only Unseal cards that are sealed. Rotate them back to vertical "
                      + "position to represent this.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "All Wonders are put into play “Unsealed”.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        Pane {
            id: _sealSection
            Layout.fillWidth: true
            Layout.bottomMargin: 15

            background: Rectangle {
                color: "#eeeeee"
                radius: 12
                opacity: 0.1
            }

            ColumnLayout {
                width: parent.width
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                spacing: 0

                Image {
                    source: "qrc:/assets/rulebook/05_how-to-play/seal-unseal.png"
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.preferredWidth: 296
                    Layout.alignment: Qt.AlignHCenter
                }

                RulebookText {
                    text: qsTr(
                              " Sealed Wonder (left),")
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    bottomPadding: 0

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }

                RulebookText {
                    text: qsTr(
                              "Unsealed Wonder (right).")
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    topPadding: 0

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

        RulebookText {
            id: _replaceCardSubchapter
            text: qsTr(
                      "REPLACE A CARD IN THE ASSET ROW")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You may pay 2 Knowledge Points to Replace a card in the Asset Row with the top "
                      + "card of the Asset Deck. The discarded card goes on the bottom of the Asset Deck. "
                      + "The new card is immediately available to be acquired.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "You may not fill an empty space of the Asset Row this way.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Tip: you should replace cards before Acquiring from the Asset Row.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            id: _moveVolfySubchapter
            text: qsTr(
                      "MOVE VOLFYIRION")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }
        ColumnLayout {
            Layout.fillWidth: true
            Layout.bottomMargin: 15
            spacing: 0

            RulebookText {
                text: qsTr(
                          "You may pay 8 Knowledge Points to Move the Volfyirion Token.")
                wrapMode: Text.WordWrap
                bottomPadding: 0

                Layout.fillWidth: true
            }

            RulebookText {
                text: qsTr(
                          "The dragon can only perform two kinds of movements:")
                wrapMode: Text.WordWrap
                topPadding: 0

                Layout.fillWidth: true
                Layout.bottomMargin: 15
            }

            RulebookText {
                text: qsTr(
                          "- From the Volfyirion’s Lair Card over an enemy City.")
                wrapMode: Text.WordWrap
                bottomPadding: 0

                Layout.fillWidth: true
            }

            RulebookText {
                text: qsTr(
                          "- From one of your Cities back onto the Volfyirion’s Lair Card.")
                wrapMode: Text.WordWrap
                topPadding: 0

                Layout.fillWidth: true
                Layout.bottomMargin: 15
            }

            RulebookText {
                text: qsTr(
                          " If you have enough points, you may perform both movements in the same turn.")
                wrapMode: Text.WordWrap

                Layout.fillWidth: true
                Layout.bottomMargin: 15
            }

            RulebookText {
                text: qsTr(
                          "During your opponent’s next End of a Turn Phase, if Volfyirion is not repelled "
                          + "or defeated, it will destroy the enemy City you moved it onto and everything"
                          + " on top of it.")
                wrapMode: Text.WordWrap

                Layout.fillWidth: true
                Layout.bottomMargin: 15
            }

            RulebookText {
                text: qsTr(
                          "(See the “End of a Turn Phase” paragraph for more details.)")
                wrapMode: Text.WordWrap

                Layout.fillWidth: true
            }
        }

        Image {
            source: "qrc:/assets/rulebook/05_how-to-play/MOVE-VOLFYIRION.png"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            Layout.preferredWidth: 255
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 15
        }

        RulebookText {
            id: _activateSecondAbilitySubchapter
            text: qsTr(
                      "ACTIVATE A CARD’S SECONDARY ABILITY")
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "The Secondary Ability of a card offers you additional bonuses. It can be activated"
                      + " at any time during your Main Phases if its conditions are met.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "During each turn, a card’s Secondary Ability can only be triggered once.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "1. The Synergy Chain Abilities")
            wrapMode: Text.WordWrap
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Some cards display a set of icons called the Synergy Chain. To trigger "
                      + "the Synergy Chain you need to check if there are other cards which match "
                      + "the color requirements, in both your Playing and Cities Areas (Buildings and "
                      + "Troops colors count).")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "If the requirements are met, you Gain all the depicted bonuses.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "NOTE: A card’s color does not count for its own Synergy Chain.")
            wrapMode: Text.WordWrap
            leftPadding: 26
            rightPadding: 26

            background:Rectangle {
                implicitHeight: 82
                implicitWidth: 323
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }

            Layout.fillWidth: true
            Layout.bottomMargin: 25
        }

        Image {
            source: "qrc:/assets/rulebook/05_how-to-play/SINERGY_1.png"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            Layout.preferredWidth: 323
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "The Synergy Chain is triggered when there is at least a turquoise card in "
                      + "Playing Area or in Cities Area. The player gains 2 Knowledge Points.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 25
        }

        Image {
            source: "qrc:/assets/rulebook/05_how-to-play/SINERGY_2.png"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            Layout.preferredWidth: 323
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "The Synergy Chain is triggered when there is at least a turquoise card in "
                      + "Playing Area or in Cities Area. The player gains 2 Knowledge Points.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "2. Remove Abilities")
            wrapMode: Text.WordWrap
            font.bold: true

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Some cards, like the Wonders and Troops, have a Remove Ability. During the Main Phase, "
                      + "you may decide to Remove such cards from the game to gain the depicted bonus. You still "
                      + "Gain the Main Ability Points before the card gets removed from the game this way. You "
                      + "may also decide to Remove a card from the game just to thin your House Deck.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 25
        }

        Image {
            source: "qrc:/assets/rulebook/05_how-to-play/sinergy_3.png"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            Layout.preferredWidth: 323
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "The Player may decide to use the Remove Ability of this card, gaining 3 Knowledge "
                      + "Points for that turn but permanently removing the card from the game.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "SECONDARY ABILITIES EFFECTS ARE LISTED BELOW:")
            wrapMode: Text.WordWrap
            font.bold: true
            font.capitalization: Font.AllUppercase

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "NOTE: You may decide to only partially gain the depicted bonus or to completely ignore"
                      + " the bonus offered by a card.")
            wrapMode: Text.WordWrap
            leftPadding: 26
            rightPadding: 26

            background:Rectangle {
                implicitHeight: 82
                implicitWidth: 323
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("Draw a Card")
            wrapMode: Text.WordWrap
            font.bold: true

            Layout.fillWidth: true
        }

        Image {
            source: "qrc:/assets/rulebook/05_how-to-play/icon_raw1card-b.png"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            Layout.preferredWidth: 155
            Layout.alignment: Qt.AlignHCenter
        }

        RulebookText {
            text: qsTr("Draw a card from your House Deck. You may Play it this turn.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("Remove a Card")
            wrapMode: Text.WordWrap
            font.bold: true

            Layout.fillWidth: true
        }

        Image {
            source: "qrc:/assets/rulebook/05_how-to-play/icon_remove_1card.png"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            Layout.preferredWidth: 155
            Layout.alignment: Qt.AlignHCenter
        }

        RulebookText {
            text: qsTr("Choose any card from either your Playing Area, your Discard Pile, or your hand. The "
                       + "chosen card is immediately removed from the game.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("Remove a Troop")
            wrapMode: Text.WordWrap
            font.bold: true

            Layout.fillWidth: true
        }

        Image {
            source: "qrc:/assets/rulebook/05_how-to-play/icon_remove_troop.png"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            Layout.preferredWidth: 155
            Layout.alignment: Qt.AlignHCenter
        }

        RulebookText {
            text: qsTr("Choose any card from either your Playing Area, your Discard Pile, or your hand. The "
                       + "chosen card is immediately removed from the game.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("Remove a Building")
            wrapMode: Text.WordWrap
            font.bold: true

            Layout.fillWidth: true
        }

        Image {
            source: "qrc:/assets/rulebook/05_how-to-play/icon_remove_building.png"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            Layout.preferredWidth: 155
            Layout.alignment: Qt.AlignHCenter
        }

        RulebookText {
            text: qsTr("Choose a Building in an enemy City: that Building is destroyed and its card is removed "
                       + "from the game.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("Move Volfyirion")
            wrapMode: Text.WordWrap
            font.bold: true

            Layout.fillWidth: true
        }

        Image {
            source: "qrc:/assets/rulebook/05_how-to-play/icon_move_volf-b.png"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            Layout.preferredWidth: 155
            Layout.alignment: Qt.AlignHCenter
        }

        RulebookText {
            text: qsTr("You may immediately perform a Move Volfyirion action.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }
    }

    // element: 30
    Item {
        height: 48
    }

    // element: 31
    ColumnLayout {
        id: _endTurnPhase
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 35

            text: qsTr("end of a turn")
            wrapMode: Text.Wrap
        }

        RulebookText {
            text: qsTr(
                      "When you are done performing actions, the End of a Turn Phase begins.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Follow the steps below in order.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- Except for Wonders, every card in the Playing Area is discarded onto the Discard Pile.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "NOTE: Buildings and Troops are in the Cities Area.")
            wrapMode: Text.WordWrap
            leftPadding: 16
            rightPadding: 16

            background: Rectangle {
                implicitHeight: 84
                implicitWidth: 323
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "- Discard all unplayed cards from your hand.")
            wrapMode: Text.WordWrap
            bottomPadding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- All unspent Points are lost")
            wrapMode: Text.WordWrap
            topPadding: 0
            bottomPadding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- If the Volfyirion Token is on one of your opponent’s Cities, leave it there.")
            wrapMode: Text.WordWrap
            topPadding: 0
            bottomPadding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- If the Volfyirion Token is on one of your Cities, that city is destroyed by the "
                      + "creature’s wrath! Turn face down that City Card. Any Building Card or Troop Card on "
                      + "top of it is also removed from the game. Then Move the Volfyirion Token back to its "
                      + "Lair Card.")
            wrapMode: Text.WordWrap
            topPadding: 0
            bottomPadding: 0

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "- Refill all the empty spaces in the Asset Row and on Volfyirion’s Lair Card with new "
                      + "cards drawn from the appropriate decks.")
            wrapMode: Text.WordWrap
            topPadding: 0
            bottomPadding: 0

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(
                      "Finally, end your turn.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

    }

}
