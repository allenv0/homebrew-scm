cask "scm" do
  version "0.2.5"
  sha256 "4433ad9c556bcff4b71ee435fde4a634d88c7a78cb305d51b4a6a89772feda86"

  url "https://github.com/allenv0/homebrew-scm/releases/download/v#{version}/SCM-#{version}-arm64.dmg"
  name "SCM"
  desc "Local-first photo and video search"
  homepage "https://scm.allenlee.site/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey
  depends_on arch: :arm64

  app "SCM.app"

  # Phase-1 quarantine auto-clear: the build is signed with a local
  # development certificate (not a Developer ID), so Gatekeeper would
  # otherwise block first launch with an "unverified developer" dialog.
  # This runs on every install, reinstall and upgrade, replacing any
  # manual `xattr -d com.apple.quarantine` step. It is intentionally
  # scoped to this third-party tap and will be removed once releases
  # are Developer ID signed + notarized (then Gatekeeper passes with
  # quarantine intact and no bypass is needed).
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SCM.app"],
                   must_succeed: false
  end

  uninstall quit: "com.allenv0.scm"

  zap trash: [
    "~/Library/Application Support/scm",
    "~/Library/Caches/com.allenv0.scm",
    "~/Library/Preferences/com.allenv0.scm.plist",
    "~/Library/Saved Application State/com.allenv0.scm.savedState",
  ]
end
