import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.components

import "./widgets"

Item{
    id:root

    required property var panelWrapper
    
    property int currentIndex: 0

    implicitWidth: 400
    implicitHeight: 400

    function close(){
        console.log("dashboard close")
    }

    function init(){
        console.log("dashboard init")
    }

    // GridLayout{
    //     id:grid

    //     anchors.fill:parent
    //     anchors.margins:10
    // }
    ColumnLayout{
        anchors.fill:parent
        WeatherPanelWidget{
            // anchors.fillwidth:true
            Layout.fillWidth:true
        }

        CalendarPanelWidget{
            // anchors.fillwidth:true
            Layout.fillWidth:true
        }

    }


}