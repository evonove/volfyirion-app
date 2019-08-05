import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import QtMultimedia 5.13

import Volfy.Controls 1.0
import PointsModel 1.0

import "../../" as Ui

Ui.BaseContent {
    id: root

    title: qsTr("Points Counter")
    padding: 6


    rightAction: Action {
        icon.source: "qrc:/assets/reset_icon.svg"
        onTriggered: {
            // reset values of pointsModel to 0
            pointsModel.resetPoints()
        }
    }

    background: Image {
        source: "qrc:/assets/volfyirion_bg.jpeg"
        fillMode: Image.PreserveAspectCrop

        Rectangle {
            anchors.fill: parent
            color: "#2C2B2B"
            opacity: 0.7
        }
    }

    PointsModel {
        id: pointsModel
    }

    ColumnLayout {
        id: buttons
        anchors.fill: parent
        spacing: 6

        PointCounterPlaceholder {
            backgroundUrl: "qrc:/assets/knowledge.png"
            iconPointUrl: "qrc:/assets/knowledge_icon.png"
            score: pointsModel.knowledge
            color: "#B289BD"

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 6

            onDecrementScore: {
                var value = pointsModel.knowledge - 1
                pointsModel.knowledge = value
            }
            onIncrementScore: {
                var value = pointsModel.knowledge + 1
                pointsModel.knowledge = value
            }
        }

        PointCounterPlaceholder {
            backgroundUrl: "qrc:/assets/battle.png"
            iconPointUrl: "qrc:/assets/battle_icon.png"
            score: pointsModel.battle
            color: "#B32013"

            Layout.fillHeight: true
            Layout.fillWidth: true

            onDecrementScore: {
                var value = pointsModel.battle - 1
                pointsModel.battle = value
            }
            onIncrementScore: {
                var value = pointsModel.battle + 1
                pointsModel.battle = value
            }
        }

        PointCounterPlaceholder {
            backgroundUrl: "qrc:/assets/command.png"
            iconPointUrl: "qrc:/assets/command_icon.png"
            score: pointsModel.command
            color: "#59BCAD"

            Layout.fillHeight: true
            Layout.fillWidth: true

            onDecrementScore: {
                var value = pointsModel.command - 1
                pointsModel.command = value
            }
            onIncrementScore: {
                var value = pointsModel.command + 1
                pointsModel.command = value
            }
        }

        GrowlButton {
            text: qsTr("growl")

            onClicked: {
                _player.playlist.shuffle()
                _player.play()
            }

            running: _player.playbackState === Audio.PlayingState
            squared: true

            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.fillWidth: true
        }
    }

    Audio {
        id: _player

        loops: 0
        playlist: Playlist {
            playbackMode: Playlist.CurrentItemOnce

            PlaylistItem {
                source: "qrc:/music/growl_A.mp3"
            }
            PlaylistItem {
                source: "qrc:/music/growl_B.mp3"
            }
            PlaylistItem {
                source: "qrc:/music/growl_C.mp3"
            }
        }
    }
}
