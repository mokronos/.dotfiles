import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "mokronos.mouse-battery"

  property string label: ""
  property string details: ""
  property bool connected: true
  // Qt.resolvedUrl() yields a file:// URL, which bash cannot execute as-is.
  readonly property string scriptPath: decodeURIComponent(Qt.resolvedUrl("mouse-battery.sh").toString().replace(/^file:\/\//, ""))

  function refresh() {
    if (!statusProcess.running) statusProcess.running = true
  }

  Component.onCompleted: refresh()

  Process {
    id: statusProcess
    command: ["bash", root.scriptPath]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        var status = Util.parseModuleJson(text)
        root.label = String(status.text || "")
        root.details = String(status.tooltip || "")
        root.connected = status.connected !== false
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: root.refresh()
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  // Text-sized label needs a naturally sized button; BarIconButton would cram
  // it into a single fixed icon slot.
  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.label
    fontSize: Style.font.caption
    horizontalMargin: 6
    tooltipText: root.details
    dimmed: !root.connected
  }
}
