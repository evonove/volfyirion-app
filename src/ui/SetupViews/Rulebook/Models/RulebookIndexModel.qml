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
        element: 14
        subitem: true
    }
    ListElement {
        title: qsTr("Actions")
        element: 15
        subitem: true
    }
    ListElement {
        title: qsTr("Extra Cards")
        element: 17
        subitem: false
    }
}
