// ClipModel.qml
pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    /** 剪贴板历史条目 */
    // property var entries: []

    ListModel {
        id: model
    }

    readonly property alias itemModel: model

    /** 重新加载历史记录 */
    function refresh() {
        readProc.buffer = []
        readProc.running = true
    }

    function copy(entry) {
        Quickshell.execDetached([
            "bash", "-c",
            'printf "%s" "$1" | cliphist decode | wl-copy',
            "quickshell",
            entry
        ]);
    }


    function deleteEntry(entry) {
        deleteProc.entry = entry
        deleteProc.running = true
    }

    Process {
        id: readProc
        property var buffer: []
        command: ["cliphist", "list"]

        stdout: SplitParser {
            onRead: line => readProc.buffer.push(line)
        }

        onExited: (code, status) => {
            if (code === 0) {
                model.clear();
                readProc.buffer.forEach(entry => {
                    model.append({ text: entry });
                });
                console.log("[INFO] ClipModel refresh done! count:", model.count)
            } else {
                console.error("[INFO] ClipModel refresh failed:", code, status)
            }
        }
    }

    // 删除某条记录
    Process {
        id: deleteProc
        property string entry: ""
        command: ["bash", "-c",
                  'printf "%s" "$1" | cliphist delete',
                  "quickshell", deleteProc.entry
        ]
        onExited: (code, status) => root.refresh()
    }
}
