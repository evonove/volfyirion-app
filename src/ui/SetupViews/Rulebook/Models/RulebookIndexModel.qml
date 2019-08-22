import QtQuick 2.12

ListModel {
    ListElement {
        title: qsTr("Introduction")
        element: 2
        subitem: false
    }
    ListElement {
        title: qsTr("Contents")
        element: 4
        subitem: true
    }
    ListElement {
        title: qsTr("Extra Cards")
        element: 6
        subitem: true
    }
    ListElement {
        title: qsTr("Game Overview")
        element: 8
        subitem: false
    }
    ListElement {
        title: qsTr("Game Setup")
        element: 10
        subitem: false
    }
    ListElement {
        title: qsTr("Cards")
        element: 12
        subitem: false
    }
    ListElement {
        title: qsTr("Command, Battle and Knowledge Points")
        element: 13
        subitem: true
    }
    ListElement {
        title: qsTr("Command, Building and Troop Cards")
        element: 15
        subitem: true
    }
    ListElement {
        title: qsTr("Wonder Cards")
        element: 17
        subitem: true
    }
    ListElement {
        title: qsTr("City Cards")
        element: 19
        subitem: true
    }
    ListElement {
        title: qsTr("In-Play Cards")
        element: 21
        subitem: true
    }
    ListElement {
        title: qsTr("How to play")
        element: 23
        subitem: false
    }
    ListElement {
        title: qsTr("Draw phase")
        element: 25
        subitem: true
    }
}
