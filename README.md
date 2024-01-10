Build `foot`:

```bash
docker build -t foot-terminal-jammy .
```

Prepare environment for `libxkbcommon` in `/usr/local`:

```bash
sudo mkdir -p /usr/local/share/X11
sudo ln -s /usr/share/X11/xkb /usr/local/share/X11
```

Install `libxkbcommon`:

```bash
docker run -it --rm -v /:/destdir foot-terminal-jammy bash -c \
    'cd /libxkbcommon && DESTDIR=/destdir meson install -C build'
```

Reload the `ld` cache:

```bash
sudo ldconfig -v
```

Install `foot`:

```bash
docker run -it --rm -v /:/destdir foot-terminal-jammy bash -c \
    'cd /foot && DESTDIR=/destdir meson install -C build'
sudo ln -s /usr/local/share/terminfo/f /etc/terminfo
```
