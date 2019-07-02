import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    property alias source: _image.source

    property alias title: _title.text

    property alias description: _description.text

    ColumnLayout {
        anchors.fill: parent

        Image {
            id: _image
            fillMode: Image.PreserveAspectFit

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.bottomMargin: 13
            Layout.leftMargin: 13
            Layout.rightMargin: 13
        }

        Label {
            id: _title
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter

            font.pixelSize: 14
            font.capitalization: Font.AllUppercase

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.leftMargin: 13
            Layout.rightMargin: 13
        }

        Label {
            id: _description
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter

            font.pixelSize: 10
            font.capitalization: Font.AllUppercase

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.bottomMargin: 18
            Layout.leftMargin: 13
            Layout.rightMargin: 13
        }
    }
}
