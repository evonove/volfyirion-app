import QtQuick 2.12
import QtQuick.Shapes 1.12

Shape {
    id: root

    property int triangle: 20

    property alias strokeColor: shapePath.strokeColor
    property alias fillColor: shapePath.fillColor

    ShapePath {
        id: shapePath

        strokeWidth: 2
        strokeColor: "#B58022"
        fillColor: "#501A1C"

        capStyle: ShapePath.RoundCap
        joinStyle: ShapePath.RoundJoin

        startX: 0
        startY: root.height / 2

        PathLine {
            x: root.triangle
            y: 0
        }
        PathLine {
            x: root.width - root.triangle
            y: 0
        }
        PathLine {
            x: root.width
            y: root.height / 2
        }
        PathLine {
            x: root.width - root.triangle
            y: root.height
        }
        PathLine {
            x: root.triangle
            y: root.height
        }
        PathLine {
            x: 0
            y: root.height / 2
        }
    }
}
