FROM ubuntu:22.04

# Toolchain kurulumu
RUN apt-get update && apt-get install -y --no-install-recommends \
    git cmake build-essential curl zip unzip tar \
    ca-certificates pkg-config ninja-build libcurl4-openssl-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# vcpkg kurulumu
RUN git clone https://github.com/microsoft/vcpkg.git /opt/vcpkg
RUN /opt/vcpkg/bootstrap-vcpkg.sh -disableMetrics

# Environment variables
ENV VCPKG_ROOT=/opt/vcpkg
ENV PATH="${VCPKG_ROOT}:${PATH}"

WORKDIR /workspace
