import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

PanelWindow {
    id: root
    property string contentComponent: ""      // 弹出组件路径

    WlrLayershell.exclusionMode:ExclusionMode.Ignore
    WlrLayershell.keyboardFocus: visible? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

    mask:Region{
        x:contentLoader.x
        y:contentLoader.y
        width:contentLoader.width
        height:contentLoader.height
    }

    anchors.bottom:true
    anchors.left:true
    anchors.right:true
    anchors.top:true

    color:"transparent"
    visible: hasCurrent

    // 是否有弹窗
    readonly property bool hasCurrent: contentComponent !== ""

    function open(sourceComponent, properties = {}) {
        console.log("open called with:", sourceComponent)
        if (contentComponent == sourceComponent) {
            close();
        } else {
            contentComponent = sourceComponent;
            // contentLoader.setSource(sourceComponent,Object.assign({ panelWrapper: root }, properties))
            contentLoader.setSource(sourceComponent,properties)
            grab.active = true
            console.log("触发修改")
        }
    }

    function close() {
        if(contentLoader.item){
            
            contentLoader.item.opened = false
            contentLoader.item.close();
            Qt.callLater(() => Qt.createQmlObject(`
                import QtQuick 2.15; Timer { interval: 350; running: true; repeat: false; onTriggered: root.contentDestroy() }`,
                root, "DelayedClose")
            )
        }
    }

    function contentDestroy(){
        contentComponent = ""
        contentLoader.source= ""; 
    }


    HyprlandFocusGrab{
        id:grab
        windows:[root]
        onCleared:{
            root.close()
        }
    }
    

    Loader {
        id: contentLoader
        active: root.hasCurrent
        asynchronous: true
        anchors.bottom:parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        onLoaded: {
            /* 开启动画 */
            contentLoader.item.opened = true
        }
    }
}