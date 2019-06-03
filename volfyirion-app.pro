TEMPLATE = subdirs

SUBDIRS += src

!no-tests {
    SUBDIRS += tests
}
