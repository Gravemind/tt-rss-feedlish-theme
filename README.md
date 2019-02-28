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

Most of the time tt-rss updates won't affect Feedlish. When it does, Feedlish
should be fixed within a week or two.

As long as tt-rss updates (default theme changes) don't deviate from
Feedlish's overwriting rules, **Feedlish does not need to be rebuild**.

## Customize

**On [rebuild](#Rebuild)**, Feedlish imports `tt-rss-feedlish-theme/local.less`,
so you can put your own customization there, for example:

```less
// tt-rss-feedlish-theme/local.less

@feedlish-hide-author-in-headlines: true; // hide author
@feedlish-cdm-fixed-height: 250px;        // combined-mode article fixed height

// etc...
```

NOTES: **Changing variables only affects Feedlish, not default.css/less**, you
must add new rules to overwrite them.

## Rebuild

- install `lessc` (`$ pacman -S nodejs-less`, `$ dnf install nodejs-less nodejs-source-map`, ...)
- run `$ make` here

## Screenshots

![feedlish](https://raw.githubusercontent.com/Gravemind/tt-rss-feedlish-theme/master/screenshots/feedlish.png?1547295073)

![feedlish-night](https://raw.githubusercontent.com/Gravemind/tt-rss-feedlish-theme/master/screenshots/feedlish-night.png?1547295073)
