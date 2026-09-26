import QtQuick
import Quickshell
import Quickshell.Io
import qs.Ui

// Bar widget for the snote plugin: a note glyph that launches (or focuses)
// snote, a Simplenote client, in a terminal. The visible bar item is just an
// icon button — there is no panel, so a left click either runs the launcher
// or, when `snote` is missing from PATH, tells the user how to install it.
BarWidget {
  id: root
  moduleName: "io.github.donnishcomau.snote"

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  // "unknown" until the PATH probe below finishes, then "available" or
  // "missing". Starting unknown keeps the tooltip from claiming snote is
  // missing before the check has actually run.
  property string snoteStatus: "unknown"
  readonly property bool snoteAvailable: snoteStatus === "available"

  readonly property string installHint: "Install snote first: see github.com/donnishcomau/snote"
  readonly property string defaultTooltip: "snote — Simplenote in your terminal"
  readonly property string tooltipMessage: snoteStatus === "missing" ? root.installHint : root.defaultTooltip

  // Same notify pattern as other Omarchy plugins: OMARCHY_PATH/bin holds
  // the notification sender, and Quickshell.execDetached fires it without
  // going through a shell.
  function notify(title, body) {
    var omarchyPath = Quickshell.env("OMARCHY_PATH") || ""
    if (omarchyPath === "") {
      console.warn("snote notify: OMARCHY_PATH is empty, skipping notification")
      return
    }
    var bin = omarchyPath + "/bin/omarchy-notification-send"
    Quickshell.execDetached([bin, title, body])
  }

  function launchOrHint() {
    if (root.snoteAvailable) {
      if (root.bar) root.bar.run("omarchy-launch-or-focus-tui snote")
      return
    }
    root.notify("snote", root.installHint)
  }

  Process {
    id: checkSnoteProc
    command: ["which", "snote"]
    onExited: function(exitCode) {
      root.snoteStatus = exitCode === 0 ? "available" : "missing"
    }
  }

  Component.onCompleted: checkSnoteProc.running = true

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: ""
    tooltipText: root.tooltipMessage

    onPressed: function(b) {
      if (b === Qt.RightButton) return
      root.launchOrHint()
    }
  }
}
