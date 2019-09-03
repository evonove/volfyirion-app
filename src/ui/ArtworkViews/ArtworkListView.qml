import QtQuick 2.0
import QtQuick.Controls 2.12

ListView {
    id: root

    spacing: 24
    delegate: Image {
        width: root.width
        source: model.bigUrl
        fillMode: Image.PreserveAspectCrop
    }
}
