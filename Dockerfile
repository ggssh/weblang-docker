FROM ubuntu:20.04

LABEL version="1.0"
LABEL author="ggssh"

WORKDIR /workspace

ENV DEBIAN_FRONTEND=nointeractive

# use tsinghua mirror
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt clean
RUN apt -y update
RUN apt -y upgrade

RUN apt install -y gcc g++ gdb cmake git
RUN apt install -y llvm-11-dev libclang-11-dev clang-11
RUN apt install -y build-essential
RUN apt install -y libedit-dev
RUN apt install -y libboost-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-thread-dev libboost-regex-dev
RUN apt install -y libgtk-3-dev libgtkmm-3.0-dev libgtksourceviewmm-3.0-dev
RUN apt install -y libmysqlcppconn-dev
RUN apt install -y openssl libssl-dev
RUN apt install -y pkg-config
RUN apt install -y ninja-build
RUN apt install -y sqlite3 libsqlite3-dev

RUN apt install -y --reinstall ca-certificates wget && \
    mkdir /usr/local/share/ca-certificates/cacert.org && \
    wget -P /usr/local/share/ca-certificates/cacert.org http://www.cacert.org/certs/root.crt http://www.cacert.org/certs/class3.crt && \
    update-ca-certificates && \
    git config --global http.sslCAinfo /etc/ssl/certs/ca-certificates.crt

RUN mkdir -p /workspace/webc && cd /workspace/webc &&\
    git clone https://github.com/NEUQ-2084team-Compiler/WebC-llvm-compiler.git &&\
    cd WebC-llvm-compiler && cmake -B $(pwd)/build -DCMAKE_BUILD_TYPE=Release -G Ninja &&\
    cmake --build $(pwd)/build && cmake --build $(pwd)/build --target install
