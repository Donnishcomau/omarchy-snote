> **Moved:** this plugin now lives in the snote repository itself, at https://github.com/donnishcomau/snote, and is listed on the Omarchy plugin marketplace as `io.github.donnishcomau.snote-simplenote`. This repository is archived.

# snote bar widget

Omarchy Quattro bar widget for [snote](https://github.com/donnishcomau/snote), a
terminal Simplenote client. It adds a note-glyph button to the bar; left-click
launches (or focuses) `snote` in a terminal via `omarchy-launch-or-focus-tui`.

If `snote` is not on `PATH`, the button's tooltip and a desktop notification
point at the snote install instructions instead of launching anything.

## Requires

`snote` on `PATH`. See the [snote README](https://github.com/donnishcomau/snote#install-on-omarchy)
for how to install it.

## Install

```bash
omarchy plugin add https://github.com/donnishcomau/omarchy-snote --enable
```

## Remove

```bash
omarchy plugin remove io.github.donnishcomau.snote
```

## License

MIT, see [LICENSE](LICENSE).
