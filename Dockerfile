FROM node:20.5.0-bookworm-slim

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y g++ \
        curl \
        cmake \
        git \
        libpcre3-dev \
        default-libmysqlclient-dev \
        libopus-dev \
        libsodium-dev

WORKDIR /app

COPY . .

RUN curl -o dpp.deb https://dl.dpp.dev/ && dpkg -i dpp.deb

RUN git clone https://github.com/fmtlib/fmt && cd fmt && mkdir build && cd build && cmake .. && make -j && make install

RUN git clone https://github.com/gabime/spdlog && cd spdlog && mkdir build && cd build && cmake .. && make -j && make install

RUN mkdir -p /app/build && cd /app/build && cmake .. && make -j

CMD ["/app/build/bot"]
