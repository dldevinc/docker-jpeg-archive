FROM bugoman/mozjpeg as builder
ARG VERSION=2.2.0

RUN apk --update add \
    build-base \
	tar

WORKDIR /src

# JPEG Archive
ADD https://github.com/danielgtaylor/jpeg-archive/archive/v${VERSION}.tar.gz ./
RUN tar -xzf v${VERSION}.tar.gz
RUN cd /src/jpeg-archive-${VERSION} && \
	make && \
	make install


FROM bugoman/pexec

COPY --from=builder /usr/local/bin /usr/local/bin
COPY ./docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
