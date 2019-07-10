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
        contentHeight: height

        flickableDirection: Flickable.HorizontalAndVerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        PinchArea {
            id: pinch
            width: Math.max(flick.contentWidth, flick.width)
            height: Math.max(flick.contentHeight, flick.height)

            property real initialWidth
            property real initialHeight

            pinch.minimumScale: 1
            pinch.maximumScale: 10

            onPinchStarted: {
                initialWidth = flick.contentWidth
                initialHeight = flick.contentHeight
            }

            onPinchUpdated: {

                // Resize content only when the scaled size is bigger to root width
                if (initialWidth * pinch.scale > root.width) {

                    // Adjust content pos due to drag
                    flick.contentX += pinch.previousCenter.x - pinch.center.x
                    flick.contentY += pinch.previousCenter.y - pinch.center.y

                    flick.resizeContent(initialWidth * pinch.scale,
                                        initialHeight * pinch.scale,
                                        pinch.center)
                }
            }

            onPinchFinished: {
                // Move its content within bounds.
                flick.returnToBounds()
            }

            Pane {
                width: flick.contentWidth
                height: flick.contentHeight
                topPadding: 16
                bottomPadding: 16

                background: null
                Image {
                    id: setupImage
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/assets/volf_setup_01.png"
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: {
                            // Resize content of Flickable only when it is bigger than root dims
                            if (flick.contentWidth > root.width) {

                                flick.contentHeight = flick.height
                                flick.contentWidth = flick.width

                                flick.contentX = pinch.x
                                flick.contentY = pinch.y
                            }
                        }
                    }
                }
            }
        }
    }
}
