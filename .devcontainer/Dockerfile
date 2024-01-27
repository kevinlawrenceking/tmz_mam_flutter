# Use an official lightweight Python image as a parent image
FROM mcr.microsoft.com/vscode/devcontainers/python:0-3.8

# Install basic dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

# Install Flutter
ENV FLUTTER_VERSION=2.2.3
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar -xJf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz -C /usr/local \
    && rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run basic check to download Dart SDK
RUN flutter doctor
