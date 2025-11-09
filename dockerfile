# sentiric-vcpkg-base/Dockerfile
FROM ubuntu:22.04

# Build arguments
ARG VCPKG_VERSION=latest
ARG CMAKE_VERSION=3.27.0

# Environment variables
ENV VCPKG_ROOT=/opt/vcpkg
ENV PATH="${VCPKG_ROOT}:${PATH}"

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git cmake build-essential curl zip unzip tar \
    ca-certificates pkg-config ninja-build \
    libcurl4-openssl-dev libssl-dev \
    python3 python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install specific CMake version
RUN cd /tmp && \
    curl -L https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz | tar xz && \
    cp -r cmake-${CMAKE_VERSION}-linux-x86_64/* /usr/local/ && \
    rm -rf cmake-${CMAKE_VERSION}-linux-x86_64

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