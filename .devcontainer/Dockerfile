FROM mcr.microsoft.com/devcontainers/base:debian

RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \
  python3-pip  && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/* /tmp/* /src

RUN pip install --no-cache-dir pre-commit detect-secrets
