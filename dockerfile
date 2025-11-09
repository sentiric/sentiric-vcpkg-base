# sentiric-vcpkg-base/Dockerfile
FROM ubuntu:22.04

# Build arguments
ARG VCPKG_VERSION=latest

# Environment variables
ENV VCPKG_ROOT=/opt/vcpkg
ENV PATH="${VCPKG_ROOT}:${PATH}"

# Install system dependencies (including CMake from apt)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git cmake build-essential curl zip unzip tar \
    ca-certificates pkg-config ninja-build \
    libcurl4-openssl-dev libssl-dev \
    python3 python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone and bootstrap vcpkg
RUN git clone https://github.com/microsoft/vcpkg.git ${VCPKG_ROOT} && \
    cd ${VCPKG_ROOT} && \
    if [ "$VCPKG_VERSION" != "latest" ]; then git checkout $VCPKG_VERSION; fi && \
    ./bootstrap-vcpkg.sh -disableMetrics

# Verify vcpkg installation
RUN vcpkg version && vcpkg list

# Create working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]