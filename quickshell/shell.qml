import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import "./modules/bar"
import "./components" as Components
import "./modules/panels" as Panels

ShellRoot{
    id:root

    Variants {
        model: Quickshell.screens

        Scope{
            id : scope
            required property ShellScreen modelData

            PanelWindow{
                id :barPanel

                property int cornerRadius: 20

                WlrLayershell.namespace: "QS-Bar"
                WlrLayershell.exclusionMode:ExclusionMode.Ignore
                color: "transparent"
                anchors.top:true
                anchors.left:true
                anchors.right:true
                implicitHeight: bar.height + barPanel.cornerRadius
                screen:modelData
                exclusiveZone:bar.implicitHeight
                mask: Region {
                    x: bar.x
                    y: bar.y
                    width: bar.width
                    height: bar.height
                }

                Bar{
                    id:bar
                    screen:scope.modelData
                    // wrapper:barWrapper

                }

                Components.RoundCorner {
                    id: leftCorner
                    anchors {
                        top: bar.bottom
                        // bottom: parent.bottom
                        left: parent.left
                    }

                    size: barPanel.cornerRadius
                    color: "#1e1e2e"
                    corner: Components.RoundCorner.CornerEnum.TopLeft
                }
                Components.RoundCorner {
                    id: rightCorner
                    anchors {
                        right: parent.right
                        top:  bar.bottom
                    }
                    size: barPanel.cornerRadius
                    color: "#1e1e2e"
                    corner: Components.RoundCorner.CornerEnum.TopRight
                }
            }
        }
    }
    Panels.PanelWrapper{
        id: panelWrapper
    }

    GlobalShortcut{
        name:"launcher"
        description:qsTr("Start a launcher to execute applications")

        onPressed: {
            panelWrapper.open(Quickshell.shellPath("modules/panels/LaunchPanel.qml"),{"panelWrapper":panelWrapper});
        }
    }
}