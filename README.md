## Tiny Tiny RSS Feedlish Theme

.. Work In Progress, In Development ...

"Close enough" clone of https://github.com/levito/tt-rss-feedly-theme working on
[Tiny Tiny RSS](https://tt-rss.org/) 18.12+ ().

It wont be an exact clone: the current goal is to start from the default theme,
and modify it as little as possible to get close enough.

If TinyTinyRSS's css files changes, you might need to recompile the .css
.css.map: you'll need to install `lessc` (with nodejs `source-map`), then run
`make` here.

### Installation

```
cd /path/to/tt-rss/themes.local/

git clone https://github.com/Gravemind/tt-rss-feedlish-theme

ln -s tt-rss-feedlish-theme/feedlish.css
ln -s tt-rss-feedlish-theme/feedlish.css.map
ln -s tt-rss-feedlish-theme/feedlish-night.css
ln -s tt-rss-feedlish-theme/feedlish-night.css.map
```
