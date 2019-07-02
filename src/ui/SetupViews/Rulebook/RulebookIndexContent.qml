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
        source: "qrc:/assets/rulebook_page_background.png"
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
        spacing: 24

        model: Models.RulebookIndexModel {}

        delegate: ItemDelegate {
            width: parent.width
            padding: 0

            contentItem: ColumnLayout {
                spacing: 16

                Label {
                    text: title
                    font.pixelSize: 21
                    font.bold: true
                    leftPadding: 8
                }

                Repeater {
                    model: subitems
                    delegate: ItemDelegate {
                        padding: 0
                        Layout.fillWidth: true
                        Layout.fillHeight: false

                        contentItem: Label {
                            text: title
                            wrapMode: Text.Wrap
                            font.pixelSize: 21
                            leftPadding: 24

                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            root.openSection(element)
                        }
                    }
                }
            }

            onClicked: {
                root.openSection(element)
            }
        }
    }
}
