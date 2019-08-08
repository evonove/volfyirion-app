import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "../../" as Ui
import "./Models" as Models

Ui.BaseContent {
    id: root

    title: qsTr("download area")

    Models.RulebookDownloadModel {
        id: _rulebooksModel
    }

    ListView {
        id: _languageListView
        anchors.fill: parent
        clip: true
        spacing: 0
        model: _rulebooksModel
        bottomMargin: 32

        boundsBehavior: Flickable.StopAtBounds
        maximumFlickVelocity: 10000

        section.property: "type"
        section.delegate: ColumnLayout {
            width: parent.width
            spacing: 0

            Rectangle {
                height: 1
                color: palette.mid
                visible: section !== "base mode"

                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.topMargin: 28
                Layout.leftMargin: 24
                Layout.rightMargin: 24
            }

            Label {
                text: section
                font.pixelSize: 22
                font.capitalization: Font.AllUppercase

                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 28
                Layout.bottomMargin: 28
            }
        }

        delegate: ItemDelegate {
            width: parent.width

            contentItem: RowLayout {
                Label {
                    id: textLabel
                    color: "white"
                    font.pixelSize: 22
                    font.letterSpacing: 0.5
                    font.underline: true
                    padding: 0
                    text: language

                    Layout.alignment: Qt.AlignHCenter
                }
            }

            onClicked: Qt.openUrlExternally(downloadUrl)
        }
    }
}
