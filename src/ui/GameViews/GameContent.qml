import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Ui.BaseContent {
    id: root

    signal priorityClicked
    signal pointsCounterClicked

    background: Image {
        source:"qrc:/assets/volfyirion_bg.jpeg"
        fillMode: Image.PreserveAspectCrop

        Rectangle {
            anchors.fill: parent
            color: "#2C2B2B"
            opacity: 0.7
        }
    }

    ColumnLayout {
        id: buttons
        width: parent.width
        anchors.centerIn: parent
        spacing: 75

        Button {
            text: qsTr("Priority");

            onClicked: root.priorityClicked()

            Layout.preferredWidth: 277
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }
        Button {
            text: qsTr("Points Counter");

            onClicked: root.pointsCounterClicked()

            Layout.preferredWidth: 277
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }

    }
}
