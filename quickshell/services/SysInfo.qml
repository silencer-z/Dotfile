pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

/* 创建服务用于获取系统信息 */
Singleton{
    id:root
    // /* 内存 */
    // readonly property int updateInterval:3000

    // property double memoryTotal: 1
	// property double memoryFree: 1
	// property double memoryUsed: memoryTotal - memoryFree
    // property double memoryUsedPercentage: memoryUsed / memoryTotal
    // /* 交换空间 */
    // property double swapTotal: 1
	// property double swapFree: 1
	// property double swapUsed: swapTotal - swapFree
    // property double swapUsedPercentage: swapTotal > 0 ? (swapUsed / swapTotal) : 0
    // /* CPU */
    // property double cpuUsage: 0
    // property var previousCpuStats

    /* 电量 */
    property bool batteryAvailable: UPower.displayDevice.isLaptopBattery
    property var  chargeState: UPower.displayDevice.state
    property real batteryPercentage: UPower.displayDevice.percentage

    /* 定时获取资源利用情况 */
	// Timer {
	// 	interval: 1
    //     running: true 
    //     repeat: true
	// 	onTriggered: {
    //         // Reload files
    //         fileMeminfo.reload()
    //         fileStat.reload()

    //         // Parse memory and swap usage
    //         const textMeminfo = fileMeminfo.text()
    //         memoryTotal = Number(textMeminfo.match(/MemTotal: *(\d+)/)?.[1] ?? 1)
    //         memoryFree = Number(textMeminfo.match(/MemAvailable: *(\d+)/)?.[1] ?? 0)
    //         swapTotal = Number(textMeminfo.match(/SwapTotal: *(\d+)/)?.[1] ?? 1)
    //         swapFree = Number(textMeminfo.match(/SwapFree: *(\d+)/)?.[1] ?? 0)

    //         // Parse CPU usage
    //         const textStat = fileStat.text()
    //         const cpuLine = textStat.match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/)
    //         if (cpuLine) {
    //             const stats = cpuLine.slice(1).map(Number)
    //             const total = stats.reduce((a, b) => a + b, 0)
    //             const idle = stats[3]

    //             if (root.previousCpuStats) {
    //                 const totalDiff = total - root.previousCpuStats.total
    //                 const idleDiff = idle - root.previousCpuStats.idle
    //                 cpuUsage = totalDiff > 0 ? (1 - idleDiff / totalDiff) : 0
    //             }

    //             root.previousCpuStats = { total, idle }
    //         }
    //         interval =  root.updateInterval
    //     }
	// }

	// FileView { id: fileMeminfo; path: "/proc/meminfo" }
    // FileView { id: fileStat; path: "/proc/stat" }
}