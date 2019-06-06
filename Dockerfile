FROM balenalib/armv7hf-alpine:latest-build as builder

WORKDIR /

RUN apk add --no-cache git  build-base linux-headers && \
    git clone https://github.com/wangyu-/udp2raw-tunnel.git  && \
    cd udp2raw-tunnel && \
    make dynamic

FROM balenalib/armv7hf-alpine:latest-run
RUN apk add --no-cache libstdc++ iptables
COPY --from=builder /udp2raw-tunnel/udp2raw_dynamic /usr/local/bin/