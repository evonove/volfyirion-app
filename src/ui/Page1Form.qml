import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    width: 600
    height: 400

    property string text: qsTr("Page 1")

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Button {
            id: button
            text: qsTr("Button")
            highlighted: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Label {
            text: qsTr("You are on Page 1.")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
    }
}
