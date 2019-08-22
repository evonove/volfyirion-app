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

    // 2
    ColumnLayout {
        id: _introduction
        width: root.width
        spacing: 0

        RulebookTitle {
            Layout.fillWidth: true
            Layout.topMargin: 60
            Layout.bottomMargin: 35

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
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 48

            text: qsTr("contents")
        }

        GridLayout {
            id: _contentsGrid
            columns: 2
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
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 48

            text: qsTr("extra cards")
        }

        GridLayout {
            id: _extraGrid
            columns: 2
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
            Layout.bottomMargin: 35

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

            Layout.preferredHeight: 127
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("Both players shuffle their own House Deck then place it in front of themselves.")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr("Shuffle all Troop, Building and the remaining Command Cards to form the Asset Deck.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        GridLayout {
            columns: 3
            columnSpacing: 30

            Layout.leftMargin: 30
            Layout.rightMargin: 30
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

            Label {
                text: qsTr("troop card")
                font.pixelSize: 18
                font.capitalization: Font.AllUppercase
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter

                Layout.fillWidth: true
                Layout.preferredWidth: 1
            }

            Label {
                text: qsTr("building card")
                font.pixelSize: 18
                font.capitalization: Font.AllUppercase
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter

                Layout.fillWidth: true
                Layout.preferredWidth: 1
            }

            Label {
                text: qsTr("command card")
                font.pixelSize: 18
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
            Layout.leftMargin: 30
            Layout.rightMargin: 30
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

            Label {
                id: wonder
                text: qsTr("wonder card")
                font.pixelSize: 18
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

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }

            Layout.bottomMargin: 27
            Layout.fillWidth: true
        }

        RulebookText {
            inputMethodHints: Qt.ImhMultiLine
            text: qsTr("Draw the top five cards from the Asset Deck and place them face"
                       + " up in a row to form the “Asset Row”.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 10
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Place the Volfyirion’s Lair Card face up at the end of the Asset Row. "
                      + "Put the Volfyirion Token on the Volfyirion’s Lair Card. ")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 10
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Place the Wonder Deck face down next to the Volfyirion’s Lair Card. "
                      )
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 10
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Draw cards until you reveal two that cost no more than 3 Battle Points each, "
                      + "then place them on the spaces of the Volfyirion’s Lair Card, face up. "
                      + "Put the other revealed cards, if any, on the bottom of the Wonder Deck.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 10
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Each player has three City Cards which represent vital strategic points to defend." + " Cities have a Defence Value of 8, 9, and 10. Players arrange their three Cities "
                      + "in a line in front of them, which forms the “Cities Area”.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 10
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "The two players have both a “Discard Area” and a “Playing Area”. Discarded Cards "
                      + "are stacked in a Pile in the respective Discard Area. ")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 10
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "NOTE: In Volfyirion, “Discard” and “Remove” are two different operations. "
                      + "Removed cards (and tokens) leave the game and are put back into the box.")
            wrapMode: Text.WordWrap

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }

            Layout.bottomMargin: 32
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
            Layout.bottomMargin: 35

            text: qsTr("cards")
        }
    }

    // 13
    ColumnLayout {
        id: _commandBattlePoints
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 20

            text: qsTr("command, battle and knowledge points")
            wrapMode: Text.WordWrap
            font.pixelSize: 14
        }

        RulebookText {
            text: qsTr("Cards in the game provide three resources that can be used in multiple ways.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        // Command
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 12

            Image {
                source: "qrc:/assets/rulebook/04_cards_chpt/command-big_1.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 61
                Layout.preferredHeight: 61

                Layout.alignment: Qt.AlignHCenter
            }
            Label {
                text: qsTr("command points")
                font.capitalization: Font.AllUppercase
                font.pixelSize: 18

                Layout.alignment: Qt.AlignHCenter
            }
        }

        RulebookText {
            text: qsTr("Command Points are used by players to:")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("- Acquire cards from the Asset Row")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("- Redeploy Troops between Cities.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Players Gain Command Points by Playing Command Cards or through "
                      + "In-Play cards such as Building Cards and Wonder Cards.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 28
            Layout.fillWidth: true
        }

        // Battle
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 12

            Image {
                source: "qrc:/assets/rulebook/04_cards_chpt/attack-big_1.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 61
                Layout.preferredHeight: 61

                Layout.alignment: Qt.AlignHCenter
            }
            Label {
                text: qsTr("battle points")
                font.capitalization: Font.AllUppercase
                font.pixelSize: 18

                Layout.alignment: Qt.AlignHCenter
            }
        }

        RulebookText {
            text: qsTr("Battle Points are used by players to:")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
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

            Layout.bottomMargin: 28
            Layout.fillWidth: true
        }

        // Knowledge
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 12

            Image {
                source: "qrc:/assets/rulebook/04_cards_chpt/experience-big_1.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 61
                Layout.preferredHeight: 61

                Layout.alignment: Qt.AlignHCenter
            }
            Label {
                text: qsTr("Knowledge points")
                font.capitalization: Font.AllUppercase
                font.pixelSize: 18

                Layout.alignment: Qt.AlignHCenter
            }
        }

        RulebookText {
            text: qsTr("Knowledge Points are used by players to:")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
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

            Layout.bottomMargin: 60
            Layout.fillWidth: true
        }
    }

    // 14
    ColumnLayout {
        id: _commandBuildingTroop
        width: root.width
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 20

            text: qsTr("command, building and troop cards")
            wrapMode: Text.Wrap
            font.pixelSize: 14
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
            leftPadding: 28
            rightPadding: 28
            bottomPadding: 21

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

            RulebookText {
                text: qsTr("Command and Building Cards grant you Points via their Main Ability.")
                Layout.bottomMargin: 15
                Layout.fillWidth: true
            }

            Layout.bottomMargin: 32
        }

        RulebookText {
            text: qsTr("Command and Building Cards grant you Points via their Main Ability.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr("The majority of cards also have a Secondary Ability (explained later).")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Whenever you Play a Building Card, you need to choose the relative slot "
                      + "in a City (see City Cards) to place the card. If there is already "
                      + "another Building Card on the Building slot, the previously placed Building "
                      + "Card is removed from the game and replaced by the new one.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Whenever you Play a Troop Card, you need to choose the relative slot in a "
                      + "City to place the card. If there is already another Troop Card on the Troop "
                      + "slot, the previously placed Troop Card is removed from the game and replaced "
                      + "by the new one.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "A Troop Card adds its Defence to the Defence Value of the City where it is placed.")
            Layout.bottomMargin: 60
            Layout.fillWidth: true
        }
    }

    // 15
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
           Layout.bottomMargin: 28
           Layout.alignment: Qt.AlignHCenter
       }

        RulebookText {
            text: qsTr("Wonder Cards do not have House colors.")
            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Whenever you Acquire a Wonder Card you may immediately remove from "
                      + "the game another card from your Discard Pile, from your hand (no Points "
                      + "will be gained from it), or from your Playing Area (after having gained "
                      + "the card Points).")
            Layout.bottomMargin: 15
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
            Layout.bottomMargin: 60
            Layout.alignment: Qt.AlignHCenter
        }
    }

    // 16
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
            Layout.bottomMargin: 28
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
            Layout.bottomMargin: 60
            Layout.fillWidth: true
        }
    }

    // 17
    ColumnLayout {
        id: _inPlayCards
        Layout.fillWidth: true
        spacing: 0

        RulebookSubtitle {
            Layout.preferredWidth: 317
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 20

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

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }

        RulebookText {
            text: qsTr(
                      "Secondary Abilities do also benefit from this same rule and if the "
                      + "requirements are met they may be triggered every turn.")
            wrapMode: Text.WordWrap

            Layout.bottomMargin: 60
            Layout.fillWidth: true
        }
    }


    // How To Play section
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
            Layout.bottomMargin: 15
        }

        RulebookText {
            text: qsTr(" Each player’s turn has 3 Phases. When these 3 Phases are completed,"
                       + " the other player may take their turn. The 3 Phases are:")
            wrapMode: Text.WordWrap

            Layout.fillWidth: true
            Layout.bottomMargin: 15
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
            Layout.bottomMargin: 60
        }
    }

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

            Layout.bottomMargin: 15
            Layout.fillWidth: true
        }


        RulebookText {
            text: qsTr(
                      " NOTE: Only on their first turn, a player may decide to "
                      + "shuffle their starting hand back into the House Deck, then "
                      + "Draw five new cards.")
            wrapMode: Text.WordWrap

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }

            Layout.bottomMargin: 32
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
            Layout.bottomMargin: 15
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

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#eeeeee"
                opacity: 0.3
                radius: 12
            }

            Layout.bottomMargin: 32
            Layout.fillWidth: true
        }
    }
}
