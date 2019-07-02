import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../../" as Ui
import "./Models" as Models

Ui.BaseContent {
    title: qsTr("rulebook")

    opacity: StackView.status === StackView.Active && _contentLoader.status === Loader.Ready ? 1.0 : 0.0

    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    Ui.Search {
        id: _search
        searchable: _contentLoader.item.model.searchable
        onSelectionAt: _contentLoader.item.ensureVisible(cursorRectangle, item)
    }

    Ui.SearchBar {
        id: _searchBar
        width: parent.width
        z: 2

        resultsCount: _search.count
        currentResult: _search.currentIndex + 1

        onSearch: _search.search(text)
        onPrevious: _search.prev()
        onNext: _search.next()

        enabled: _contentLoader.status === Loader.Ready
    }

    Loader {
        id: _contentLoader

        anchors.fill: parent
        anchors.leftMargin: 24
        anchors.rightMargin: 24
        asynchronous: true

        sourceComponent: _listView
    }

    Component {
        id: _listView

        ListView {
            id: flick

            property real searchMargin: 120

            function ensureVisible(or, item) {
                let r = flick.contentItem.mapFromItem(item, or.x, or.y, or.width, or.height)

                console.log(contentY, height, r)
                console.log(contentY + _searchBar.height, r.y, r.y - _searchBar.height)
                console.log(contentY + height, r.y + r.height, r.y + r.height - height)

                if (contentY + _searchBar.height >= r.y)
                    contentY = r.y - _searchBar.height
                else if (contentY + height <= r.y + r.height)
                    contentY = r.y + r.height - height
            }

            spacing: 0
            cacheBuffer: contentItem.height> 0 ? contentItem.height : 100

            model: Models.RulebookModel {
                id: _model
                width: flick.width
            }
        }
    }
}
