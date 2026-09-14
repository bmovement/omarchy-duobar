# DuoBar for Omarchy

Battery, Wi-Fi, and Bluetooth in one native Omarchy taskbar indicator.
Inspired by [Mike Li’s DuoBar](https://github.com/Mikeli7666/DuoBar).

![DuoBar popup header and combined status glyph](preview.png)

## What it shows

- **Outer arc:** battery charge; red when discharging at 20% or below.
- **Center:** Wi-Fi signal; dim when disconnected and crossed out when disabled. An Ethernet connection uses a wired symbol.
- **Four dots:** Bluetooth radio on/off, not a device count.
- **Lightning mark:** battery charging.
- **Click:** a combined popup with network name and signal, Bluetooth connection count, and battery status. Escape or a click outside closes it.

Colors follow your Omarchy theme. Horizontal and vertical bars are supported.
The popup displays status; use Omarchy’s existing settings panels to manage connections or power.

## Requirements

Omarchy with the Quickshell shell and `omarchy plugin` commands. Tested on Omarchy 4.0.3-1.
This is a Quickshell plugin; it does not run in Waybar.

Uses the shell’s Quickshell NetworkManager, BlueZ, and UPower integrations.
No additional daemon, polling scripts, or network requests are introduced by this plugin.

## Install

```bash
omarchy plugin add https://github.com/leewhitfield/omarchy-duobar.git --enable
```

Choose a bar section if prompted; the default is the right section.
Installation adds DuoBar without removing your existing icons.

For a compact bar, optionally disable the three stock widgets after trying DuoBar:

```bash
omarchy plugin disable omarchy.network
omarchy plugin disable omarchy.bluetooth
omarchy plugin disable omarchy.power
```

## Update

```bash
omarchy plugin update lee.duobar
```

## Remove

If you disabled the stock widgets, restore them:

```bash
omarchy plugin enable omarchy.network
omarchy plugin enable omarchy.bluetooth
omarchy plugin enable omarchy.power
```

Then remove DuoBar:

```bash
omarchy plugin remove lee.duobar
```

## Development

The plugin ID is `lee.duobar`; `Widget.qml` is the entry point and `Glyph.qml` draws the indicator.

```bash
omarchy plugin validate .
qmllint -I /usr/share/omarchy/shell Widget.qml Glyph.qml
```

An existing manually installed copy with the same ID must be backed up and removed before installing the Git-managed version. Omarchy refuses duplicate IDs.

## License and attribution

MIT licensed; see [LICENSE](LICENSE).
The glyph geometry and combined indicator concept are adapted from DuoBar, copyright (c) 2026 Mike Li. The original notice is preserved in [LICENSE-DuoBar](LICENSE-DuoBar).
The Linux integration is by Lee Whitfield. This is an independent Omarchy adaptation, not an official release of the original macOS DuoBar.
