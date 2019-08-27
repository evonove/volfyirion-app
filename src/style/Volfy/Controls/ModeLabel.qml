import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "../../../ui/SetupViews/Rulebook" as RulebookElement

ColumnLayout {
    property alias userConditionUrl: _userConditionUrl.source
    property alias playMode: _mode.text
    spacing: 15
    Item {
        implicitHeight: _backgroundSolo.paintedHeight
        Layout.fillWidth: true

        Image {
            id: _backgroundSolo

            source: "qrc:/assets/rulebook/background/BG-MODE.png"
            fillMode: Image.PreserveAspectCrop
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            anchors.fill: _backgroundSolo
            color: "#2C2B2B"
            opacity: 0.1
        }

        RulebookElement.RulebookTitle {
            id: _mode
            width: parent.width
            anchors.bottom: _backgroundSolo.bottom

            horizontalAlignment: Qt.AlignHCenter
        }
    }

    Image {
        id: _userConditionUrl
        fillMode: Image.PreserveAspectFit
        smooth: false

        Layout.fillWidth: true
        Layout.preferredWidth: 180
        Layout.preferredHeight: 69
        Layout.alignment: Qt.AlignHCenter
    }
}


