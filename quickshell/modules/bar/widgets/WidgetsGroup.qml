import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

BarWidget {
    id:root
    color:"transparent"
    widgetColor:"#313244"
    widgetRadius:8


    required property var monitor

    RowLayout{
        id:rawlayout
        spacing:5

        Item{width:3}

        IconText{   
            id: volumeIcon
            font.pixelSize: 22

            text: {
                if (!Audio.sink || !Audio.sink.audio) {
                    return "volume_off"; // 作为备用图标
                }

                if (Audio.sink.audio.mute) {
                    return "volume_off";
                } else if (Audio.sink.audio.volume > 0.66) {
                    return "volume_up";
                } else if (Audio.sink.audio.volume > 0.33) {
                    return "volume_down";up
                } else if (Audio.sink.audio.volume > 0) {
                    return "volume_mute";
                } else {
                    return "volume_off";
                }
            }

            MouseArea {
                anchors.fill: parent

                onWheel: (wheel) => {
                    if (!Audio.sink || !Audio.sink.audio) {
                        console.log("Audio sink is not yet available.");
                        return;
                    }

                    const volumeStep = 0.05;
                    let currentVolume = Audio.sink.audio.volume;
                    if (wheel.angleDelta.y > 0) {

                        Audio.sink.audio.volume = Math.min(currentVolume + volumeStep, 1.0);
                    }else if (wheel.angleDelta.y < 0) {

                        Audio.sink.audio.volume = Math.max(currentVolume - volumeStep, 0.0);
                    }
                }
            }
        }

        IconText{
            id:brightnessIcon

            text:monitor.iconName
            font.pixelSize:22

            MouseArea {
                anchors.fill: parent
                onWheel: (wheel) => {
                    if (wheel.angleDelta.y > 0) {
                        Brightness.increaseBrightness()
                    } else if (wheel.angleDelta.y < 0) {
                        Brightness.decreaseBrightness()
                    }
                }
            }
        }

        IconText{
            id:netIcon
            text:Network.materialSymbol
            font.pixelSize:22
        }
        IconText{
            id:blueToothIcon
            text:Bluetooth.getIcon()
            font.pixelSize:22
            visible:Bluetooth.available
        }

        Item{width:3}
    }
}