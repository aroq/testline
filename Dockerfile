FROM loadimpact/k6

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

# TODO: Need to copy the binary from Uniconf docker image.
RUN go get github.com/aroq/variant@unstable
