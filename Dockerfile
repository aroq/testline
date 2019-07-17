FROM loadimpact/k6 as k6

FROM golang:1-alpine
COPY --from=k6 /usr/bin/k6 /usr/bin/k6

# Install alpine package manifest
COPY packages.txt /etc/apk/
RUN apk add --update $(grep -v '^#' /etc/apk/packages.txt)

# Install variant
ENV VARIANT_VERSION 0.32.0
RUN curl --fail -sSL -o variant.tar.gz https://github.com/mumoshu/variant/releases/download/v${VARIANT_VERSION}/variant_${VARIANT_VERSION}_linux_386.tar.gz \
    && mkdir -p variant && \
    tar -zxf variant.tar.gz -C variant \
    && cp variant/variant /usr/local/bin/ \
    && rm -f variant.tar.gz \
    && rm -fR variant \
    && chmod +x /usr/local/bin/variant
