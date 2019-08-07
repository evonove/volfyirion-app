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
        spacing: 18
        model: _rulebooksModel

        bottomMargin: 32

        section.property: "type"
        section.delegate: ColumnLayout {
            width: parent.width
            anchors.leftMargin: 24
            anchors.rightMargin: 24

            spacing: 0

            Rectangle {
                color: palette.mid
                height: 1
                implicitWidth: 327

                visible: section !== "base mode"

                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 28
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
            padding: 0
            contentItem: RowLayout {
                anchors.fill: parent
                spacing: 0
                Label {
                    id: textLabel
                    color: "white"
                    font.pixelSize: 22
                    font.letterSpacing: 0.5
                    padding: 0
                    text: language

                    background: Rectangle {
                        width: parent.width
                        height: 1
                        color: "white"
                        anchors.bottom: parent.bottom
                    }

                    Layout.alignment: Qt.AlignHCenter
                }
            }

            onClicked: Qt.openUrlExternally(downloadUrl)

            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
