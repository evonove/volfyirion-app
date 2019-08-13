import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "../" as Ui
import "./Models" as Models

Ui.BaseContent {
    id: root

    signal openSection(int element)

    title: qsTr("index")

    background: Image {
        source: "qrc:/assets/background_lore_index.webp"
        fillMode: Image.PreserveAspectCrop
        Rectangle {
            anchors.fill: parent
            color: "#2C2B2B"
            opacity: 0.7
        }
    }

    ListView {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 24

        boundsBehavior: Flickable.StopAtBounds
        maximumFlickVelocity: 10000

        model: Models.LoreIndexModel {}

        delegate: ItemDelegate {

            contentItem:  RowLayout {
                width: parent.width
                Label {
                    text: model.chapter
                    font.pixelSize: 19
                    font.bold: true
                    font.letterSpacing: 0.5
                    leftPadding: 30
                }
                Label {
                    text: model.chapterTitle
                    font.pixelSize: 19
                    font.capitalization: Font.AllUppercase
                    font.letterSpacing: 0.5
                    rightPadding: 30
                }
            }

            onClicked: {
                root.openSection(index)
            }
        }
    }
}
