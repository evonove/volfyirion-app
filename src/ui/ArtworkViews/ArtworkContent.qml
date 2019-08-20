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

    signal artworkDetailClicked(string url, string name)

    isLoading: contentLoader.status === Loader.Loading
    opacity: isLoading ? 0.0 : 1.0

    Loader {
        id: contentLoader
        anchors.fill: parent
        asynchronous: true

        sourceComponent: content
    }

    Component {
        id: content
        ColumnLayout {
            anchors.fill: parent
            signal artwokClicked(string url, string name)

            Models.ArtworksModel {
                id: artModel
            }

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

                    onClicked: {
                        swipe.currentIndex = 0
                    }
                }

                TabButton {
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height

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

                        onArtworkClicked: {
                            artworkDetailClicked(url, name)
                        }
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
}
