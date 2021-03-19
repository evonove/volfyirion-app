import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Label {
    textFormat: Text.RichText
    wrapMode: Text.Wrap
    focus: true
    font.pixelSize: 18
    font.bold: false
    horizontalAlignment: Text.AlignJustify

    Layout.fillWidth: true
    Layout.leftMargin: 8
    Layout.rightMargin: 8
}
