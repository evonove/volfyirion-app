import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

ToolBar {
    id: root

    property int resultsCount: 0
    property int currentResult: 0

    signal search(string text)
    signal previous
    signal next

    topInset: 15
    topPadding: 15
    bottomInset: 3
    bottomPadding: 3
    leftInset: 26
    leftPadding: 26
    rightInset: 26
    rightPadding: 26

    background: Item {
        implicitHeight: 40

        DropShadow {
            id: dropShadow
            anchors.fill: backgroundRect
            verticalOffset: 2
            radius: 20.0
            samples: 17
            color: "#80000000"
            source: backgroundRect
        }

        Rectangle {
            id: backgroundRect
            anchors.fill: parent
            color: root.palette.window
            radius: 2
        }
    }

    RowLayout {
        anchors.fill: parent

        TextField {
            leftPadding: _searchIcon.x * 2 + _searchIcon.width

            Image {
                id: _searchIcon
                x: 12
                width: 21
                height: 21
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/search_icon.svg"
                sourceSize.height: height
                sourceSize.width: height
                smooth: false
            }

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: 280

            verticalAlignment: TextInput.AlignVCenter
            font.pixelSize: 18
            placeholderText: qsTr("Search")

            onAccepted: {
                root.search(text)
                // Activate navigation controls the first
                // time a search is performed
                _p.showNavigation = true
            }
        }

        ToolButton {
            icon.source: "qrc:/assets/back_icon.svg"
            icon.width: 21
            icon.height: 21
            visible: _p.showNavigation
            enabled: _p.showNavigation

            Layout.preferredHeight: 40
            Layout.preferredWidth: 40

            onClicked: root.previous()
        }

        Label {
            text: "%1/%2".arg(root.currentResult).arg(root.resultsCount)
            font.pixelSize: 15
            font.bold: true
            visible: _p.showNavigation
            enabled: _p.showNavigation
        }

        ToolButton {
            icon.source: "qrc:/assets/forward_icon.svg"
            icon.width: 21
            icon.height: 21
            visible: _p.showNavigation
            enabled: _p.showNavigation

            Layout.preferredHeight: 40
            Layout.preferredWidth: 40

            onClicked: root.next()
        }
    }

    QtObject {
        id: _p
        property bool showNavigation: false
    }
}
