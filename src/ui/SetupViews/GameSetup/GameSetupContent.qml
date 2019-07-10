import QtQuick 2.12
import QtQuick.Controls 2.12

import "../../" as Ui

Ui.BaseContent {
    id: root

    title: qsTr("game setup")

    Flickable {
        id: flick
        anchors.fill: parent
        contentWidth: width
        contentHeight: height - 32

        topMargin: 16
        bottomMargin: 16

        flickableDirection: Flickable.HorizontalAndVerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        PinchArea {
            width: Math.max(flick.contentWidth, flick.width)
            height: Math.max(flick.contentHeight, flick.height)

            property real initialWidth
            property real initialHeight

            pinch.minimumRotation: 0
            pinch.maximumRotation: 0
            pinch.minimumScale: 1
            pinch.maximumScale: 10

            onPinchStarted: {
                initialWidth = flick.contentWidth
                initialHeight = flick.contentHeight
            }

            onPinchUpdated: {
                // adjust content pos due to drag
                flick.contentX += pinch.previousCenter.x - pinch.center.x
                flick.contentY += pinch.previousCenter.y - pinch.center.y

                // resize content
                flick.resizeContent(initialWidth * pinch.scale,
                                    initialHeight * pinch.scale, pinch.center)
            }

            onPinchFinished: {
                // Move its content within bounds.
                flick.returnToBounds()
            }

            Item {
                width: flick.contentWidth
                height: flick.contentHeight
                Image {
                    id: setupImage
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/assets/volf_setup_01.png"
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: {
                            flick.contentWidth = flick.width
                            flick.contentHeight = flick.height - 32
                        }
                    }
                }
            }
        }
    }
}
