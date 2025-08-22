#!/usr/bin/env bash

# 设置目录路径
rofiStyleDir="${HOME}/.config/rofi/themes"
rofiAssetDir="${HOME}/.config/rofi/assets" # 确保这个目录存在且包含 PNG 图标
rofiSelectTheme="${rofiStyleDir}/selector.rasi" # 用于显示主题列表的 Rofi 主题
rofiDefaultConfig="${HOME}/.config/rofi/config.rasi" # Rofi 的默认配置文件软链接


# 情况1: 脚本被 Rofi 调用，并且传递了参数（用户选择了一个主题）
if [[ -n "$*" ]]; then
    RofiSel="$*"
    selected_theme_file="${rofiStyleDir}/${RofiSel}.rasi"

    if [[ -f "$selected_theme_file" ]]; then
        # 如果 rofiDefaultConfig 是一个已存在的软链接，先删除它
        if [[ -L "$rofiDefaultConfig" ]]; then
            rm -f "$rofiDefaultConfig"
        # 如果它是一个普通文件（非软链接），也删除它（或者报错）
        elif [[ -f "$rofiDefaultConfig" ]]; then
            echo "警告: '${rofiDefaultConfig}' 是一个普通文件，将被覆盖。" >&2
            rm -f "$rofiDefaultConfig"
        fi

        ln -sf "$selected_theme_file" "$rofiDefaultConfig"
        icon_path="${rofiAssetDir}/${RofiSel}.png"
        if [[ ! -f "$icon_path" ]]; then # 检查图标是否存在
            icon_path="dialog-information" # 使用一个通用图标作为后备
        fi
        notify-send -a "Rofi Style" -t 2000 -i "${icon_path}" "样式 '${RofiSel}' 已应用为默认"
    else
        notify-send -a "Rofi Style" -u critical "找不到样式文件：${selected_theme_file}"
    fi
    exit 0 # 应用主题后务必退出
fi

# 情况2 或 3: 脚本没有接收到参数
# 情况2: 用户直接在终端运行此脚本，此时应该启动 Rofi 选择器
# 我们通过检查标准输入是否为终端 (tty) 来判断是否为直接运行
if [[ -t 0 ]]; then
    # 使用当前脚本作为 modi 来提供列表，并指定选择器的主题
    rofi -modi selector:"$0" -show selector -theme "${rofiSelectTheme}"
    exit 0 # Rofi 结束后退出
else
    # 情况3: Rofi 通过 -modi 调用此脚本来获取主题列表（此时无参数，且非直接 tty 运行）
    # 或者脚本以其他非交互方式执行（例如，用户通过管道 `cat somefile | ./rofiselect.sh`）
    find "${rofiStyleDir}" -type f -name "*.rasi" -exec grep -q "Attr.*launcher.*" {} \; -print |
    while read -r file; do
        name=$(basename "${file}" .rasi)
        icon="${rofiAssetDir}/${name}.png"
        # 如果图标文件不存在，可以考虑不显示图标或使用默认图标
        if [[ ! -f "$icon" ]]; then
            echo -e "${name}" # 只显示名字
        else
            echo -e "${name}\x00icon\x1f${icon}"
        fi
    done
    exit 0 # 提供列表后务必退出
fi