import QtQuick 2.0
import QtQuick.Controls 2.12

import "../" as Ui

Ui.BaseContent {
    id: root

    property alias url: img.source

    Image {
        id: img

        width: parent.width
        fillMode: Image.PreserveAspectFit
    }


}
