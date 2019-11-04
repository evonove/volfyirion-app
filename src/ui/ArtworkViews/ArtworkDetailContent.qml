import QtQuick 2.0
import QtQuick.Controls 2.12

import "../" as Ui
import Downloader 1.0

Ui.BaseContent {
    id: root

    property alias url: img.source

    hasToolbar: true
    title: qsTr("Artworks")
    rightAction: Action {
        icon.source: "qrc:/assets/artworks/download.svg"
        onTriggered: {
            // download artwork image
            console.log("download image", root.url);
            Downloader.saveArtworkInPictures(root.url);
        }
    }

    Image {
        id: img

        width: root.width
        fillMode: Image.PreserveAspectCrop
    }


}
