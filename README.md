# Sentiric VCPKG Base Image

Base Docker image with pre-installed vcpkg package manager and build tools.

[![Build and Push vcpkg-base](https://github.com/sentiric/sentiric-vcpkg-base/actions/workflows/build.yml/badge.svg)](https://github.com/sentiric/sentiric-vcpkg-base/actions/workflows/build.yml)

## Features

- Ubuntu 22.04 base
- vcpkg package manager
- CMake 3.27.0
- GCC toolchain
- Ninja build system
- Essential development libraries

## Usage

```dockerfile
FROM ghcr.io/sentiric/sentiric-vcpkg-base:latest

# Install dependencies
COPY vcpkg.json .
RUN vcpkg install --triplet x64-linux

# Build your project
COPY . .
RUN cmake -B build -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake
```

## Tags

- latest - Stable version with latest vcpkg
- vcpkg-{version} - Specific vcpkg versions