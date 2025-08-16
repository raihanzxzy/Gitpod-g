# .gitpod.Dockerfile
# Menggunakan image dasar Gitpod dengan dukungan VNC
FROM gitpod/workspace-full-vnc

# Variabel untuk versi Ghidra
ARG GHIDRA_VERSION=11.4.1
ARG GHIDRA_RELEASE_NAME=ghidra_${GHIDRA_VERSION}_PUBLIC
ARG GHIDRA_ZIP_NAME=${GHIDRA_RELEASE_NAME}_20250731.zip
ARG GHIDRA_DOWNLOAD_URL=https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${GHIDRA_VERSION}_build/${GHIDRA_ZIP_NAME}

# Beralih ke user root untuk instalasi
USER root

# Instal dependensi yang dibutuhkan, termasuk JDK 21
# Berdasarkan README, Ghidra memerlukan JDK 21
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends openjdk-21-jdk wget unzip && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# Pindah ke direktori /tmp untuk mengunduh file
WORKDIR /tmp

# Unduh dan ekstrak Ghidra ke direktori home gitpod
RUN echo "Mengunduh Ghidra dari ${GHIDRA_DOWNLOAD_URL}" && \
    wget -q "${GHIDRA_DOWNLOAD_URL}" && \
    unzip -q "${GHIDRA_ZIP_NAME}" -d /workspace/Gitpod-g/ && \
    rm "${GHIDRA_ZIP_NAME}"

# Kembali ke user gitpod dan atur direktori kerja
USER gitpod
WORKDIR /workspace/Gitpod-g/
