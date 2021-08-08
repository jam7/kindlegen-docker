FROM alpine
LABEL maintainer "Kazushi (Jam) Marukawa <jam@pobox.com>"

ENV KINDLEGEN kindlegen_linux_2.6_i386_v2_9.tar.gz
ENV KINDLEGEN_SHA256="9828db5a2c8970d487ada2caa91a3b6403210d5d183a7e3849b1b206ff042296"
ENV KINDLEGEN_MD5="21aef3c8846946203e178c83a37beba1"

RUN apk --update add ca-certificates curl su-exec tar && rm -rf /var/cache/apk/*

WORKDIR /kindlegen

RUN curl -L http://kindlegen.s3.amazonaws.com/${KINDLEGEN} -o ${KINDLEGEN} && \
    echo "${KINDLEGEN_SHA256}  ${KINDLEGEN}" | sha256sum -c - && \
    mkdir -p /opt/kindlegen && \
    tar zxf ${KINDLEGEN} -C /opt/kindlegen && \
    rm ${KINDLEGEN}

COPY entrypoint.sh /kindlegen/entrypoint.sh
COPY kindlegen.sh /kindlegen/kindlegen.sh

WORKDIR /work
ENTRYPOINT ["/kindlegen/entrypoint.sh"]
