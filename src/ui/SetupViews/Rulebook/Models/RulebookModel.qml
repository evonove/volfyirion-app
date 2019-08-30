import QtQml.Models 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

import ".."
import Volfy.Controls 1.0

Item {
    id: root

    // Default color
    readonly property string primaryNotePaneColor: "#eeeeee"
    readonly property string secondaryNotePaneColor: "#4C2628"
    readonly property string extraCardsPaneColor: "#B58022"

    property real contentMargins: 0

    signal downloadAreaClicked()

    property var searchable: []

    readonly property alias status: _loader.status
    readonly property alias model: _loader.item

    function initSearchable(model, results) {
        for(let i = 0; i < model.count; i++) {
            let node = model.get(i);
            searchableNodesInTree(node, results)
        }
    }

    function searchableNodesInTree(node, results) {
        if (!node) {
            return
        }

        if (node instanceof TextField) {
            results.push(node)
        }

        for(let i = 0; i < node.children.length; i++) {
            searchableNodesInTree(node.children[i], results)
        }
    }

    Loader {
        id: _loader
        sourceComponent: _comp
        asynchronous: true
        onLoaded: {
            console.log("Start Indexing")
            root.initSearchable(_loader.item, root.searchable)
            console.log("Finished Indexing")
        }
    }

    Component {
        id: _comp

        ObjectModel {
            id: _model

            // element: 0
            Item {
                width: root.width
                height: _background.paintedHeight

                Image {
                    id: _background
                    asynchronous: true
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
                    asynchronous: true
                    width: 226
                    fillMode: Image.PreserveAspectFit

                    source: "qrc:/assets/rulebook/logo.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 72
                }

                Image {
                    id: userImg
                    asynchronous: true
                    width: 193
                    fillMode: Image.PreserveAspectFit

                    sourceSize.height: 86
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
                    asynchronous: true
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
                        asynchronous: true
                        fillMode: Image.PreserveAspectFit
                        Layout.preferredWidth: 1

                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Image {
                        source: "qrc:/assets/rulebook/03_game-setup/building-icon.png"
                        asynchronous: true
                        fillMode: Image.PreserveAspectFit
                        Layout.preferredWidth: 1

                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Image {
                        source: "qrc:/assets/rulebook/03_game-setup/command-icon.png"
                        asynchronous: true
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
                        asynchronous: true
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
                        color: root.primaryNotePaneColor
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
                        color: root.primaryNotePaneColor
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
                        asynchronous: true
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
                        asynchronous: true
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
                        asynchronous: true
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
                    asynchronous: true
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
                            color: root.primaryNotePaneColor
                            opacity: 0.3
                            radius: 12
                        }
                        Image {
                            id: _flagsImg
                            asynchronous: true
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
                    asynchronous: true
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
                    asynchronous: true
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
                    asynchronous: true
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
                        color: root.primaryNotePaneColor
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
                        color: root.primaryNotePaneColor
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

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "- Gain Points from a card")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "- Use Command Points to Acquire an Asset Card*")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "- Use Command Points to Redeploy a Troop")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "- Use Battle Points to Attack a City")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "- Use Battle Points to Acquire a Wonder Card*")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "-Use Knowledge Points to Seal/Unseal a Wonder Card")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "- Use Knowledge Points to Replace a card in the Asset Row")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "- Use Knowledge Points to Move Volfyirion")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(
                              "- Activate a card’s Secondary Ability")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr(
                              "*Acquired cards are always put on top of your Discard Pile.")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr(
                              "As special action, once per game, one of the players may be able to:")
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr(
                              "- Use Battle Points to Defeat Volfyirion")
                    wrapMode: Text.WordWrap

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
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 17
                    rightPadding: 17

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.primaryNotePaneColor
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

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "2. Gain all bonuses (from both cards).")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "3. Put In-Play a new Building (removing the old one from the game while doing so).")
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      " 4. Gain all bonuses from the new Building.")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }
                    }
                }

                Pane {
                    id: _secondNoteSection
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 17
                    rightPadding: 17

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.1
                    }
                    ColumnLayout {
                        width: parent.width
                        spacing: 0

                        Image {
                            source: "qrc:/assets/rulebook/05_how-to-play/points-card.png"
                            asynchronous: true
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

                            Layout.fillWidth: true
                            Layout.bottomMargin: 15
                        }

                        RulebookText {
                            text: qsTr(
                                      "- 5 Command Points - 1 from Prospector, 1 from Diviner, "
                                      + "1 from Apothecary, 2 from Flawless Deploy.")
                            wrapMode: Text.WordWrap
                            bottomPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "- 3 Battle Points - 3 from Flawless Deploy.")
                            wrapMode: Text.WordWrap
                            topPadding: 0
                            bottomPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "- 6 Knowledge Points - 3 from Diviner, 1 from Apothecary, 2 from Flawless Deploy.")
                            wrapMode: Text.WordWrap
                            topPadding: 0
                            bottomPadding: 0

                            Layout.fillWidth: true
                            Layout.bottomMargin: 15
                        }

                        RulebookText {
                            text: qsTr(
                                      "No Secondary Abilities’ Synergy Chains are triggered.")
                            wrapMode: Text.WordWrap

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
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 17
                    rightPadding: 17

                    Layout.fillWidth: true

                    background: Rectangle {
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.3
                    }
                    ColumnLayout {
                        width: parent.width
                        spacing: 0

                        RulebookText {
                            text: qsTr(
                                      "NOTE: Only during their first turn and before acquiring any card:")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      " - The player who goes first may freely discard a single card in "
                                      + "the Asset Row to the bottom of the Asset Deck, then refill the Asset "
                                      + "Row with the card at the top of the Deck.")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "- The player who goes second may freely discard all cards in the Asset"
                                      + " Row to the bottom of the Asset Deck, then refill the Asset Row with "
                                      + "another five cards from the top of the Deck.")
                            wrapMode: Text.WordWrap

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
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.3
                    }

                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 17
                    rightPadding: 17
                    wrapMode: Text.WordWrap

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
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 17
                    rightPadding: 17

                    Layout.fillWidth: true

                    background: Rectangle {
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.1
                    }
                    ColumnLayout {
                        width: parent.width
                        spacing: 8

                        Image {
                            source: "qrc:/assets/rulebook/05_how-to-play/volf_display_app_3.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.preferredWidth: 323
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Image {
                            source: "qrc:/assets/rulebook/05_how-to-play/volf_display_app_2.png"
                            asynchronous: true
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

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "With 5 Command Points, they Acquire Suicide Mission for 3CP [C] and Hidden "
                                      + "Cache for 2CP [D].")
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "For 2 Battle Points, they Acquire Sharp Qoam [E].")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "These new cards are put directly onto the Discard Pile [F].")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "The player is left with 1 Battle Point and 6 Knowledge Points to spend for "
                                      + "other actions.")
                            wrapMode: Text.WordWrap

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
                    asynchronous: true
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
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 17
                    rightPadding: 17

                    Layout.fillWidth: true

                    background: Rectangle {
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.1
                    }

                    ColumnLayout {
                        width: parent.width
                        spacing: 0

                        Image {
                            source: "qrc:/assets/rulebook/05_how-to-play/seal-unseal.png"
                            asynchronous: true
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
                    asynchronous: true
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
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 17
                    rightPadding: 17

                    background:Rectangle {
                        implicitHeight: 82
                        implicitWidth: 323
                        color: root.primaryNotePaneColor
                        opacity: 0.3
                        radius: 12
                    }

                    Layout.fillWidth: true
                    Layout.bottomMargin: 25
                }

                Image {
                    source: "qrc:/assets/rulebook/05_how-to-play/SINERGY_1.png"
                    asynchronous: true
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
                    asynchronous: true
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
                    asynchronous: true
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
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 17
                    rightPadding: 17

                    background:Rectangle {
                        implicitHeight: 82
                        implicitWidth: 323
                        color: root.primaryNotePaneColor
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
                    asynchronous: true
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
                    asynchronous: true
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
                    asynchronous: true
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
                    asynchronous: true
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
                    asynchronous: true
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
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 17
                    rightPadding: 17

                    background: Rectangle {
                        implicitHeight: 84
                        implicitWidth: 323
                        color: root.primaryNotePaneColor
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
                    topPadding: 0
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

            // element: 32
            Item {
                height: 48
            }

            // element: 33
            ColumnLayout {
                id: _extraCards
                width: root.width
                spacing: 0

                RulebookTitle {
                    Layout.fillWidth: true
                    Layout.bottomMargin: 27

                    text: qsTr("extra cards")
                }
            }

            // element: 34
            ColumnLayout {
                id: _gameVariants
                width: root.width
                spacing: 0

                RulebookSubtitle {
                    Layout.preferredWidth: 317
                    Layout.preferredHeight: 45
                    Layout.alignment: Qt.AlignCenter
                    Layout.bottomMargin: 16

                    text: qsTr("game variants")
                    wrapMode: Text.WordWrap
                    font.pixelSize: 16
                }

                RulebookText {
                    text: qsTr("Here is a list of additional cards to provide players with further layers "
                               + "of challenge. We highly recommend to add these variants only once you "
                               + "have mastered the classic game.")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Each set of cards come with its own rules and is independent from the "
                               + "others. Feel free to combine more than one to enhance your experience.")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                // MERCENARY TROOP CARDS
                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 22
                    rightPadding: 22

                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight + topPadding + bottomPadding
                    Layout.alignment: Qt.AlignHCenter

                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.extraCardsPaneColor
                        opacity: 0.2
                        radius: 12
                    }

                    contentItem: ColumnLayout {
                        width: parent.width
                        spacing: 0

                        RulebookText {
                            text: qsTr("MERCENARY TROOP CARDS (x4)")
                            font.capitalization: Font.AllUppercase
                            font.pixelSize: 23
                            font.bold: true

                            leftPadding: 0

                            color: "#FACDAA"
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("During setup, shuffle them into the Asset Deck.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Just like a standard Troop, a Mercenary Card adds "
                                       + "its Defence Value to the one of the City it is guarding.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("If a legit Attack a City action is performed against a City "
                                       + "guarded by a Mercenary, first shuffle the Mercenary Troop "
                                       + "Card back into the Asset Deck, then destroy the City.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }
                    }
                }

                // ASCENSION PATH WONDER CARDS
                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 22
                    rightPadding: 22

                    implicitHeight: 336

                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight + topPadding + bottomPadding
                    Layout.alignment: Qt.AlignHCenter

                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.extraCardsPaneColor
                        opacity: 0.2
                        radius: 12
                    }

                    contentItem: ColumnLayout {
                        width: parent.width
                        RulebookText {
                            text: qsTr("ASCENSION PATH WONDER CARDS (x2)")
                            font.capitalization: Font.AllUppercase
                            font.pixelSize: 23
                            font.bold: true

                            leftPadding: 0
                            rightPadding: 0

                            color: "#FACDAA"
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("During setup, shuffle them into the Wonder Deck. Ascension Path cannot be Sealed"
                                       + " by any means.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("You may pay")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        Image {
                            source: "qrc:/assets/rulebook/06_extra-cards/ASCENSION-PATH-ICON.png"
                            asynchronous: true

                            Layout.preferredWidth: 61
                            Layout.preferredHeight: 61
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RulebookText {
                            text: qsTr("to move the Card from your opponent’s Playing Area to yours, gaining control of it.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }
                    }
                }

                // SABOTEUR COMMAND CARDS (x2)
                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 22
                    rightPadding: 22

                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight + topPadding + bottomPadding
                    Layout.alignment: Qt.AlignHCenter

                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.extraCardsPaneColor
                        opacity: 0.2
                        radius: 12
                    }
                    contentItem: ColumnLayout {
                        width: parent.width
                        spacing: 0

                        RulebookText {
                            text: qsTr("SABOTEUR COMMAND CARDS (x2)")
                            font.capitalization: Font.AllUppercase
                            font.pixelSize: 23
                            font.bold: true

                            leftPadding: 0
                            rightPadding: 0

                            color: "#FACDAA"
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("During setup, shuffle them into the Asset Deck.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("When you Acquire a Saboteur Card from the Asset Row, place it onto "
                                       + "the opponent’s Discard Pile.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Saboteur Cards are unremovable by other cards’ effects "
                                       + "(e.g.: Wonders).")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }
                    }
                }

                // PERK CARDS
                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 22
                    rightPadding: 22

                    implicitHeight: 828

                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight + topPadding + bottomPadding
                    Layout.alignment: Qt.AlignHCenter

                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.extraCardsPaneColor
                        opacity: 0.2
                        radius: 12
                    }

                    contentItem: ColumnLayout {
                        width: parent.width
                        spacing: 0

                        RulebookText {
                            text: qsTr("PERK CARDS (x4)")
                            font.capitalization: Font.AllUppercase
                            font.pixelSize: 23
                            font.bold: true

                            leftPadding: 0
                            rightPadding: 0

                            color: "#FACDAA"
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Perk Cards are meant to provide an asymmetrical experience.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("During setup, shuffle them and randomly deal one to each player. Both cards"
                                       + " are immediately revealed and placed aside the respective Playing Areas.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Perk Cards provide ongoing effects for an entire game, and are unremovable"
                                       + " by any means.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("QOAM ARMORY")
                            font.capitalization: Font.AllUppercase
                            font.bold: true

                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("You may perform the Defeat Volfyirion action by spending just 14 Battle Points.")
                            wrapMode: Text.WordWrap

                            topPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("ANOMALY COLLIDER")
                            font.capitalization: Font.AllUppercase
                            font.bold: true

                            wrapMode: Text.WordWrap

                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Once per turn you may Seal one of your Wonder Cards to immediately "
                                       + "Gain Knowledge Points equal to the Wonder Card’s cost.")
                            wrapMode: Text.WordWrap

                            topPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("QOAM ORACLE")
                            font.capitalization: Font.AllUppercase
                            font.bold: true

                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("You may Acquire the top card of the Asset Deck as if it were part "
                                       + "of the Asset Row.")
                            wrapMode: Text.WordWrap

                            topPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("HEROES PARTY")
                            font.capitalization: Font.AllUppercase
                            font.bold: true

                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("You may spend 4 Battle Points to Acquire the Wonder Deck’s top card "
                                       + "without paying its cost.")
                            wrapMode: Text.WordWrap

                            topPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }
                    }
                }

                // PLOY CARDS
                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 22
                    rightPadding: 22

                    implicitHeight: 1365

                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight + topPadding + bottomPadding
                    Layout.alignment: Qt.AlignHCenter

                    background: Rectangle {
                        color: root.extraCardsPaneColor
                        opacity: 0.2
                        radius: 12
                    }

                    contentItem: ColumnLayout {
                        width: parent.width
                        spacing: 0

                        RulebookText {
                            text: qsTr("PLOY CARDS (x6)")
                            font.capitalization: Font.AllUppercase
                            font.pixelSize: 23
                            font.bold: true

                            leftPadding: 0
                            rightPadding: 0

                            color: "#FACDAA"
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Ploy Cards are meant to provide an asymmetrical experience.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("During setup, shuffle them and randomly deal one to each "
                                       + "player. Keep your card secret from your opponent. ")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("A Ploy Card is immediately triggered upon meeting a certain condition, "
                                       + "even during your opponent’s turn. As soon as the requirement is met, "
                                       + "reveal the card and resolve its effect. After that, remove the triggered "
                                       + "Ploy Card from the game.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                            Layout.bottomMargin: 10
                        }

                        RulebookText {
                            text: qsTr("MIRAGE CITY")
                            font.capitalization: Font.AllUppercase
                            font.bold: true

                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Requirement: The opponent Moves Volfyirion over one of your Cities.")
                            wrapMode: Text.WordWrap

                            topPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Effect: Immediately Move Volfyirion back to the Volfyirion’s Lair Card.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("DOUBLE SHIFT")
                            font.capitalization: Font.AllUppercase
                            font.bold: true

                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Requirement: The opponent performs their first Attack action against "
                                       + "one of your Cities. Effect: For this turn, raise the Defence of your"
                                       + " City by 2 Defence Points. Battle Points spent by your opponent "
                                       + "are lost.")
                            wrapMode: Text.WordWrap

                            topPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                            Layout.bottomMargin: 10
                        }

                        RulebookText {
                            text: qsTr("QOAM INSTABILITY")
                            font.capitalization: Font.AllUppercase
                            font.bold: true

                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Requirement: There are two In-Play Buildings Cards across the two Cities Areas.")
                            wrapMode: Text.WordWrap

                            topPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Effect: Immediately destroy both Buildings currently In-Play.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("AFTERTHOUGHT")
                            font.capitalization: Font.AllUppercase
                            font.bold: true

                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Requirement: There are two In-Play Troop Cards across the two Cities Areas.")
                            wrapMode: Text.WordWrap

                            topPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Effect: Immediately destroy both Troops currently In-Play.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("CRYSTALLIZATION")
                            font.capitalization: Font.AllUppercase
                            font.bold: true

                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Requirement: There are three In-Play Wonder Cards across the two Playing Areas.")
                            wrapMode: Text.WordWrap

                            topPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Effect: Immediately destroy all three Wonder Cards currently In-Play.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("SECOND CHANCE")
                            font.capitalization: Font.AllUppercase
                            font.bold: true

                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Requirement: Your opponent uses the Remove Ability of a Troop Card"
                                       + " to Attack one of your Cities.")
                            wrapMode: Text.WordWrap

                            topPadding: 0
                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Effect: You may immediately recover that Troop Card and place it "
                                       + "onto one of your Cities.")
                            wrapMode: Text.WordWrap

                            leftPadding: 0
                            rightPadding: 0

                            Layout.fillWidth: true
                        }
                    }
                }
            }

            // element: 35
            Item {
                height: 48
            }

            // element: 36
            ColumnLayout {
                id: _extraRules
                width: root.width
                spacing: 0

                RulebookTitle {
                    Layout.fillWidth: true
                    Layout.bottomMargin: 27

                    text: qsTr("extra rules")
                }

                RulebookText {
                    text: qsTr("EXTENDED GAME MODE - REBUILDING CITIES")
                    font.capitalization: Font.AllUppercase
                    font.bold: true

                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                    Layout.preferredWidth: 323
                }

                RulebookText {
                    text: qsTr("To rebuild a City, spend the amount of Points shown on its destroyed side, "
                               + "then flip the City Card on its pristine side. If that City gets destroyed "
                               + "a second time, remove that City Card from the game.")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }
                RulebookText {
                    text: qsTr("Finally, end your turn.")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("VOLFYIRION - BACK")
                    font.capitalization: Font.AllUppercase
                    font.bold: true

                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                    Layout.preferredWidth: 323
                }

                RulebookText {
                    text: qsTr("Use the backside of the Volfyirion’s Lair Card when playing the 2vs2 "
                               + "Team mode. Please consider that this mode requires two copies of "
                               + "the game.")
                    wrapMode: Text.WordWrap

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Image {
                    source: "qrc:/assets/rulebook/divider_final.png"
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }

                Pane {
                    leftPadding: 15
                    rightPadding: 15
                    topPadding: 17
                    bottomPadding: 17

                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight + topPadding + bottomPadding
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        opacity: 0.1
                        radius: 12
                    }

                    ColumnLayout {
                        width: parent.width
                        spacing: 0

                        RulebookText {
                            text: qsTr("If you want to expand your gameplay experience, try one of the special rules below!")
                            font.letterSpacing: 0.5
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Qt.AlignHCenter

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Face Volfyirion alone in Solo Play, ask a friend for help with the Co-op mode, "
                                       + "join forces with the 2vs2 Team mode, or experiment with all the other extra "
                                       + "rules available! ")
                            font.letterSpacing: 0.5
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Qt.AlignHCenter

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("All downloadable Volfyirion rulebooks (PDF) available at: ")
                            font.letterSpacing: 0.5
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Qt.AlignHCenter

                            Layout.fillWidth: true
                        }

                        Label {
                            id: _link
                            text: qsTr("https://mysthea.tabula.games/volfyirion/extra-rules")
                            font.pixelSize: 18
                            font.underline: true
                            wrapMode: Text.WordWrap

                            horizontalAlignment: Qt.AlignHCenter

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter

                            MouseArea {
                                anchors.fill: _link
                                onClicked: Qt.openUrlExternally("https://mysthea.tabula.games/volfyirion/extra-rules")
                            }
                        }

                    }
                }
            }

            // element: 37
            Item {
                height: 48
            }

            // element: 38
            ColumnLayout {
                id: _soloMode
                width: root.width
                spacing: 0

                ModeLabel {
                    contentMargins: root.contentMargins
                    width: parent.width
                    userConditionUrl: "qrc:/assets/rulebook/solo-mode/game-condition-SOLO.svg"
                    playMode: qsTr("solo mode")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("Before attempting a Solo game, we highly recommend the player to first "
                               + "play some games of the standard mode, mastering the bases of Volfyirion: "
                               + "Card Game.")
                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                Image {
                    source: "qrc:/assets/rulebook/divider_final.png"
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }

                RulebookText {
                    text: qsTr("In the Solo Mode of the game, you confront Volfyirion itself in a race "
                               + "against time. The mighty creature will unleash its fury on you as soon as "
                               + "given the chance. Never forget to keep an eye on it, as you may find "
                               + "yourself cornered in no time.")

                    Layout.fillWidth: true
                    Layout.topMargin: 27
                }

                RulebookText {
                    text: qsTr("Your goal is to either defeat or subjugate the dreadful dragon.")
                    Layout.fillWidth: true
                }

            }

            // element: 39
            Item {
                height: 48
            }

            // element: 40
            ColumnLayout {
                id: _soloModeSetup
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("setup")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("The setup for the Solo Play is similar to the standard game.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Place three Cities in front of you, each with a different Defence Value. "
                               + "Put back into the box the three Cities left. Remove from the game every "
                               + "card that contains a “Move Volfyirion” Secondary Ability.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Perk, Ploy, and other Extra Cards are not used in this mode.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Assemble, shuffle and place both the Asset Deck and Wonder Deck face down."
                               + " Prepare the Asset Row and Volfyirion’s Lair as usual.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Pane {
                    leftPadding: 17
                    rightPadding: 17
                    topPadding: 15
                    bottomPadding: 15

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.1
                    }
                    ColumnLayout {
                        width: parent.width
                        spacing: 0

                        Image {
                            source: "qrc:/assets/rulebook/solo-mode/solo-setup.png"
                            asynchronous: true

                            fillMode: Image.PreserveAspectFit
                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "Please consider this image as a reference for setup.")
                            wrapMode: Text.WordWrap

                            leftPadding: 65
                            rightPadding: 65

                            horizontalAlignment: Text.AlignHCenter

                            Layout.fillWidth: true
                        }
                    }
                }
            }

            // element: 41
            Item {
                height: 48
            }

            // element: 42
            ColumnLayout {
                id: _rulesSoloSection
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("rules")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("You may only perform the following actions from the core game:")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Play a card from your hand")
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Gain Points from a card")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Use Command Points to Acquire an Asset Card")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Use Command Points to Redeploy a Troop")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Use Battle Points to Acquire a Wonder Card")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Use Knowledge Points to Replace a card in the Asset Row")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Activate a card’s Secondary Ability")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Spend 16 Battle Points to Attack Volfyirion")
                    topPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("At the beginning of each of your turns and whenever you "
                               + "Play a card that remains In-Play (Wonder, Building, Troop),"
                               + " draw a card from the Asset Deck without revealing it, then "
                               + "place it face down in front of you to form what will be "
                               + "called henceforth the Rage Pile. All these cards are always "
                               + "added to the bottom of the Rage Pile.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("During a turn, whenever you need to shuffle back your Discard "
                               + "Pile as the House Deck, move the Volfyirion Token from the "
                               + "Volfyirion’s Lair close to the Rage Pile as a reminder.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Pane {
                    leftPadding: 17
                    rightPadding: 17
                    topPadding: 15
                    bottomPadding: 15

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.1
                    }
                    ColumnLayout {
                        width: parent.width
                        spacing: 0

                        Image {
                            source: "qrc:/assets/rulebook/solo-mode/solo-setup_2.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "Example: The player has just played a Wonder Card, thus they are forced "
                                      + "to draw a card from the Asset Deck and add it to the bottom of the Rage "
                                      + "Pile [A].")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }
                    }
                }

                Pane {
                    leftPadding: 17
                    rightPadding: 17
                    topPadding: 15
                    bottomPadding: 15

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.1
                    }
                    ColumnLayout {
                        width: parent.width
                        spacing: 0

                        Image {
                            source: "qrc:/assets/rulebook/solo-mode/soloplay-setup_3.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "Following the previous example: At the beginning of their next turn, "
                                      + "the player adds another card to the Rage Pile [B]. Then they have to "
                                      + "reshuffle their Discard Pile into a new House Deck in order to draw. "
                                      + "This triggers Volfyirion, which is moved next to the Rage Pile [C]. "
                                      + "By the end of the turn, Volfyirion will attack.")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }
                    }
                }

                RulebookText {
                    text: qsTr("At the End of a Turn phase (after you have followed the main game instructions),"
                               + " if the Volfyirion Token is away from its Lair, Volfyirion attacks. ")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Reveal all cards from the Rage Pile, then follow these steps in order:")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("1. For each Troop Card revealed, choose a Troop you currently have In-Play "
                               + "to be removed from the game. Then put all revealed Troop Cards aside.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("2. For each Building Card revealed, choose a Building you currently have "
                               + "In-Play to be removed from the game. Then put all revealed Building Cards aside.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("3. If Command Cards are revealed, sum up all their Command Point costs, then add "
                               + "1 point for each destroyed City. That number represents Volfyirion’s Battle "
                               + "Points for the current turn. If it is equal or greater than the Defence Value "
                               + "of one of your Cities (plus stationing Troops), the creature destroys the City. "
                               + "Volfyirion may destroy multiple Cities in the same turn, provided it has enough "
                               + "Battle Points to spend for each City. If possible, Volfyirion always destroys the "
                               + "City with the highest Defence Value between those available. Exceeding Points are "
                               + "lost.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("4. If Command Cards were revealed at the previous step, sum up all Knowledge Points "
                               + "from their Main Abilities. Volfyirion spends those points to Seal your Wonders "
                               + "In-Play from the most expensive to the less expensive. Exceeding Points are lost.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("5. Put aside all Command Cards revealed from the Rage Pile, except the one with the "
                               + "highest value. Put that one card face up, as the first of a new Rage Pile — "
                               + "following cards will be put beneath it.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("6. Volfyirion has unleashed its rage and it’s now done playing with you. "
                               + "To represent this, move the Volfyirion Token back onto the Volfyirion’s Lair. "
                               + "The turn has now ended and you may start over with the next turn.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("If your last City is destroyed during step 3, you lose the game.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Pane {
                    leftPadding: 17
                    rightPadding: 17
                    topPadding: 15
                    bottomPadding: 15

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.1
                    }
                    ColumnLayout {
                        width: parent.width
                        spacing: 0

                        Image {
                            source: "qrc:/assets/rulebook/solo-mode/soloplay-setup_4.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "Following the previous example:")
                            wrapMode: Text.WordWrap
                            bottomPadding: 0

                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr(
                                      "The cards in the Rage Pile are revealed. There is a Troop Card, a Building "
                                      + "Card, and two Command Cards. At step 1, the Troop stationing the City "
                                      + "gets destroyed [D] and the revealed Troop Card is put aside. Since the "
                                      + "player owns no Buildings, step 2 is not resolved, but the revealed Building"
                                      + " Card is put aside as well. At step 3, the combined Command Points of the "
                                      + "two Command Cards are equal to 9, enough to destroy the 9 Defense Points "
                                      + "City [E]. At step 4, the Command Cards’ 3 Knowledge Points are used to "
                                      + "Seal the player’s Wonder [F].")
                            wrapMode: Text.WordWrap
                            topPadding: 0

                            Layout.fillWidth: true
                        }
                    }
                }

                Pane {
                    leftPadding: 17
                    rightPadding: 17
                    topPadding: 15
                    bottomPadding: 15

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.1
                    }
                    ColumnLayout {
                        width: parent.width
                        spacing: 0

                        Image {
                            source: "qrc:/assets/rulebook/solo-mode/soloplay-setup_5.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                        }
                        RulebookText {
                            text: qsTr(
                                      "At step 5, the revealed Command Card with the highest cost is kept as the first card of a new "
                                      + "Rage Pile [G], while the other Command Card is put aside along with the others [H]. At step 6, "
                                      + "Volfyirion’s Token is moved back onto the Lair Card [I].")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }
                    }
                }

                RulebookText {
                    text: qsTr("To face Volfyirion, you may perform new actions:")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr("- Spend 6 Knowledge Points to put aside the top card of the Rage Pile ")

                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Spend 6 Battle Points to put aside the top card of the Rage Pile")

                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Spend 16 Knowledge Points to Subjugate Volfyirion")

                    topPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("In the rare case that no more cards are left to draw from the Asset Deck, take the cards you "
                               + "put aside during the game and shuffle them back to form a new Asset Deck.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    leftPadding: 17
                    rightPadding: 17
                    topPadding: 15
                    bottomPadding: 15

                    text: qsTr("NOTE: Cards that were removed from the game are not put back into the deck.")

                    background: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 80
                        color: root.primaryNotePaneColor
                        opacity: 0.3
                        radius: 12
                    }
                }
            }

            // element: 43
            Item {
                height: 48
            }

            // element: 44
            ColumnLayout {
                id: _victorySoloSection
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("victory")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("If you manage to gather enough Battle Points to Attack Volfyirion you ward off the creature and get to "
                               + "live another day, immediately winning the game.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("If you manage to gather enough Knowledge Points to Subjugate Volfyirion you put the creature under your "
                               + "control, immediately winning the game.")

                    Layout.fillWidth: true
                }
            }

            // element: 45
            Item {
                height: 48
            }

            // element: 46
            ColumnLayout {
                id: _difficultySettingSoloSection
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("difficulty settings")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("If you want to increase or decrease the level of challenge, consider the table "
                               + "below when resolving step 3 of Volfyirion’s attack.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Image {
                    source: "qrc:/assets/rulebook/solo-mode/difficulty-table-2.png"
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }

            }

            // element: 47
            Item {
                height: 48
            }

            // element: 48
            ColumnLayout {
                id: _teamMode
                width: root.width
                spacing: 0

                ModeLabel {
                    contentMargins: root.contentMargins
                    userConditionUrl: "qrc:/assets/rulebook/team-mode/game-condition-TEAM.svg"
                    playMode: qsTr("team mode")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("Before attempting a Team Versus game, we highly recommend the players to first play some "
                               + "games of the standard mode, mastering the bases of Volfyirion: Card Game.")
                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                Image {
                    source: "qrc:/assets/rulebook/divider_final.png"
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }

                RulebookText {
                    text: qsTr("To play a Team Versus game of Volfyirion you and your friends will need two "
                               + "copies of the game, one for each team. ")

                    Layout.fillWidth: true
                    Layout.topMargin: 27
                }

                RulebookText {
                    text: qsTr("In this game-mode, a team wins when all enemy Strongholds are destroyed.")
                    Layout.fillWidth: true
                }

            }

            // element: 49
            Item {
                height: 48
            }

            // element: 50
            ColumnLayout {
                id: _teamModeSetup
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("setup")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("The setup is similar to the standard game. Teammates sit one next to each other, facing their opponents.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("With one copy of the game, set up on one side of the table two House Decks, an Asset "
                               + "Deck with its Row, a Lair with two Wonders, and a Wonder Deck. Use the Volfyirion’s "
                               + "Lair Card four-player side in this mode.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr("NOTE: Extra Cards are not used in this mode.")
                    leftPadding: 17
                    rightPadding: 17
                    topPadding: 15
                    bottomPadding: 15

                    background: Rectangle {
                        implicitHeight: 58
                        implicitWidth: 300
                        color: root.primaryNotePaneColor
                        opacity: 0.3
                        radius: 12
                    }

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr("Rotate and combine the six City Cards in pairs to assemble three Strongholds, each with "
                               + "18 Defence Value (10+8, 9+9, and 8+10). Each Stronghold is considered as a City "
                               + "when applying rules and effects.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr("ASYMMETRIC VARIANT: Each team may decide how to combine City Cards into Strongholds.")
                    leftPadding: 17
                    rightPadding: 17
                    topPadding: 15
                    bottomPadding: 15

                    background: Rectangle {
                        implicitHeight: 112
                        implicitWidth: 300
                        color: root.secondaryNotePaneColor
                        radius: 12
                    }

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                Image {
                    source: "qrc:/assets/rulebook/divider_final.png"
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }

                RulebookText {
                    text: qsTr("With the second copy of the game, set up on the other side of the table in a mirrored manner.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("During setup, place a single Volfyirion Token away from the two Lair Cards. Put back "
                               + "into the box the other token, as you will only need one.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("A setup example of one team follows on the next two pages.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 12
                    rightPadding: 12

                    Layout.fillWidth: true

                    background: Rectangle {
                        implicitHeight: 769
                        implicitWidth: 347
                        color: root.secondaryNotePaneColor
                        radius: 12
                    }

                    Image {
                        width: parent.width
                        asynchronous: true

                        source: "qrc:/assets/rulebook/team-mode/team-setup.png"
                        fillMode: Image.PreserveAspectFit

                        horizontalAlignment: Qt.AlignHCenter
                    }
                }
            }

            // element: 51
            Item {
                height: 48
            }

            // element: 52
            ColumnLayout {
                id: _rulesTeamSection
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("rules")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("The Team Versus mode follows the standard game rules, aside from the changes listed below.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("The middle Stronghold is shared between teammates, while the other two Strongholds are "
                               + "each own by the player on their respective side. Players can play Troops and Buildings "
                               + "as normal in their own Stronghold. As for the shared Stronghold, no Building can be played "
                               + "in it while players can deploy Troops following standard rules. ")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Whenever a player Plays a card, its Secondary Abilities requirements are met only by other "
                               + "cards played from their hand, from cards on the Stronghold they own or from Troop "
                               + "Cards on the shared Stronghold.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Turns are not individual, teammates perform their turn altogether, and they can freely discuss"
                               + " their preferences on cards to Acquire or to Play.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Players Gain and spend Command Points individually.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Players Gain and spend Battle and Knowledge Points as a team. Players are free to spend "
                               + "them as they please to perform actions, following standard game rules. ")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Allied players share the same Asset Row, Asset Deck, Volfyirion Lair’s Card, and Wonder Deck.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Whenever a card from the Asset Row is acquired, its space is immediately refilled.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("The same applies for the Wonders on the Volfyirion Lair’s Card.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("When acquiring a Wonder Card, teammates may decide which of them benefits "
                               + "of the Wonder Card removal bonus.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Seal/Unseal mechanic is now extended to the opponent team’s Asset Row.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("If you, as a team, pay Knowledge Points equal to a card’s cost on the enemy "
                               + "Asset Row, you may Seal that card (rotate it on its side).")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Players can neither Acquire nor Replace a sealed card in the Asset Row"
                               + " until they pay Knowledge Points equal to its cost to Unseal it (rotate it back to represent this).")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Move Volfyrion")
                    font.capitalization: Font.AllUppercase
                    font.bold: true

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Volfyirion enters the game the very first time any of the teams performs a Move Volfyirion action. "
                               + "In this case, Volfyirion starts its movement from the playing team Lair Card.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("A team may pay 9 Knowledge Points to Move the Volfyirion Token onto the enemy team’s Lair Card.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("A team may pay 9 Knowledge Points to Move the Volfyirion Token from the enemy Lair onto "
                               + "an enemy Stronghold.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("A team may pay 16 Knowledge Points to Move the Volfyirion Token from any location onto "
                               + "an enemy Stronghold.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 12
                    rightPadding: 12

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.secondaryNotePaneColor
                        radius: 12
                    }
                    ColumnLayout {
                        width: parent.width
                        spacing: 15

                        Image {
                            source: "qrc:/assets/rulebook/team-mode/team-setup_2.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RulebookText {
                            text: qsTr(
                                      "Team 1’s middle Stronghold is being besieged by Volfyirion. They could spend 16 Knowledge "
                                      + "Points to send it onto an enemy Stronghold but they do not have enough points. By spending "
                                      + "just 9 Knowledge Points they at least manage to repel Volfyirion onto the opponents’ "
                                      + "Lair Card.")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }
                    }
                }

                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 12
                    rightPadding: 12

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        color: root.primaryNotePaneColor
                        radius: 12
                        opacity: 0.1
                    }
                    ColumnLayout {
                        width: parent.width
                        spacing: 15

                        Image {
                            source: "qrc:/assets/rulebook/team-mode/TEAM-SETUP_3.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RulebookText {
                            text: qsTr(
                                      "Following the previous example: Team 2 players decide to spend 9 Knowledge Points and move "
                                      + "Volfyirion from their Lair Card onto the enemy’s one.")
                            wrapMode: Text.WordWrap

                            Layout.fillWidth: true
                        }
                    }
                }

                RulebookText {
                    text: qsTr("VOLFYIRION’S CLUTCH")
                    font.capitalization: Font.AllUppercase
                    font.bold: true

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("As long as Volfyirion is guarding a Lair on one side of the table, the corresponding team needs to "
                               + "pay 2 additional Battle Points to Acquire a Wonder from that Lair.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("DEFEAT VOLFYIRION")
                    font.capitalization: Font.AllUppercase
                    font.bold: true

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Defeating Volfyirion costs 32 Battle Points.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("The team which achieves this feat gets all Wonder Cards present on their Lair Card. "
                               + "Decide how to distribute the Wonder Cards, then immediately put them in play.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Both teammates get to thin their decks by removing a single card (apply Wonder "
                               + "Cards removal ability).")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(" Then both Lairs crumble to the ground: remove from the game both Volfyirion’s Lair "
                               + "Cards, any Wonder Cards still present on them, and both Wonder Decks. ")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("The Volfyirion Token is removed from the game and all actions related to it become unavailable.")

                    Layout.fillWidth: true
                }
            }

            // element: 53
            Item {
                height: 48
            }

            // element: 54
            ColumnLayout {
                id: _victoryTeamSection
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("victory")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("A team immediately wins the game after destroying all three enemy Strongholds.")

                    Layout.fillWidth: true
                }
            }

            // element: 55
            Item {
                height: 48
            }

            // element: 56
            ColumnLayout {
                id: _coopMode
                width: root.width
                spacing: 0

                ModeLabel {
                    contentMargins: root.contentMargins
                    userConditionUrl: "qrc:/assets/rulebook/coop-mode/game-condition-COOP.svg"
                    playMode: qsTr("coop mode")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("Before attempting a Coop game, we highly recommend the players "
                               + "to first play some games of the standard mode, mastering the "
                               + "bases of Volfyirion: Card Game.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                Image {
                    source: "qrc:/assets/rulebook/divider_final.png"
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                    Layout.alignment: Qt.AlignHCenter
                }

                RulebookText {
                    text: qsTr("In Volfyirion Coop Mode, House Volarees and House Rorius join "
                               + "forces to prevent Volfyirion, which is on a rampage, from "
                               + "destroying the entire region.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Your goal is to either defeat or subjugate the dreadful dragon. "
                               + "When the last City standing is destroyed, you lose the game.")

                    Layout.fillWidth: true
                }
            }

            // element: 57
            Item {
                height: 48
            }

            // element: 58
            ColumnLayout {
                id: _coopSetup
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("setup")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("Setup all six City Cards in a circle, where Cities with the same Defence Value "
                               + "stand opposite to each other. Place the Volfyirion Token on a City with a "
                               + "Defence Value of 8.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Just like the Standard mode, each player owns three Cities with different "
                               + "Defence Values. ")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Remove from the game every card that contains a “Move Volfyirion” Secondary "
                               + "Ability, except for the two Emerald Horn Wonder Cards.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Perk Cards, Ploy Cards, and all the other Extra Cards are not used in this mode.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Put back inside the box the Volfyirion’s Lair Card, as you will not need it.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Shuffle all Wonder Cards face down and put them in the center of the table, as "
                               + "the Rage Deck. In this mode, Wonders are not available to the players.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr(" Setup the Asset Row, Asset Deck, and House Decks as in the standard game "
                               + "for both players.")
                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 26
                    rightPadding: 26

                    Layout.fillWidth: true

                    background: Rectangle {
                        implicitHeight: 597
                        implicitWidth: 347
                        color: root.secondaryNotePaneColor
                        radius: 12
                    }

                    Image {
                        width: parent.width
                        asynchronous: true
                        source: "qrc:/assets/rulebook/coop-mode/COOP-SETUP.png"
                        fillMode: Image.PreserveAspectFit
                        horizontalAlignment: Qt.AlignHCenter
                    }
                }
            }

            // element: 59
            Item {
                height: 48
            }

            // element: 60
            ColumnLayout {
                id: _coopRules
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("rules")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("The two of you perform actions individually, but during the same Main Phase.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("You both may perform the following actions as normal:")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Play a card from your hand")
                    bottomPadding: 0
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Gain Points from a card")
                    topPadding: 0
                    bottomPadding: 0
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Use Command Points to Acquire an Asset Card")
                    topPadding: 0
                    bottomPadding: 0
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Use Command Points to Redeploy a Troop")
                    topPadding: 0
                    bottomPadding: 0
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Use Knowledge Points to Replace a card in the Asset Row")
                    topPadding: 0
                    bottomPadding: 0
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Activate a card’s Secondary Ability")
                    topPadding: 0
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("In this mode, you both act within the same turn.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("When you are done performing actions, and Volfyirion’s Attack "
                               + "has been resolved, the turn ends and a new one begins.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("You and your ally may freely discuss how to spend points "
                               + "and what actions to take in order to achieve victory.")
                    Layout.fillWidth: true
                }
            }

            // element: 61
            Item {
                height: 48
            }

            // element: 62
            ColumnLayout {
                id: _attackMechanicCoop
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("Attack mechanic")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("Volfyirion’s attack value is determined by the combined cost of the "
                               + "cards drawn from the Rage Deck.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("1. At the beginning of each turn, draw and reveal three cards from "
                               + "the Rage Deck, one after another.")
                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr("NOTE: At the beginning of the very first turn, draw only two "
                               + "cards instead.")

                    background: Rectangle {
                        implicitHeight: 83
                        implicitWidth: 323
                        color: root.primaryNotePaneColor
                        opacity: 0.3
                        radius: 12
                    }

                    leftPadding: 17
                    rightPadding: 17
                    topPadding: 15
                    bottomPadding: 15

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                RulebookText {
                    text: qsTr("When you reveal cards from the Rage Deck arrange them in a two column "
                               + "grid like this:")
                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Image {
                    source: "qrc:/assets/rulebook/coop-mode/TAB.png"
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                    Layout.alignment: Qt.AlignHCenter
                }

                RulebookText {
                    text: qsTr("Revealed Wonder Cards remain In-Play as long as Volfyirion does not attack.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("If there are no cards left, shuffle back the appropriate Discard Pile.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("2. Move Volfyirion clockwise of as many City Cards as the first revealed "
                               + "card’s cost.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Destroyed Cities are ignored when Volfyirion moves, as it just continues "
                               + "its movement onto the next one. Only count standing Cities when moving "
                               + "Volfyirion.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("3. At the end of each turn, multiply the Wonder Card costs on the first row.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("If that value is not enough to destroy the City Volfyirion is laying siege "
                               + "to, add the cost of the first card of the next row. If even that is not "
                               + "enough, instead of adding the value of the third card, multiply the cards "
                               + "costs on the second row, then sum all rows totals. If only a single card "
                               + "is present on a row, multiply its value by 1.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("Continue to count the available cards from all rows until the value is "
                               + "equal to the City’s Defence. The total sum represents the Attack Value "
                               + "of Volfyirion.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("If this value equals the Defence of the City Volfyirion is currently on, "
                               + "that City is immediately destroyed by the creature’s attack. Remember "
                               + "that Troop Cards increase the defence of the City they’re stationing as "
                               + "usual.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("If there are not enough cards to match the City’s Defence, Volfyirion’s "
                               + "attack fails.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("When a player’s last City standing is destroyed, they’re out of the "
                               + "game and cannot play any cards.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("When the very last City standing is destroyed, you lose the game.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("For each destroyed City, add +1 to Volfyirion’s final Attack Value.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("If the final value is not enough to trigger a valid attack by "
                               + "Volfyirion, ignore step 4) and end the turn. The City is safe, "
                               + "for now.")
                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("4. Discard all Wonder Cards from the grid but the one with the "
                               + "highest cost among those that were not actually needed to "
                               + "destroy the City.")
                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 12
                    rightPadding: 12

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        implicitHeight: 818
                        implicitWidth: 347
                        color: root.secondaryNotePaneColor
                        radius: 12
                    }

                    ColumnLayout {
                        width: parent.width
                        spacing: 15

                        Image {
                            source: "qrc:/assets/rulebook/coop-mode/INFO1.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RulebookText {
                            text: qsTr("Example: Volfyirion is laying siege to a City with a Defence "
                                       + "Value of 8.")
                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("The first row generates 4 Attack Points [A], which is not "
                                       + "enough to destroy the City.")
                            Layout.fillWidth: true
                        }

                        RulebookText {
                            text: qsTr("Simply adding the 3rd card is not enough as well (+3) so the "
                                       + "second row must be multiplied (12 points) [B] and then "
                                       + "summed to the previous row for a total of 16 points, enough "
                                       + "to destroy the City.")
                            Layout.fillWidth: true
                        }
                    }
                }

                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 12
                    rightPadding: 12

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        implicitHeight: 399
                        implicitWidth: 347
                        color: root.secondaryNotePaneColor
                        radius: 12
                    }

                    ColumnLayout {
                        width: parent.width
                        spacing: 15

                        Image {
                            source: "qrc:/assets/rulebook/coop-mode/INFO2.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RulebookText {
                            text: qsTr("All grid’s cards are now discarded, but between those unused "
                                       + "(Emerald Horn and Glowing Fungii), the card with the highest "
                                       + "value is kept [C].")
                            Layout.fillWidth: true
                        }
                    }
                }
            }

            // element: 63
            Item {
                height: 48
            }

            // element: 64
            ColumnLayout {
                id: _actionsCoop
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("actions")

                    Layout.fillWidth:true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("To face Volfyirion, both players may perform new actions during a turn:")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Spend Battle Points equal to an In-Play Wonder Card cost to discard "
                               + "it onto its Discard Pile. May be used multiple times.")
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Spend Knowledge Points equal to an In-Play Wonder Card cost to Seal "
                               + "it until next turn Draw Phase. A Sealed card is not considered when "
                               + "resolving Volfyirion’s attacks. May be used multiple times.")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Spend 8 Knowledge Points to Move Volfyirion of one City Card clockwise "
                               + "or counterclockwise. May be used multiple times.")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Spend 3 Knowledge Points to remove a card from your hand, from played "
                               + "cards, or from the Discard Pile (similar to Wonder Cards). May be used "
                               + "only once per turn by each player.")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- Together, players may spend a total of 30 Battle Points to Attack "
                               + "Volfyirion or 30 Knowledge Points to Subjugate Volfyirion.")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("- A player may single-handedly spend a total of 20 Battle Points to "
                               + "Attack Volfyirion or 20 Knowledge Points to Subjugate Volfyirion.")
                    topPadding: 0
                    bottomPadding: 0

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("The turn of the players follows the standard game rules, as usual.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("When playing a Troop or Building Card, it can be assigned to the other "
                               + "player’s Cities to help them out, but consider that only owned Cities "
                               + "benefit a player with the Abilities and colors of the cards they hold.")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 12
                    rightPadding: 12

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        implicitHeight: 733
                        implicitWidth: 347
                        color: root.secondaryNotePaneColor
                        radius: 12
                    }

                    ColumnLayout {
                        width: parent.width
                        spacing: 15

                        Image {
                            source: "qrc:/assets/rulebook/coop-mode/INFO3.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RulebookText {
                            text: qsTr("Example: At the beginning of the turn Emerald Horn, Living Knife, "
                                       + "and Divining Petals are drawn from the Rage Deck. Volfyirion "
                                       + "moves of six spaces landing onto a City with 10 defence Points. "
                                       + "It is ready to deliver a massive attack. ")
                            Layout.fillWidth: true
                        }
                    }
                }

                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 12
                    rightPadding: 12

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        implicitHeight: 633
                        implicitWidth: 347
                        color: root.secondaryNotePaneColor
                        radius: 12
                    }

                    ColumnLayout {
                        width: parent.width
                        spacing: 15

                        Image {
                            source: "qrc:/assets/rulebook/coop-mode/INFO4.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RulebookText {
                            text: qsTr("Player 1 decides to spend 4 Battle Points to remove Void Fluid [A], "
                                       + "while Player 2 decides to spend 4 Battle Points to remove Black "
                                       + "Spores [B]. Player 2 also spends 6 Knowledge Points to seal "
                                       + "Emerald Horn for the time being [C].")
                            Layout.fillWidth: true
                        }
                    }
                }

                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 12
                    rightPadding: 12

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        implicitHeight: 470
                        implicitWidth: 347
                        color: root.secondaryNotePaneColor
                        radius: 12
                    }

                    ColumnLayout {
                        width: parent.width
                        spacing: 15

                        Image {
                            source: "qrc:/assets/rulebook/coop-mode/INFO5.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RulebookText {
                            text: qsTr("By the end of the turn, Volfyirion’s attack is equal to 9 (3 from "
                                       + "the first row plus 6 from the third row), not enough to destroy "
                                       + "the City.")
                            Layout.fillWidth: true
                        }
                    }
                }

                Pane {
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 12
                    rightPadding: 12

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15

                    background: Rectangle {
                        implicitHeight: 1565
                        implicitWidth: 347
                        color: root.secondaryNotePaneColor
                        radius: 12
                    }

                    ColumnLayout {
                        width: parent.width
                        spacing: 15

                        RulebookText {
                            text: qsTr("Following the general rule, the cards are then rearranged to fill the "
                                       + "gaps by being pushed upwards, starting from the left column. If a "
                                       + "card gets stuck on the right column, and the space on its left is "
                                       + "empty, the card is thus moved onto the left column. The example is "
                                       + "split in three phases.")
                            Layout.fillWidth: true
                        }


                        Image {
                            source: "qrc:/assets/rulebook/coop-mode/INFO6.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Image {
                            source: "qrc:/assets/rulebook/coop-mode/INFO7.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Image {
                            source: "qrc:/assets/rulebook/coop-mode/INFO8.png"
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }

            // element: 65
            Item {
                height: 48
            }

            // element: 66
            ColumnLayout {
                id: _victoryCoop
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("victory")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("If the two of you manage to gather enough Points and Attack Volfyirion, "
                               + "you defeat the creature by warding it off the region – immediately "
                               + "winning the game.")

                    Layout.fillWidth: true
                }

                RulebookText {
                    text: qsTr("If the two of you manage to gather enough Knowledge Points to Subjugate "
                               + "Volfyirion, you put the creature under your control – immediately winning "
                               + "the game.")

                    Layout.fillWidth: true
                }
            }

            // element: 69
            Item {
                height: 48
            }

            // element: 70
            ColumnLayout {
                id: _difficultySettingCoop
                anchors.bottomMargin: 222
                width: root.width
                spacing: 0

                RulebookTitle {
                    text: qsTr("difficulty setting")

                    Layout.fillWidth: true
                    Layout.bottomMargin: 27
                }

                RulebookText {
                    text: qsTr("If you want to increase or decrease the level of challenge, consider the chart "
                               + "below when resolving step 3) of Volfyirion’s attack.")
                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }

                Image {
                    source: "qrc:/assets/rulebook/coop-mode/TAB_2.png"
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit

                    Layout.fillWidth: true
                    Layout.bottomMargin: 15
                }
            }

            Image {
                anchors.horizontalCenter: _difficultySettingCoop.horizontalCenter
                asynchronous: true
                source: "qrc:/assets/rulebook/background/BG-END.png"
                fillMode: Image.PreserveAspectCrop
                width: root.width + root.contentMargins

                verticalAlignment: Qt.AlignBottom
                horizontalAlignment: Qt.AlignHCenter
            }
        }
    }
}
