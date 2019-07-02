import QtQuick 2.12

ListModel {
    ListElement {
        title: qsTr("Introduction")
        element: 2
        subitems: [
            ListElement {
                title: qsTr("Contents")
                element: 4
            },
            ListElement {
                title: qsTr("Extra Cards")
                element: 6
            }
        ]
    }
    ListElement {
        title: qsTr("Game Overview")
        element: 8
    }
    ListElement {
        title: qsTr("Game Setup")
        element: 10
    }
    ListElement {
        title: qsTr("Cards")
        element: 12
        subitems: [
            ListElement {
                title: qsTr("Command, Battle and Knowledge Points")
                element: 13
            },
            ListElement {
                title: qsTr("Command, Building and Troop Cards")
                element: 14
            },
            ListElement {
                title: qsTr("Actions")
                element: 15
            }
        ]
    }
    ListElement {
        title: qsTr("Extra Cards")
        element: 17
    }
}
