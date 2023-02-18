FROM mcr.microsoft.com/devcontainers/base:debian

RUN apt update -y && \
  apt install -y --no-install-recommends \
  python3-pip  && \
  apt autoremove -y && \
  apt clean -y && \
  rm -rf /var/lib/apt/lists/* /tmp/* /src

RUN pip install pre-commit detect-secrets
