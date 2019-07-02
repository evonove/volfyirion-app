import QtQuick 2.12
import QtQuick.Controls 2.12

import Volfy.Controls 1.0


Label {
    font.capitalization: Font.AllUppercase
    font.pixelSize: 20

    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter

    background: ButtonShape {
        implicitHeight: 45

        strokeColor: palette.mid
        fillColor: "transparent"
    }
}

