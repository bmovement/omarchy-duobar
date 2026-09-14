import QtQuick

Canvas {
    id: glyph
    property real battery: 0
    property bool batteryPresent: true
    property bool charging: false
    property bool lowBattery: false
    property bool wifiConnected: false
    property bool wifiEnabled: true
    property real signalStrength: 0
    property bool wired: false
    property bool bluetoothEnabled: false
    property color foreground: "white"
    property color urgent: "#ff6666"
    implicitWidth: 24
    implicitHeight: 24
    onBatteryChanged: requestPaint()
    onBatteryPresentChanged: requestPaint()
    onChargingChanged: requestPaint()
    onLowBatteryChanged: requestPaint()
    onWifiConnectedChanged: requestPaint()
    onWifiEnabledChanged: requestPaint()
    onSignalStrengthChanged: requestPaint()
    onWiredChanged: requestPaint()
    onBluetoothEnabledChanged: requestPaint()
    onForegroundChanged: requestPaint()
    onUrgentChanged: requestPaint()
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()
    onPaint: {
        var c = getContext("2d")
        c.reset()
        c.scale(width / 32, height / 32)
        c.lineCap = "round"
        c.lineJoin = "round"
        function arc(x, y, r, start, end, width, alpha, color) {
            c.beginPath(); c.strokeStyle = color; c.globalAlpha = alpha; c.lineWidth = width
            c.arc(x, y, r, start * Math.PI / 180, end * Math.PI / 180); c.stroke()
        }
        var fg = glyph.foreground.toString()
        var batteryColor = glyph.lowBattery ? glyph.urgent.toString() : fg
        arc(16, 14.7, 12.3, 145, 395, 2.7, 0.18, fg)
        if (batteryPresent && battery > 0)
            arc(16, 14.7, 12.3, 145, 145 + 250 * Math.max(0, Math.min(1, battery)), 2.7, 1, batteryColor)
        if (wired) {
            c.globalAlpha = 1; c.strokeStyle = fg; c.lineWidth = 1.6
            c.strokeRect(12, 11, 8, 6)
            c.beginPath(); c.moveTo(16, 17); c.lineTo(16, 20); c.moveTo(12, 20); c.lineTo(20, 20); c.stroke()
        } else {
            var strength = Math.max(0, Math.min(1, signalStrength))
            arc(16, 19, 8, 225, 315, 2.0, wifiConnected && strength > 0.65 ? 1 : 0.20, fg)
            arc(16, 19, 4.8, 225, 315, 2.0, wifiConnected && strength > 0.30 ? 1 : 0.20, fg)
            c.globalAlpha = wifiConnected ? 1 : 0.20; c.fillStyle = fg
            c.beginPath(); c.arc(16, 18.5, 1.3, 0, Math.PI * 2); c.fill()
            if (!wifiEnabled) {
                c.globalAlpha = 0.65; c.strokeStyle = fg; c.lineWidth = 1.4
                c.beginPath(); c.moveTo(11, 11); c.lineTo(21, 21); c.stroke()
            }
        }
        c.fillStyle = fg; c.globalAlpha = bluetoothEnabled ? 1 : 0.20
        for (var i = 0; i < 4; i++) {
            c.beginPath(); c.arc(9.4 + i * 4.4, 26.8, 1.25, 0, Math.PI * 2); c.fill()
        }
        if (charging) {
            c.globalAlpha = 1; c.fillStyle = fg
            c.beginPath(); c.moveTo(26.5, 16); c.lineTo(22.5, 22); c.lineTo(25.5, 22)
            c.lineTo(24, 27); c.lineTo(29, 20); c.lineTo(26, 20); c.closePath(); c.fill()
        }
    }
}
