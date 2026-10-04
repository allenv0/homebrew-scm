# homebrew-scm — Homebrew tap for SCM

SCM is local-first photo & video search for macOS (vision, scenes, OCR,
dialogue). This tap distributes it as a Homebrew cask with automatic
quarantine handling, so installs and upgrades launch with no Gatekeeper
workaround steps.

## Install

```bash
brew tap allenv0/scm
brew trust allenv0/scm
brew install --cask allenv0/scm/scm
```

Or trust just the cask (least privilege) instead of the whole tap:

```bash
brew tap allenv0/scm
brew trust --cask allenv0/scm/scm
brew install --cask scm
```

Fully-qualified one-liner (trusts only this cask, no separate tap step):

```bash
brew install --cask allenv0/scm/scm
```

Requirements: Apple Silicon Mac, macOS Monterey or later. The download is
~1.3 GB.

## Upgrade

```bash
brew upgrade --cask allenv0/scm/scm
```

The cask's `postflight` step clears the quarantine flag on every install,
reinstall and upgrade, so updated versions launch immediately.

## What the cask does about quarantine

Current releases are signed with a local development certificate, not an
Apple Developer ID, so macOS Gatekeeper would otherwise flag the app on
first launch. The cask runs:

```bash
/usr/bin/xattr -dr com.apple.quarantine /Applications/SCM.app
```

automatically after staging, on every install and upgrade. This is a
deliberate, tap-scoped Gatekeeper bypass for a tap you explicitly trusted —
the same pattern used by other third-party taps for unsigned builds.

Once releases are Developer ID signed and notarized, Gatekeeper passes with
quarantine intact and this step will be removed. Until then, if you prefer
to handle quarantine yourself, install with the quarantine intact and clear
it manually:

```bash
brew install --cask allenv0/scm/scm
xattr -dr com.apple.quarantine /Applications/SCM.app
```

## Uninstall

```bash
brew uninstall --cask scm
brew uninstall --cask scm --zap   # also removes library data, caches, prefs
```

Stop trusting the tap:

```bash
brew untrust allenv0/scm
brew untap allenv0/scm
```

## Cask maintenance

- Releases live on this repo's [Releases](../../releases) page as
  `SCM-<version>-arm64.dmg`. Bumping the cask = new `version` + new `sha256`
  (`shasum -a 256 <dmg>`).
- `brew livecheck --cask scm` tracks the latest GitHub Release.
- `brew audit --cask --online scm` must pass before pushing a bump.
