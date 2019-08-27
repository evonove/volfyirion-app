import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "../../../ui/SetupViews/Rulebook" as RulebookElement

ColumnLayout {
    property alias userConditionUrl: _userConditionUrl.source
    property alias playMode: _mode.text
    spacing: 15
    Item {
        height: _backgroundSolo.paintedHeight
        Layout.fillWidth: true

        Image {
            id: _backgroundSolo
            height: 437
            source: "qrc:/assets/rulebook/rulebook_page_background.png"
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            anchors.fill: _backgroundSolo
            color: "#80000000"
            opacity: 0.6
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


