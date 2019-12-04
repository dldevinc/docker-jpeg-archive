FROM bugoman/mozjpeg:latest as builder
ARG VERSION=2.2.0
ARG GNU_PARALLEL_VERSION=20191122

RUN apk --update add \
    autoconf \
    automake \
	build-base \
	tar

# GNU Parallel (https://www.gnu.org/software/parallel/)
WORKDIR /src
ADD https://ftp.gnu.org/gnu/parallel/parallel-${GNU_PARALLEL_VERSION}.tar.bz2 ./
RUN tar -xf parallel-${GNU_PARALLEL_VERSION}.tar.bz2

WORKDIR /src/parallel-${GNU_PARALLEL_VERSION}
RUN autoreconf -fiv && ./configure && make && make install prefix=/opt/parallel

# JPEG Archive
WORKDIR /src
ADD https://github.com/danielgtaylor/jpeg-archive/archive/v${VERSION}.tar.gz ./
RUN tar -xzf v${VERSION}.tar.gz

WORKDIR /src/jpeg-archive-${VERSION}
RUN make && make install PREFIX=/opt/jpeg-archive


FROM alpine:3.7
COPY --from=builder /opt/jpeg-archive /opt/jpeg-archive
COPY --from=builder /opt/parallel /opt/parallel

ENV PATH=${PATH}:/opt/parallel/bin:/opt/jpeg-archive/bin
CMD jpeg-recompress