import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Volfy.Controls 1.0

import "../../" as Ui

Ui.BaseContent {
    title: qsTr("rulebook")

    Ui.Search {
        id: _search
        searchable: [edit1, edit2]
        onSelectionAt: flick.ensureVisible(cursorRectangle, yPos)
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
    }

    Flickable {
        id: flick
        anchors.fill: parent

        contentWidth: contentItem.childrenRect.width
        contentHeight: contentItem.childrenRect.height

        clip: true

        function ensureVisible(r, shift) {
            if (contentX >= r.x)
                contentX = r.x
            else if (contentX + width <= r.x + r.width)
                contentX = r.x + r.width - width

            if (contentY + _searchBar.height >= r.y + shift)
                contentY = r.y + shift - _searchBar.height
            else if (contentY + height <= r.y + shift + r.height)
                contentY = r.y + shift + r.height - height
        }

        TextField {
            id: edit1
            text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat felis risus, eu pulvinar est faucibus eu. Suspendisse sit amet ultrices augue. Curabitur id eleifend enim, id egestas turpis. Suspendisse eleifend elit at augue elementum pharetra. Integer tempus odio ut urna porttitor, id fringilla arcu mollis. Nulla rhoncus eu massa non tincidunt. Integer non scelerisque sem, at tempus risus. Sed vel lobortis massa. Donec eget elementum mauris, nec ultrices dui. Maecenas id sem vel lectus feugiat vehicula. Cras volutpat commodo gravida. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer bibendum sapien vitae arcu ultrices tristique.
Etiam condimentum pretium ante eu rutrum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Interdum et malesuada fames ac ante ipsum primis in faucibus. Mauris id tincidunt libero. Maecenas vel nisi lorem. Curabitur bibendum sit amet massa id auctor. Nunc euismod congue sem, at euismod ex blandit ac. Donec viverra posuere odio eu consectetur.
Donec feugiat massa nisi, sed imperdiet neque hendrerit sed. Sed euismod purus id nunc sollicitudin aliquam. Sed ultrices eget felis vel lacinia. Maecenas a volutpat eros. Vivamus convallis purus vitae hendrerit tincidunt. Duis porta dui ante, ut viverra sapien ultrices a. Nam pharetra dignissim fringilla. Pellentesque urna massa, eleifend non neque ut, ullamcorper consequat turpis.
Praesent tempor odio faucibus posuere facilisis. Aliquam ultrices eros non ante eleifend, eget aliquam orci feugiat. In ultricies massa nec purus malesuada mollis. Morbi tristique tortor in dictum pretium. Nam et purus sit amet enim aliquet egestas. Maecenas a nisl nec dolor dignissim commodo at quis lacus. Sed consequat justo et ligula sagittis tincidunt. Nam tortor purus, bibendum vel molestie id, egestas vel neque.
Mauris ultricies sit amet mauris eget pellentesque. Aliquam vitae pellentesque lorem. Sed sodales odio tortor, sed aliquet urna tristique eget. Etiam tristique felis eget magna tincidunt scelerisque. Vestibulum a purus eget quam blandit pretium. Praesent sit amet dolor hendrerit, varius nunc at, tempor lacus. Aliquam sed cursus tortor. Nunc vel ligula sapien. Ut sit amet tincidunt felis. Suspendisse non augue vitae quam commodo porta vitae ut orci. Mauris tincidunt molestie nunc, a aliquet ex aliquet vitae. Maecenas mattis dui lacus, eu laoreet elit malesuada sit amet. Vivamus vitae bibendum est. Fusce mattis ligula vel justo dignissim, at eleifend dui molestie. "
            enabled: false

            width: flick.width
            focus: true
            wrapMode: TextEdit.Wrap
            font.pixelSize: 18
        }

        TextField {
            id: edit2
            anchors.top: edit1.bottom
            text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat felis risus, eu pulvinar est faucibus eu. Suspendisse sit amet ultrices augue. Curabitur id eleifend enim, id egestas turpis. Suspendisse eleifend elit at augue elementum pharetra. Integer tempus odio ut urna porttitor, id fringilla arcu mollis. Nulla rhoncus eu massa non tincidunt. Integer non scelerisque sem, at tempus risus. Sed vel lobortis massa. Donec eget elementum mauris, nec ultrices dui. Maecenas id sem vel lectus feugiat vehicula. Cras volutpat commodo gravida. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer bibendum sapien vitae arcu ultrices tristique.
Etiam condimentum pretium ante eu rutrum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Interdum et malesuada fames ac ante ipsum primis in faucibus. Mauris id tincidunt libero. Maecenas vel nisi lorem. Curabitur bibendum sit amet massa id auctor. Nunc euismod congue sem, at euismod ex blandit ac. Donec viverra posuere odio eu consectetur.
Donec feugiat massa nisi, sed imperdiet neque hendrerit sed. Sed euismod purus id nunc sollicitudin aliquam. Sed ultrices eget felis vel lacinia. Maecenas a volutpat eros. Vivamus convallis purus vitae hendrerit tincidunt. Duis porta dui ante, ut viverra sapien ultrices a. Nam pharetra dignissim fringilla. Pellentesque urna massa, eleifend non neque ut, ullamcorper consequat turpis.
Praesent tempor odio faucibus posuere facilisis. Aliquam ultrices eros non ante eleifend, eget aliquam orci feugiat. In ultricies massa nec purus malesuada mollis. Morbi tristique tortor in dictum pretium. Nam et purus sit amet enim aliquet egestas. Maecenas a nisl nec dolor dignissim commodo at quis lacus. Sed consequat justo et ligula sagittis tincidunt. Nam tortor purus, bibendum vel molestie id, egestas vel neque.
Mauris ultricies sit amet mauris eget pellentesque. Aliquam vitae pellentesque lorem. Sed sodales odio tortor, sed aliquet urna tristique eget. Etiam tristique felis eget magna tincidunt scelerisque. Vestibulum a purus eget quam blandit pretium. Praesent sit amet dolor hendrerit, varius nunc at, tempor lacus. Aliquam sed cursus tortor. Nunc vel ligula sapien. Ut sit amet tincidunt felis. Suspendisse non augue vitae quam commodo porta vitae ut orci. Mauris tincidunt molestie nunc, a aliquet ex aliquet vitae. Maecenas mattis dui lacus, eu laoreet elit malesuada sit amet. Vivamus vitae bibendum est. Fusce mattis ligula vel justo dignissim, at eleifend dui molestie. "
            enabled: false

            font.pixelSize: 18
            width: flick.width
            focus: true
            wrapMode: TextEdit.Wrap
        }
    }
}
