import QtQuick 2.12
import QtQuick.Controls 2.12

Image {
    source: "qrc:/assets/rulebook_section_header.svg"
    smooth: false

    property alias text: _label.text

    Label {
        id: _label
        anchors.centerIn: parent
        font.capitalization: Font.AllUppercase
        font.pixelSize: 24
    }
}
