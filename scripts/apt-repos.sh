#!/bin/bash
set -euo pipefail

# サードパーティAPTリポジトリの登録（Ubuntu 22.04/24.04想定・冪等）
# 実行後に scripts/apt-install.sh でパッケージを入れる

KEYRINGS=/etc/apt/keyrings
sudo install -m 0755 -d "$KEYRINGS"

CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME")
UBUNTU_VER=$(. /etc/os-release && echo "$VERSION_ID")
ARCH=$(dpkg --print-architecture)

# Docker (docker-ce, docker-ce-cli, containerd.io, docker-compose-plugin)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo gpg --dearmor --yes -o "$KEYRINGS/docker.gpg"
echo "deb [arch=$ARCH signed-by=$KEYRINGS/docker.gpg] https://download.docker.com/linux/ubuntu $CODENAME stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# GitHub CLI (gh)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo tee "$KEYRINGS/githubcli-archive-keyring.gpg" > /dev/null
sudo chmod go+r "$KEYRINGS/githubcli-archive-keyring.gpg"
echo "deb [arch=$ARCH signed-by=$KEYRINGS/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Microsoft 共通鍵 (msodbcsql18, azure-cli)
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
    | sudo gpg --dearmor --yes -o "$KEYRINGS/microsoft.gpg"

# SQL Server ODBC (msodbcsql18)
echo "deb [arch=$ARCH signed-by=$KEYRINGS/microsoft.gpg] https://packages.microsoft.com/ubuntu/$UBUNTU_VER/prod $CODENAME main" \
    | sudo tee /etc/apt/sources.list.d/mssql-release.list > /dev/null

# Azure CLI
echo "deb [arch=$ARCH signed-by=$KEYRINGS/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $CODENAME main" \
    | sudo tee /etc/apt/sources.list.d/azure-cli.list > /dev/null

sudo apt update
echo "done: docker / github-cli / mssql-release / azure-cli を登録しました"
