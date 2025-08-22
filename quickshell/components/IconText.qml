import QtQuick
import QtQuick.Layouts

Text {
    property real fill: 0
    property real truncatedFill: Math.round(fill * 100) / 100
    property real iconSize: 16
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    font {
        hintingPreference: Font.PreferFullHinting
        family: "Material Symbols Rounded"
        pixelSize: iconSize
        weight: Font.Normal + (Font.DemiBold - Font.Normal) * fill
        variableAxes: { 
            "FILL": truncatedFill,
            "opsz": iconSize,
        }
    }
    color: "#FFFFFF"
}