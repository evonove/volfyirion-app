import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../../" as Ui
import "./Models" as Models

Ui.BaseContent {
    id: root

    property Models.RulebookModel rulebookModel: null

    function scrollTo(element) {
        _contentLoader.item.positionViewAtIndex(element, ListView.SnapPosition)
    }

    title: qsTr("rulebook")

    isLoading: !(StackView.status === StackView.Active
                 && _contentLoader.status === Loader.Ready
                 && root.rulebookModel.status === Loader.Ready)
    opacity: root.isLoading ? 0.0 : 1.0

    Behavior on opacity {
        NumberAnimation {
            duration: 100
        }
    }

    Ui.Search {
        id: _search
        searchable: root.rulebookModel.searchable
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

        property date started: new Date()

        onStatusChanged: {
            if (status === Loader.Loading) {
                started = new Date()
            }
            if (status === Loader.Ready) {
                let finished = new Date()
                let elapsed = finished - started
                console.log("Elapsed: " + elapsed)
            }
        }
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

            function ensureVisible(or, item) {
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

            model: root.rulebookModel.model
            onModelChanged: {
                // this is needed in order to set the internal width of the
                // components of the object model to the size of the
                // list view
                root.rulebookModel.width = flick.width
                root.rulebookModel.contentMargins = _contentLoader.anchors.leftMargin + _contentLoader.anchors.rightMargin
            }
        }
    }
}
