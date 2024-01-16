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
        libfontconfig1-dev \
        libxkbcommon-dev

RUN git clone https://github.com/lbrayner/foot /foot && mkdir /foot/build

WORKDIR /foot

# https://codeberg.org/dnkl/foot/pulls/1099
RUN git checkout -b add-extended-underlines origin/add-extended-underlines

RUN ./pgo/pgo.sh auto . build -Dext-underline=true
