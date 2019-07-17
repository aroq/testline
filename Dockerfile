FROM loadimpact/k6 as k6

FROM golang:1-alpine as builder
RUN apk add --update \
    git
RUN pwd && \
  git clone https://github.com/aroq/variant.git && \
  cd variant && \
  git checkout unstable && \
  go build && \
  cp variant /usr/bin/

FROM alpine:3.7
COPY --from=k6 /usr/bin/k6 /usr/bin/k6
COPY --from=builder /usr/bin/variant /usr/bin/variant

# Install alpine package manifest
COPY packages.txt /etc/apk/
RUN apk add --update $(grep -v '^#' /etc/apk/packages.txt)

# Install variant
# ENV VARIANT_VERSION 0.29.0
# RUN curl --fail -sSL -o variant.tar.gz https://github.com/mumoshu/variant/releases/download/v${VARIANT_VERSION}/variant_${VARIANT_VERSION}_linux_386.tar.gz \
    # && mkdir -p variant && \
    # tar -zxf variant.tar.gz -C variant \
    # && cp variant/variant /usr/local/bin/ \
    # && rm -f variant.tar.gz \
    # && rm -fR variant \
    # && chmod +x /usr/local/bin/variant
