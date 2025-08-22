import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

StyledPanel{
    id : root

    property int currentIndex: 0
    required property var panelWrapper

    /* 提供给管理器的关闭函数 */
    function close(){
        root.currentIndex = 0;
        searchField.clear();
        AppModel.filterText = "";
    }
    /* 关闭部件由管理器执行 */
    function executeApp(entry) {
        AppModel.trackApp(entry.name || entry.id);
        entry.execute();
        panelWrapper.close();
    }
    function executeAction(action) {
        action.execute();
        panelWrapper.close();
    }

    function calculateContentHeight() {

        var totalHeight = 70;
        var itemCount = AppModel.appModel.count;
        if (itemCount === 0)
            return 85;

        for (var i = 0; i < itemCount; i++) {
            var item = AppModel.appModel.values[i];
            if (item && item.isHeader) {
                totalHeight += 35;
            } else if (item) {
                var hasActions = item.actions && item.actions.length > 0;
                totalHeight += hasActions ? (48 + 32 + 8) : 48;
            }
            totalHeight += 2;
        }
        totalHeight += 20;

        return Math.max(150, Math.min(totalHeight, 600));
    }


    contentWidth:600
    contentHeight:root.calculateContentHeight()


    AppListView{
        id:listView
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: searchBar.top
            margins: 16
            topMargin: 10
        }
        currentIndex: root.currentIndex
        onExecuteApp: entry => root.executeApp(entry)
        onExecuteAction: action => root.executeAction(action)
        onIndexChanged: index => root.currentIndex = index
    }

    Rectangle {
        id : searchBar
        height:50
        radius:15
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins:20
        color:"white"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            IconText{
                text:"search"
                iconSize:24
                color:"#000000"
            }

            StyledTextInput {
                id: searchField
                focus: true
                Layout.fillWidth: true
                onTextChanged: {
                    AppModel.filterText = text;
                }
                function clear() {
                    text = "";
                }
            }
        }
    }
    Component.onCompleted: {
        searchField.forceActiveFocus()
    }
    Keys.onPressed: event => {
        if (event.key === Qt.Key_Escape) {
            panelWrapper.close()
            event.accepted = true;
        } else if (event.key === Qt.Key_Up) {

            if (root.currentIndex > 0) {
                root.currentIndex--;
                listView.currentIndex = root.currentIndex;
                listView.positionViewAtIndex(root.currentIndex, ListView.Contain);
            }
            
            event.accepted = true;
        } else if (event.key === Qt.Key_Down) {

            if (root.currentIndex < AppModel.appModel.count - 1) {
                root.currentIndex++;
                listView.currentIndex = root.currentIndex;
                listView.positionViewAtIndex(root.currentIndex, ListView.Contain);
            }
            
            event.accepted = true;

        } else if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
            if (root.currentIndex >= 0 && root.currentIndex < AppModel.appModel.count) {
                var entry = AppModel.appModel.values[root.currentIndex];
                root.executeApp(entry.entry);
            }
            event.accepted = true;
        }
    }
}