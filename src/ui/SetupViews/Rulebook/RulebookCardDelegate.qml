import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    property alias source: _image.source

    property alias title: _title.text

    property alias description: _description.text

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        Image {
            id: _image
            fillMode: Image.PreserveAspectFit

            Layout.preferredHeight: 118
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.leftMargin: 13
            Layout.rightMargin: 13
        }

        Column {
            Layout.preferredWidth: 120
            Layout.preferredHeight: 47
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.leftMargin: 13
            Layout.rightMargin: 13

            Label {
                id: _title
                width: parent.width
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 14
                font.capitalization: Font.AllUppercase
            }

            Label {
                id: _description
                width: parent.width
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 10
                font.capitalization: Font.AllUppercase
            }
        }


    }
}
