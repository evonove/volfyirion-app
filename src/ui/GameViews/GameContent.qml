import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Ui.BaseContent {
    background: Image {
        source:"qrc:/assets/rulebook_page_background.png"
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

            Layout.preferredWidth: 277
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }
        Button {
            text: qsTr("Points Counter");

            Layout.preferredWidth: 277
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }

    }
}
