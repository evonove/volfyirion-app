import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../../" as Ui
import "./Models" as Models

Ui.BaseContent {
    function scrollTo(element) {
        _contentLoader.item.positionViewAtIndex(element, ListView.SnapPosition)
    }

    title: qsTr("rulebook")

    isLoading: !(StackView.status === StackView.Active
                 && _contentLoader.status === Loader.Ready)
    opacity: isLoading ? 0.0 : 1.0

    Behavior on opacity {
        NumberAnimation {
            duration: 100
        }
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
        onReset: _search.reset()

        enabled: _contentLoader.status === Loader.Ready
    }

    Loader {
        id: _contentLoader

        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        asynchronous: true

        sourceComponent: _listView
    }

    Component {
        id: _listView

        ListView {
            id: flick

            property real searchMargin: 120

            boundsBehavior: Flickable.StopAtBounds
            maximumFlickVelocity: 10000
            preferredHighlightBegin: searchMargin
            preferredHighlightEnd: searchMargin + 80

            function ensureVisible(oritem) {
                var r = flick.contentItem.mapFromItem(item, or.x, or.y,
                                                      or.width, or.height)

                //console.log(contentY, height, r)
                //console.log(contentY + _searchBar.height, r.y, r.y - _searchBar.height)
                //console.log(contentY + height, r.y + r.height, r.y + r.height - height)
                if (contentY + _searchBar.height >= r.y)
                    contentY = r.y - _searchBar.height
                else if (contentY + height <= r.y + r.height)
                    contentY = r.y + r.height - height
            }

            spacing: 0
            cacheBuffer: 1000000

            model: Models.RulebookModel {
                id: _model
                width: flick.width
            }
        }
    }
}
