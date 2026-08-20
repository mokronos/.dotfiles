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

  function refresh() {
    if (!statusProcess.running) statusProcess.running = true
  }

  Component.onCompleted: refresh()

  Process {
    id: statusProcess
    command: ["bash", Qt.resolvedUrl("mouse-battery.sh")]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        var status = Util.parseModuleJson(text)
        root.label = String(status.text || "")
        root.details = String(status.tooltip || "")
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: root.refresh()
  }

  visible: label !== ""
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.label
    tooltipText: root.details
    slotSize: Style.bar.statusSlot
  }
}
