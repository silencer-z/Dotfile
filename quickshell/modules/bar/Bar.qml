import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects

import "./widgets" as Widgets

import qs.components as Components
import qs.services

// PanelWindow {
Item{
    id: root

    required property ShellScreen screen
    // required property var wrapper
    // color: "transparent"
    // WlrLayershell.namespace:"QS-Desktop"
    // WlrLayershell.exclusiveZone:bar.height
    // WlrLayershell.exclusionMode:ExclusionMode.Ignore
    readonly property int exclusiveZone:bar.height
    readonly property var currentMonitor: Brightness.getMonitorForScreen(root.screen)

    property int barRadius: 0
    
    property int barHMargin: 0
    property int barVMargin: 10

    implicitHeight:bar.height

    // anchors {
    //     top: true
    //     left: true
    //     bottom: false
    //     right: true
    // }
    anchors.top: parent.top
    // anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right:parent.right

    Rectangle {
        id: bar
        height:32
        anchors.top: parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.leftMargin: root.barHMargin
        anchors.rightMargin: root.barHMargin
        color: "#1e1e2e"

        radius: root.barRadius

        Item {
            anchors.fill: parent
            // spacing: 0

            RowLayout {
                // Layout.alignment: Qt.AlignLeft
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                // Layout.fillWidth: true

                Widgets.Board {
                    Layout.fillWidth: false
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: 7
                }

                Widgets.ActiveApps {
                    Layout.fillWidth: false
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: 7
                }
            }

            RowLayout {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                Widgets.Workspaces {
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth: false
                    Layout.fillHeight: true
                    Layout.topMargin: 3
                    Layout.bottomMargin: 3
                }
            }

            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                Widgets.SysTray {
                    Layout.fillWidth: false
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignVCenter
                    // barWrapper:wrapper
                }

                Widgets.WidgetsGroup {
                    Layout.fillWidth: false
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignVCenter
                    monitor: currentMonitor
                }
                Widgets.Clock{
                    Layout.fillWidth:false
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignVCenter
                    Layout.rightMargin:7
                }
            }
        }
    }
}

