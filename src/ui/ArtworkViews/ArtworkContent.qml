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
            Layout.fillWidth: true
            implicitHeight: 75

            background: Rectangle {
                color: palette.dark
            }

            currentIndex: swipe.currentIndex

            TabButton {
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height

                icon.source: this.down
                             || this.checked ? "qrc:/assets/griglia_filled.svg" : "qrc:/assets/griglia.svg"
                icon.height: 30
                icon.width: 30

                onClicked: {
                    swipe.currentIndex = 0
                    console.log("griglia", artModel.count)
                }
            }

            TabButton {
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                icon.height: 30
                icon.width: 30

                icon.source: this.down
                             || this.checked ? "qrc:/assets/listing_filled.svg" : "qrc:/assets/listing.svg"

                onClicked: {
                    swipe.currentIndex = 1
                    console.log("lista")
                }
            }
        }

        SwipeView {
            id: swipe
            currentIndex: 0
            clip: true

            Item {
                id: grid
                height: parent.height

                GridView {
                    id: gridCard
                    width: parent.width
                    height: parent.height
                    bottomMargin: 45
                    interactive: true

                    implicitHeight: Math.ceil(
                                        artModel.count / root.numElementsInRow) * cellHeight

                    cellHeight: 166
                    cellWidth: root.currentCellWidth

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter
                    Layout.topMargin: 16

                    model: artModel

                    delegate: Pane {
                        height: gridCard.cellHeight
                        width: gridCard.cellWidth
                        topPadding: 3
                        bottomPadding: 3
                        leftPadding: 3
                        rightPadding: 3
                        background: null

                        ColumnLayout {
                            id: col
                            anchors.fill: parent
                            spacing: 0
                            Rectangle {
                                color: img.status === Image.Ready ? "transparent" : palette.mid
                                border.color: palette.mid
                                opacity: img.status === Image.Ready ? 1 : 0.5
                                Layout.preferredHeight: parent.height
                                Layout.maximumWidth: parent.width
                                Layout.alignment: Qt.AlignHCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true

                                Image {
                                    id: img
                                    fillMode: Image.PreserveAspectFit
                                    source: model.url
                                    asynchronous: true

                                    anchors.fill: parent
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                // Unfocuses search field so that keyboard is hidden
                                console.log(model.title)
                            }
                        }
                    }
                }
            }

            Item {
                id: list

                ListView {
                    anchors.fill: parent
                    model: artModel
                    spacing: 24
                    delegate: Column {
                        width: parent.width
                        spacing: 10
                        Label {
                            width: parent.width
                            text: qsTr(model.title)
                            font.pixelSize: 23
                            font.letterSpacing: 0.5

                            horizontalAlignment: Qt.AlignHCenter
                        }
                        Image {
                            width: parent.width
                            source: model.url
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                }
            }

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
