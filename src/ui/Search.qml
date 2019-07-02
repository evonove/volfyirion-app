import QtQuick 2.12

QtObject {
    id: root

    /* Set searchable property to a list of item ids that needs to be searched.
     * Each item should have a 'text' property where the regex is executed. */
    property var searchable: []

    /* Results list is filled when 'search' method is called and if
     * there are matches */
    property var results: []

    /* The number of matches found for the string in the searchable items */
    property var count: 0

    /* The index of the item that should be currently highlighted */
    property int currentIndex: -1

    signal selectionAt(rect cursorRectangle, var item)

    /* The only function that needs to be called to use the search engine.
     * The only parameter is the text string that needs to be searched */
    function search(searchText) {
        // Removes selection if there is one active
        root.deselectCurrent();

        // Before any search we reset the count, the results list
        // ant current index
        root.count = 0
        root.results = []
        root.currentIndex = -1

        let text = searchText.trim();
        // Avoid triggering a search if string is blank
        if (text === "") {
            return;
        }

        // Here we store the length of the string for future reference.
        // It's needed later when we need to compute the endIndex of
        // the selection.
        let textLength = text.length

        // Perform a global, case-insensitive search
        let regexp = new RegExp(text, 'gi')

        for (let item of root.searchable) {
            // Here we iterate over each match and extract the start index
            let matches = null
            while ((matches = regexp.exec(item.text)) !== null) {
                let startIndex = regexp.lastIndex - matches[0].length
                root.results.push({
                                         "item": item,
                                         "startIndex": startIndex,
                                         "endIndex": startIndex + textLength
                                     })
            }
        }
        root.count = root.results.length

        // try to select the first result if available
        root.next()
    }

    function deselectCurrent() {
        // deselect current index
        if (root.currentIndex !== -1) {
            var result = root.results[root.currentIndex]
            result.item.deselect()
        }
    }

    function selectCurrent() {
        // selects current index
        if (root.currentIndex !== -1) {
            var result = root.results[root.currentIndex]
            result.item.select(result.startIndex, result.endIndex)
            root.selectionAt(result.item.cursorRectangle, result.item)
        }
    }

    function next() {
        root.deselectCurrent()
        // There are no results so we just return
        if (root.count === 0) {
            return
        }
        // Move to the next index or cycle to the first if we are
        // at the end of the results list
        root.currentIndex += 1
        if (root.currentIndex >= root.count) {
            root.currentIndex = 0
        }
        root.selectCurrent()
    }

    function prev() {
        root.deselectCurrent()
        // There are no results so we just return
        if (root.count === 0) {
            return
        }
        // Move to the previous index or cycle to the last if we are
        // at the beginning of the results list
        root.currentIndex -= 1
        if (root.currentIndex < 0) {
            root.currentIndex = root.count - 1
        }
        root.selectCurrent()
    }
}
