# sentiric-vcpkg-base/Dockerfile
FROM ubuntu:22.04

# Toolchain kurulumu - optimizasyonlu
RUN apt-get update && apt-get install -y --no-install-recommends \
    git cmake build-essential curl zip unzip tar \
    ca-certificates pkg-config ninja-build libcurl4-openssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# vcpkg kurulumu - optimizasyonlu
RUN git clone https://github.com/microsoft/vcpkg.git /opt/vcpkg \
    && /opt/vcpkg/bootstrap-vcpkg.sh -disableMetrics \
    && rm -rf /opt/vcpkg/.git /opt/vcpkg/docs /opt/vcpkg/scripts

# Environment variables
ENV VCPKG_ROOT=/opt/vcpkg
ENV PATH="${VCPKG_ROOT}:${PATH}"

# Çalışma dizini
WORKDIR /workspace

# Health check (opsiyonel)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD vcpkg version || exit 1
