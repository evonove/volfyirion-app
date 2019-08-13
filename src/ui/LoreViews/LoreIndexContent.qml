import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "../" as Ui
import "./Models" as Models

Ui.BaseContent {
    id: root

    signal openSection(int element)

    title: qsTr("index")

    isLoading: !(StackView.status === StackView.Active
                 && _image.status === Image.Ready)
    opacity: isLoading ? 0 : 1

    Behavior on opacity {
        NumberAnimation {
            duration: 400
        }
    }

    background: Image {
        id: _image
        source: "qrc:/assets/background_lore_index.webp"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true

        Rectangle {
            anchors.fill: parent
            color: "#2C2B2B"
            opacity: 0.7
        }
    }

    ListView {
        anchors.fill: parent
        anchors.margins: 24

        boundsBehavior: Flickable.StopAtBounds
        maximumFlickVelocity: 10000

        model: Models.LoreIndexModel {
        }

        delegate: ItemDelegate {
            text: "<b>%1</b>: %2".arg(model.chapter).arg(model.chapterTitle)
            font.pixelSize: 19
            font.letterSpacing: 0.5

            onClicked: {
                root.openSection(index)
            }
        }
    }
}
