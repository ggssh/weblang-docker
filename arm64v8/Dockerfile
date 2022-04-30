FROM arm64v8/ubuntu

LABEL version="1.0"
LABEL author="ggssh"

WORKDIR /workspace

# use tsinghua mirror
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
RUN sed -i 's#http://ports.ubuntu.com/ubuntu-ports/#http://mirrors.aliyun.com/ubuntu-ports/#' /etc/apt/sources.list

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

RUN mkdir -p /workspace/weblang && cd /workspace/weblang &&\
    git clone https://gitee.com/ggssh/weblang-compiler.git &&\
    cd weblang-compiler && cmake -B $(pwd)/build -DCMAKE_BUILD_TYPE=Release -G Ninja &&\
    cmake --build $(pwd)/build && cmake --build $(pwd)/build --target install