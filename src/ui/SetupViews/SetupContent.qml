import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Ui.BasePage {
    signal gameSetupClicked()

    title: "first view"

    background: Image {
        source:"qrc:/assets/background.png"
        fillMode: Image.PreserveAspectCrop

        Rectangle {
            anchors.fill: parent
            color: "#2C2B2B"
            opacity: 0.7
        }
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        spacing: 0
        Image {
            source: "qrc:/assets/logo.png"
            fillMode: Image.PreserveAspectFit
            smooth: false
            asynchronous: true
            Layout.fillWidth: true
            Layout.minimumWidth: 314
            Layout.maximumHeight: 144
            Layout.alignment: Qt.AlignTop
            Layout.topMargin: 18
            Layout.bottomMargin: 68
        }

        Button {
            text: qsTr("Game Setup")

            onClicked: gameSetupClicked()

            Layout.preferredWidth: 277
            Layout.bottomMargin: 75
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Button {
            text: qsTr("Rulebook")

            Layout.preferredWidth: 277
            Layout.bottomMargin: 100
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        GrowlButton {
            text: "growl"

            Layout.bottomMargin: 32
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
