import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Ui.BaseContent {
    id: root
    title: qsTr("Artwork")

    RowLayout {
        width: parent.width
        height: 80
        TabButton {
            icon.source: this.down || this.checked ? "qrc:/assets/griglia_filled.svg" : "qrc:/assets/griglia.svg"

            onClicked: console.log("griglia")

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        TabButton {
            icon.source: this.down || this.checked ? "qrc:/assets/listing_filled.svg" : "qrc:/assets/listing.svg"

            onClicked: console.log("lista")

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
