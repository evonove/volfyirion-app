import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui
import "Models" as Models

Ui.BaseContent {
    id: root
    title: qsTr("Artwork")

    readonly property int numElementsInRow: 3
    readonly property int currentCellWidth: Math.floor(
                                                root.availableWidth / root.numElementsInRow)

    Models.ArtworksModel {
        id: artModel
    }

    ColumnLayout {
        anchors.fill: parent

        TabBar {
            currentIndex: swipe.currentIndex

            background: Rectangle {
                color: palette.dark
            }

            Layout.fillWidth: true
            Layout.bottomMargin: 16
            Layout.topMargin: 16

            TabButton {
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height

                icon.source: this.down
                             || this.checked ? "qrc:/assets/griglia_filled.svg" : "qrc:/assets/griglia.svg"
                icon.height: 35
                icon.width: 35

                onClicked: {
                    swipe.currentIndex = 0
                }
            }

            TabButton {
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                icon.height: 35
                icon.width: 35

                icon.source: this.down
                             || this.checked ? "qrc:/assets/listing_filled.svg" : "qrc:/assets/listing.svg"

                onClicked: {
                    swipe.currentIndex = 1
                }
            }
        }

        SwipeView {
            id: swipe
            currentIndex: 0
            clip: true

            Layout.fillWidth: true
            Layout.fillHeight: true
            Item {
                id: grid
                height: parent.height

                ArtworkGridView {
                    artModel: artModel

                    implicitHeight: Math.ceil(
                                        artModel.count / root.numElementsInRow) * cellHeight
                    cellHeight: 166
                    cellWidth: root.currentCellWidth
                }
            }

            Item {
                id: list

                ArtworkListView {
                    anchors.fill: parent
                    artModel: artModel
                }
            }
        }
    }
}
