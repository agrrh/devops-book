FROM alpine:3.18 as builder

RUN apk add cargo
RUN cargo install mdbook --bins

ENV PATH=${PATH}::/root/.cargo/bin

WORKDIR /work

COPY ./ ./

RUN mdbook build

# ---

FROM nginx:1.25

COPY --from=builder /work/book /usr/share/nginx/html
