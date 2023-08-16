FROM alpine:3.18 as builder

RUN apk add --no-cache \
  cargo=~1.71

RUN addgroup -g 1000 writer && adduser --uid 1000 --ingroup writer --disabled-password writer
USER writer

RUN cargo install mdbook --bins
ENV PATH=${PATH}::/home/writer/.cargo/bin

WORKDIR /work
COPY ./ ./

CMD mdbook serve --hostname 0.0.0.0 --port 8080
