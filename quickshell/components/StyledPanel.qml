import QtQuick

Item{
    id : root
    property real panelRadius:25
    default property alias data: content.data

    property alias contentWidth:content.implicitWidth
    property alias contentHeight:content.implicitHeight

    implicitWidth:content.implicitWidth + panelRadius*2
    implicitHeight:opened?content.implicitHeight:0
    clip:true

    property bool opened: false

    Behavior on implicitHeight {
        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
    }

    Rectangle{
        id:background
        z :-1
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.leftMargin:root.panelRadius
        anchors.rightMargin:root.panelRadius
        height:parent.height + root.panelRadius
        radius:root.panelRadius
        color:"#1e1e2e"
        border.width:1
        border.color:"white"
    }
    Item{
        id:content
        anchors.bottom:root.bottom
        anchors.top:root.top
        anchors.left:background.left
        anchors.right:background.right

    }

    RoundCorner {
        id: leftCorner
        anchors {
            bottom: parent.bottom
            right: background.left
        }

        size: root.panelRadius + 10
        color: "#1e1e2e"
        corner: RoundCorner.CornerEnum.BottomRight
    }
    RoundCorner {
        id: rightCorner
        anchors {
            left: background.right
            bottom: parent.bottom
        }
        size: root.panelRadius + 10
        color: "#1e1e2e"
        corner: RoundCorner.CornerEnum.BottomLeft
    }
}