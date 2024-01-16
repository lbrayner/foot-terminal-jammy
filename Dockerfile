FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

# Installing meson and ninja first for optimal intermediary cached images
RUN apt-get update
RUN apt-get -y install python3-pip
RUN pip3 install --upgrade pip && pip3 install meson ninja

RUN apt-get -y install \
        git \
        build-essential \
        pkg-config \
        bison \
        libxcb-xkb-dev \
        libxml2-dev \
        wayland-protocols \
        libwayland-dev \
        libpixman-1-dev \
        libfontconfig1-dev

RUN pip3 install --upgrade pip && pip3 install meson ninja

RUN git clone https://github.com/xkbcommon/libxkbcommon /libxkbcommon

WORKDIR /libxkbcommon

RUN meson setup build -Denable-docs=false && ninja -C build && meson install -C build

RUN git clone https://codeberg.org/dnkl/foot /foot && mkdir /foot/build

WORKDIR /foot

RUN ./pgo/pgo.sh auto . build
