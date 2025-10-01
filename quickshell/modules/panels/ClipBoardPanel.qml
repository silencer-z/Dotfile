// pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

Item {
    id: root

    required property var panelWrapper

    property int currentIndex:0

    implicitWidth: 600
    implicitHeight: Math.min(700,ClipModel.itemModel.count*50+20)
    // implicitHeight:800

    function close(){
        /* 实现自己关闭函数 */
        root.currentIndex = 0;
    }

    function init(){
        /* 实现自己的初始化函数 */
        ClipModel.refresh()
    }

    function stripLineNumber(text) {
        return text.replace(/^\s*\d+\s+/, "");
    }

    RowLayout{
        id:title
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.margins:10
        spacing:10
        // Layout.alignment:Qt.AlignVCenter
        Rectangle{
            Layout.fillHeight:true
            width:50
            height:50
            radius:15
            color:"#313244"
            IconText{
                anchors.centerIn:parent
                text:"content_paste"
                font.pixelSize:35
            }
            
        }
        Rectangle{
            height:50
            // width:childrenRect.width
            color:"transparent"
            Layout.fillHeight:true
            StyledText{
                anchors.verticalCenter:parent.verticalCenter
                text:"剪切板"
                font.pixelSize:30
            }
        }
        Item{
            Layout.fillWidth:true
        }
    }

    Rectangle{
        id: background
        anchors.top:title.bottom
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        // anchors.margins:0
        // radius:10
        color:"transparent"

        ListView{
            id:clipListView

            anchors.fill:parent
            anchors.margins:10

            focus:true
            spacing:0

            model: ClipModel.itemModel
            currentIndex:root.currentIndex
            clip:true
            highlightMoveDuration: 50
            highlightResizeDuration: 0

            delegate:Rectangle{
                id:row
                width:clipListView.width
                height:48
                radius:10
                color: ListView.isCurrentItem ? "#313244" : "transparent"

                StyledText {
                    anchors.fill:parent
                    anchors.margins: 8
                    text: root.stripLineNumber(model.text)
                    font.pixelSize:15
                    color: "white"
                }

            }

            Component.onCompleted:{
                clipListView.forceActiveFocus();
            }

            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Escape) {
                    root.panelWrapper.close()
                    event.accepted = true
                } else if (event.key === Qt.Key_Up) {
                    if (currentIndex > 0) currentIndex--
                    event.accepted = true
                } else if (event.key === Qt.Key_Down) {
                    if (currentIndex < count - 1) currentIndex++
                    event.accepted = true
                } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    if (currentIndex >= 0 && currentIndex < model.count) {
                        const row = model.get(currentIndex)
                        ClipModel.copy(row.text)
                        root.panelWrapper.close()
                    }
                    event.accepted = true
                } else if (event.key === Qt.Key_Delete) {
                    if (currentIndex >= 0 && currentIndex < model.count) {
                        const txt = model.get(currentIndex).text
                        ClipModel.deleteEntry(txt)
                    }
                    event.accepted = true
                }
            }
        }
    }
}