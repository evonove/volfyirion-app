import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Ui.BasePage {
    id: root
    initialItem: artworkContent

    property string name: ""
    property string url: ""

    Component {
        id: artworkContent
        ArtworkContent {
            hasToolbar: true
            topPadding: root.headerHeight

            onArtworkDetailClicked: {
                root.name = name
                root.url = url
                root.push(artworkDetail)}
        }
    }

    Component {
        id: artworkDetail
        Ui.BaseContent {
            id: ciao
            hasToolbar: true
            topPadding: root.headerHeight + 30

            leftAction: Action {
                id: _backAction
                icon.source: "qrc:/assets/back_icon.svg"
                onTriggered: root.pop()
            }

            title: root.name

            Image {
                anchors.topMargin: 100

                width: parent.width
                source: root.url
                fillMode: Image.PreserveAspectFit
            }


        }
    }
}
