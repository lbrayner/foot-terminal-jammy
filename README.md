Build `foot`:

```bash
docker build -t foot-terminal-jammy .
```

Install `foot`:

```bash
docker run -it --rm -v /:/destdir foot-terminal-jammy bash -c \
    'cd /foot && DESTDIR=/destdir meson install -C build'
sudo ln -s /usr/local/share/terminfo/f /etc/terminfo
```

Neovim requires that `VTE_VERSION` be set to 6800:

```bash
export VTE_VERSION=6800
```

You can, alternatively, set `TERM` to st-265color and not worry about `VTE_VERSION`,
and everything seems to work just fine.
