import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy.workspaces"

  readonly property string screenName: root.QsWindow && root.QsWindow.window && root.QsWindow.window.screen ? String(root.QsWindow.window.screen.name || "") : ""

  function workspaceById(id) {
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id === id) return values[i]
    }

    return null
  }

  readonly property var workspaceIds: {
    var ids = []
    var values = Hyprland.workspaces.values
    var targetScreen = root.screenName

    for (var i = 0; i < values.length; i++) {
      var ws = values[i]
      if (!ws || ws.id < 1) continue
      if (targetScreen && ws.monitor && ws.monitor.name && ws.monitor.name !== targetScreen) {
        continue
      }
      if (ids.indexOf(ws.id) === -1) {
        ids.push(ws.id)
      }
    }

    // Fallback: If Hyprland has not reported workspaces for this screen yet (e.g. startup)
    // and no persistent workspaces were found, seed 1..5 for the primary monitor
    if (ids.length === 0 && (!targetScreen || targetScreen === "HDMI-A-1")) {
      ids = [1, 2, 3, 4, 5]
    }

    ids.sort(function(left, right) { return left - right })
    return ids
  }

  function focusWorkspace(id) {
    if (!root.bar) return
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
  }

  function workspaceLabel(id) {
    if (root.setting("relativeNumbers", false)) {
      var rel = id % 10
      return rel === 0 ? "0" : String(rel)
    }
    return id === 10 ? "0" : String(id)
  }

  readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)

  implicitWidth: grid.implicitWidth + trailingGap
  implicitHeight: grid.implicitHeight

  GridLayout {
    id: grid
    anchors.fill: parent
    anchors.rightMargin: root.trailingGap
    columns: root.vertical ? 1 : Math.max(1, root.workspaceIds.length)
    columnSpacing: root.vertical ? 0 : Style.space(1)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.workspaceIds

      WidgetButton {
        required property int modelData

        readonly property var workspace: root.workspaceById(modelData)
        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
        readonly property bool activeOnMonitor: workspace !== null && workspace.active
        readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData
        readonly property string btnText: focused ? "\uDB85\uDCFB" : root.workspaceLabel(modelData)
        readonly property bool isTwoDigits: !focused && btnText.length > 1 && btnText !== "\uDB85\uDCFB"

        bar: root.bar
        text: btnText
        tooltipText: "Workspace " + modelData
        opacity: occupied || focused || activeOnMonitor ? 1 : 0.5
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: root.vertical ? root.barSize : (isTwoDigits ? Style.space(24) : Style.space(20))
        fixedHeight: root.barSize
        onPressed: function() { root.focusWorkspace(modelData) }
      }
    }
  }
}
