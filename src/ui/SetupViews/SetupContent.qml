import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import QtMultimedia 5.13

import Volfy.Controls 1.0

import "../" as Ui

Ui.BaseContent {
    id: root

    signal gameSetupClicked
    signal rulebookClicked

    background: Image {
        source:"qrc:/assets/background.png"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true

        Rectangle {
            anchors.fill: parent
            color: "#2C2B2B"
            opacity: 0.7
        }
    }

    ColumnLayout {
        id: _outer
        anchors.fill: parent
        spacing: 0

        Image {
            source: "qrc:/assets/rulebook/logo.png"
            fillMode: Image.PreserveAspectFit
            smooth: false
            asynchronous: true

            Layout.fillHeight: false
            Layout.fillWidth: false

            Layout.preferredWidth: 314
            Layout.preferredHeight: 144
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.topMargin: 18
        }

        ColumnLayout {
            id: _inner
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter

            Item {
                Layout.fillHeight: true
                Layout.preferredHeight: 2
            }

            Button {
                text: qsTr("Game Setup")

                onClicked: root.gameSetupClicked()

                Layout.preferredWidth: 277
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            }

            Item {
                Layout.fillHeight: true
                Layout.preferredHeight: 1
            }

            Button {
                text: qsTr("Rulebook")

                onClicked: root.rulebookClicked()

                Layout.preferredWidth: 277
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            }

            Item {
                Layout.fillHeight: true
                Layout.preferredHeight: 2
            }

            GrowlButton {
                text: "growl"

                onClicked: {
                    _player.playlist.shuffle()
                    _player.play()
                }

                running: _player.playbackState === Audio.PlayingState

                Layout.bottomMargin: 32
                Layout.alignment:Qt.AlignTop | Qt.AlignHCenter
            }
        }
    }

    Audio {
        id: _player

        loops: 0
        playlist: Playlist {
            playbackMode: Playlist.CurrentItemOnce

            PlaylistItem { source: "qrc:/music/growl_A.mp3" }
            PlaylistItem { source: "qrc:/music/growl_B.mp3" }
            PlaylistItem { source: "qrc:/music/growl_C.mp3" }
        }
    }
}
