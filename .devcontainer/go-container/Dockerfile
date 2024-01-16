FROM mcr.microsoft.com/devcontainers/go:dev-1.21-bookworm
RUN apt-get update \
    && apt-get clean
# Install gotestsum
RUN go install gotest.tools/gotestsum@latest
