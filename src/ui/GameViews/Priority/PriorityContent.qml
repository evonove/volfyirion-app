import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../../" as Ui

Ui.BaseContent {
    id: root
    title: qsTr("priority")

    background: Image {
        source: "qrc:/assets/priority_background.png"
        fillMode: Image.PreserveAspectCrop

        Rectangle {
            anchors.fill: parent
            color: "#2C2B2B"
            opacity: 0.7
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Label {
            text: qsTr("hold two fingers anywhere")
            leftPadding: 84
            rightPadding: 84

            font.pixelSize: 36
            font.capitalization: Font.AllUppercase

            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter
        }
    }
}
