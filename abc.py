from libqtile import qtile

if qtile.core.name == "x11":
    term = "kitty"
elif qtile.core.name == "wayland":
    term = "kitty"

