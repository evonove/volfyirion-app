import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../" as Ui

Ui.BaseContent {
    id: root
    title: qsTr("Artwork")
    ColumnLayout {
        anchors.fill: parent

       TabBar {
           Layout.fillWidth: true
           implicitHeight: 75

           currentIndex: swipe.currentIndex

            TabButton {
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height

                icon.source: this.down
                             || this.checked ? "qrc:/assets/griglia_filled.svg" : "qrc:/assets/griglia.svg"

                onClicked: {
                    swipe.currentIndex = 0
                    console.log("griglia")
                }
            }

            TabButton {
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height

                icon.source: this.down
                             || this.checked ? "qrc:/assets/listing_filled.svg" : "qrc:/assets/listing.svg"

                onClicked: {
                    swipe.currentIndex = 1
                    console.log("lista")
                }
            }
        }

        SwipeView {
            id: swipe
            currentIndex: 0
            Layout.fillWidth: true
            Layout.fillHeight: true

            Item {
                id: grid

                Label {
                    text: "griglia"
                }

                Rectangle {
                    color: "transparent"
                    border.color: "red"
                    border.width: 2
                }
            }

            Item {
                id: list

                Label {
                    text: "lista"
                }

                Rectangle {
                    color: "transparent"
                    border.color: "red"
                    border.width: 2
                }
            }

        }

    }
}
