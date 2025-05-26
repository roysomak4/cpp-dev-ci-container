# Use minimal Alpine as base
FROM alpine:3.21

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install essential build tools and dev libs
RUN apk add --no-cache \
    # gcc, g++, make, musl-dev
    build-base \
    clang17 \
    # Build system
    cmake \
    # Fast build tool
    ninja \
    # clang-format, clang-tidy
    clang-extra-tools \
    # Static analysis
    cppcheck \
    # Debugger
    gdb \
    # Memory checker
    valgrind \
    # Library configuration tool
    pkgconf \
    # For fetching repos if needed
    git \
    # Speeds up rebuilds
    ccache \
    wget

# Create workspace
WORKDIR /workspace

# Optional: set up user to match VS Code devcontainer defaults
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN addgroup -g $USER_GID $USERNAME && \
    adduser -D -u $USER_UID -G $USERNAME $USERNAME

USER $USERNAME

# Default shell
CMD ["/bin/bash"]