import QtQuick 2.0
import QtQuick.Controls 2.12

import "../" as Ui

Ui.BaseContent {
    id: root

    property alias url: img.source

    title: qsTr("Artworks")

    Image {
        id: img

        width: root.width
        fillMode: Image.PreserveAspectCrop
    }


}
