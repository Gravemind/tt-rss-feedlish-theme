# Tiny Tiny RSS Feedlish Theme

Approximate clone of [@levito's tt-rss-feedly-theme][Feedly].

[Feedlish][] started as a rewrite from scratch of [Feedly][] for [Tiny Tiny
RSS](https://tt-rss.org/) 18.12+ compatibility. Since then, Feedly has also been
rewritten for 18.12+, but Feedlish will continue to be maintained as long as the
few diverging details are worth it.

The current philosophy is to have as little code as possible to stay
maintainable/hackable. So, we use the default theme, then override it just enough.

Not all tt-rss configurations (day/night/wide/combined/...) are currently
tested, Issues/PRs are welcome.

[Feedly]: https://github.com/levito/tt-rss-feedly-theme
[Feedlish]: https://github.com/Gravemind/tt-rss-feedlish-theme

## Install

```bash
$ cd /path/to/tt-rss/themes.local/
$ git clone https://github.com/Gravemind/tt-rss-feedlish-theme
$ ln -s tt-rss-feedlish-theme/feedlish.css
$ ln -s tt-rss-feedlish-theme/feedlish-night.css
```

Then you should see "feedlish" and "feedlish-night" in your Tiny Tiny RSS
Preferences.

## Update

```bash
$ cd /path/to/tt-rss/themes.local/tt-rss-feedlish-theme
$ git pull
```

(The built `feedlish*.css` files are pushed.)

Feedlish is not, and doesn't need to be, updated/rebuilt each time tt-rss
changes, and still benefits from tt-rss's default theme updates (because
[default theme is
`@import`](https://github.com/Gravemind/tt-rss-feedlish-theme/blob/master/feedlish.css#L1))

But when a tt-rss update actually conflicts with feedlish's code, a fix+rebuild
should be pushed within a week or two.

## Customize .css (no rebuild needed)

See [`custom.css`](https://github.com/Gravemind/tt-rss-feedlish-theme/blob/master/custom.css) for simple css customization.

## Customize .less (requires rebuild)

See [`custom.less`](https://github.com/Gravemind/tt-rss-feedlish-theme/blob/master/custom.less) for more complex customization. It will require a [Rebuild](#Rebuild)

## Rebuild

(The built `feedlish*.css` files are already pushed.)

- install `lessc` (`$ pacman -S nodejs-less`, `$ dnf install nodejs-less nodejs-source-map`, ...)
- run `$ make` here

## Screenshots

![feedlish](https://raw.githubusercontent.com/Gravemind/tt-rss-feedlish-theme/master/screenshots/feedlish.png?1551438289)

![feedlish-night](https://raw.githubusercontent.com/Gravemind/tt-rss-feedlish-theme/master/screenshots/feedlish-night.png?1551438289)
