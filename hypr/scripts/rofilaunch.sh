# Default rofi arguments
rofi_args=(-show-icons)

# Determine mode
case "${1}" in
    d | --drun)
        r_mode="drun"
        rofi_args+=("--run-command" "sh -c 'uwsm app -- {cmd} || {cmd}'")
        ;;
    w | --window)
        r_mode="window"
        ;;
    f | --filebrowser)
        r_mode="filebrowser"
        ;;
    r | --run)
        r_mode="run"
        rofi_args+=("--run-command" "sh -c 'uwsm app -- {cmd} || {cmd}'")
        ;;
    h | --help)
        echo "Usage: $(basename "$0") [d|w|f|r]"
        echo "  d : drun mode"
        echo "  w : window mode"
        echo "  f : filebrowser mode"
        echo "  r : run mode"
        exit 0
        ;;
    *)
        r_mode="drun"
        ;;
esac

# Launch rofi using default config
rofi -show "${r_mode}" "${rofi_args[@]}" &
disown