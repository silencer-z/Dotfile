import QtQuick
import Quickshell
import Qt5Compat.GraphicalEffects

PopupWindow {
    id: root
    visible: true
    color: "transparent"

    // 定义动画参数
    property int animationDuration: 150
    property color backgroundColor: "#1e1e2e"
    property int cornerRadius: 8

    property point transformOrigin: Qt.point(width / 2, 0)

    ParallelAnimation {
        id: openAnimation
        NumberAnimation { target: contentRect; property: "opacity"; from: 0; to: 1.0; duration: root.animationDuration * 0.8; easing.type: Easing.OutQuad }
        NumberAnimation { target: contentRect; property: "scale"; from: 0.9; to: 1.0; duration: root.animationDuration; easing.type: Easing.OutBack; easing.overshoot: 1.2 }
        NumberAnimation { target: contentRect; property: "y"; from: -15; to: 0; duration: root.animationDuration; easing.type: Easing.OutCubic }
    }

    ParallelAnimation {
        id: closeAnimation
        NumberAnimation { target: contentRect; property: "opacity"; from: 1.0; to: 0; duration: root.animationDuration * 0.8; easing.type: Easing.InQuad }
        NumberAnimation { target: contentRect; property: "scale"; from: 1.0; to: 0.9; duration: root.animationDuration; easing.type: Easing.InCubic }
        NumberAnimation { target: contentRect; property: "y"; from: 0; to: -15; duration: root.animationDuration; easing.type: Easing.InCubic }
        onFinished: root.visible = false
    }



    function open() {
        closeAnimation.stop()
        root.visible = true
        openAnimation.start()
    }

    function close() {
        openAnimation.stop()
        closeAnimation.start()
    }

    Rectangle {
        id: contentRect
        anchors.fill: parent

        transform: Scale {
            origin.x: root.transformOrigin.x
            origin.y: root.transformOrigin.y
        }

        opacity: 0
        scale: 0.9
        y: -15

        color: root.backgroundColor
        radius: root.cornerRadius
        layer.enabled: true
        layer.smooth: true
        layer.effect: DropShadow {
            transparentBorder: true; radius: 12; spread: 0.1; samples: 16; color: "#20000000"
        }

        Item {
            id: contentContainer
            anchors.fill: parent
            default property alias children: contentContainer.data
        }
    }

    property alias content: contentContainer.children
}