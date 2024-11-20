FROM ubuntu:22.04

# Install utilities
RUN apt-get update && apt-get install -y software-properties-common bash wget make cmake xz-utils curl ninja-build git

# Install arm-none-eabi-gcc distributed by ARM
ENV GCC_VERSION="13.3.rel1"
ENV GCC_BASE_URL="https://developer.arm.com/-/media/Files/downloads/gnu"
ENV GCC_FOLDERNAME="arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi"
ENV GCC_ARCHIVE_FILENAME="arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi.tar.xz"
ENV DL_URL="${GCC_BASE_URL}/${GCC_VERSION}/binrel/${GCC_ARCHIVE_FILENAME}"

RUN mkdir -p /devtools \
    && wget ${DL_URL} \
    && mv ${GCC_ARCHIVE_FILENAME} /devtools \
    && tar xvf /devtools/${GCC_ARCHIVE_FILENAME} -C /devtools \
    && rm /devtools/${GCC_ARCHIVE_FILENAME}

ENV PATH="/devtools/${GCC_FOLDERNAME}/bin:${PATH}"

ENTRYPOINT ["/bin/bash"]