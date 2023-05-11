ARG IMAGE="ubuntu:20.04"

FROM ${IMAGE} AS common

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    apt-utils apt-transport-https ca-certificates curl git \
    && update-ca-certificates

FROM common AS build

ARG HTTP_PROXY

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y --no-install-recommends \
    jq xz-utils

# oss-cad-suite
RUN export HTTP_PROXY=${HTTP_PROXY} && export HTTPS_PROXY=${HTTP_PROXY} \
    && curl -s https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest | \
    jq -r ".assets[] | select(.name | test(\"linux-x64\")) | .browser_download_url" | \
    xargs curl -Lo oss-cad-suite.tgz \
    && mkdir /tmp/oss-cad-suite \
    && tar -xzvf oss-cad-suite.tgz -C /tmp/oss-cad-suite --strip-components 1

# riscv-gnu-toolchain
RUN curl -Lo riscv.tar.gz https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2023.04.29/riscv32-elf-ubuntu-20.04-nightly-2023.04.29-nightly.tar.gz \
    && mkdir /tmp/riscv32 \
    && tar -xzvf riscv.tar.gz -C /tmp/riscv32 --strip-components 1

# verible
RUN export HTTP_PROXY=${HTTP_PROXY} && export HTTPS_PROXY=${HTTP_PROXY} \
    && curl -s https://api.github.com/repos/chipsalliance/verible/releases/latest | \
    jq -r ".assets[] | select(.name | test(\"Ubuntu-20.04\")) | .browser_download_url" | \
    xargs curl -Lo verible.tar.gz \
    && mkdir /tmp/verible \
    && tar -xzvf verible.tar.gz -C /tmp/verible --strip-components 1

FROM common AS cgra

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y gnupg \
    && curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg \
    && install -o root -g root -m 644 conda.gpg /usr/share/keyrings/conda-archive-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" > \
        /etc/apt/sources.list.d/conda.list

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    build-essential cmake perl autoconf clang flex bison ccache \
    gperf libgoogle-perftools-dev numactl libfl2 libfl-dev perl-doc \
    zlibc zlib1g zlib1g-dev libreadline-dev gawk tcl-dev libffi-dev \
    mercurial graphviz xdot pkg-config libftdi-dev libgmp-dev \
    libboost-program-options-dev python3 python-is-python3 \
    lcov libelf1 libelf-dev libftdi1-2 libftdi1-dev libncurses5 \
    libssl-dev libudev-dev libusb-1.0-0 lsb-release texinfo libexpat-dev \
    curl git locales xz-utils conda \
    && ln -sf /bin/bash /bin/sh \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

COPY --from=build /tmp/oss-cad-suite /usr/local/.
COPY --from=build /tmp/riscv32 /opt/riscv32/.
COPY --from=build /tmp/verible /usr/local/.

FROM cgra AS cgra-dev

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get -y install sudo && groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /usr/bin/bash \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

USER $USERNAME

ENTRYPOINT [ "/usr/bin/bash" ]
