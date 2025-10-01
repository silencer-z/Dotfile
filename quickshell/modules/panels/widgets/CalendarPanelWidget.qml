import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell

import qs.components

PanelWidget{
    id:root
    anchors.margins:10

    height:300

    ColumnLayout{
        anchors.fill :parent
        spacing:8
        RowLayout{
            Layout.fillWidth:true
            spacing:8
            Button {
                text: "<"
                onClicked: {
                    let newDate = new Date(grid.year, grid.month - 1, 1)
                    grid.year = newDate.getFullYear()
                    grid.month = newDate.getMonth()
                }
            }

            Text {
                text: grid.title
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 16
                font.bold: true
                color: "white"
            }

            Button {
                text: ">"
                onClicked: {
                    let newDate = new Date(grid.year, grid.month + 1, 1)
                    grid.year = newDate.getFullYear()
                    grid.month = newDate.getMonth()
                }
            }
        }
        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 1
            color: "#45475a"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 0

            Repeater {
                model: 7
                Text {
                    text: {
                        let firstDay = Qt.locale().firstDayOfWeek
                        let dayIndex = (firstDay + index) % 7
                        return Qt.locale().dayName(dayIndex, Locale.ShortFormat)
                    }
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 12
                    font.bold: true
                    color: "#a6adc8"
                }
            }
        }
        MonthGrid {
            id: grid
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0
            month: new Date().getMonth()
            year: new Date().getFullYear()
            locale: Qt.locale()

            delegate: Rectangle {
                width: 36
                height: 36
                radius: 6
                color: model.today ? "#89b4fa" : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: model.day
                    color: model.today ? "#1e1e2e" : "white"
                    opacity: model.month === grid.month ? 1.0 : 0.4
                    font.pixelSize: 12
                    font.bold: model.today
                }

                Behavior on color {
                    ColorAnimation { duration: 120 }
                }
            }
        }

    }
}