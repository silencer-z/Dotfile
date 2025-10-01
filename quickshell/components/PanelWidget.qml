import QtQuick

Rectangle {
    id: root

    property real borderWidth: 1
    property color borderColor: "red"

    property real paddingTop: 3
    property real paddingBottom: 3
    property real paddingLeft: 3
    property real paddingRight: 3


    border.width: root.borderWidth
    border.color: root.borderColor

    color:"transparent"
    radius:10

    default property alias data: content.data

    implicitWidth: content.implicitWidth + paddingLeft + paddingRight
    implicitHeight: content.implicitHeight + paddingBottom + paddingTop

    Item {
        id: content
        anchors {
            top: parent.top;    topMargin: root.paddingTop
            bottom: parent.bottom; bottomMargin: root.paddingBottom
            left: parent.left;  leftMargin: root.paddingLeft
            right: parent.right; rightMargin: root.paddingRight
        }

        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
    }
}