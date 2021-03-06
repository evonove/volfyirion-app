import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "../../" as Ui
import "./Models" as Models

Ui.BaseContent {
    id: root

    signal openSection(int element)

    title: qsTr("index")

    background: Image {
        source: "qrc:/assets/rulebook/rulebook_page_background.png"
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
        spacing: 8

        boundsBehavior: Flickable.StopAtBounds
        maximumFlickVelocity: 10000

        model: Models.RulebookIndexModel {}

        delegate: ItemDelegate {
            width: parent.width
            padding: 0
            text: title
            font.pixelSize: 21
            font.bold: !subitem
            leftPadding: subitem ? 24 : 8

            onClicked: {
                root.openSection(element)
            }
        }
    }
}
