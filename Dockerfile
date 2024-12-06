FROM ubuntu:24.10

# Install utilities
RUN apt-get update && apt-get install -y software-properties-common bash wget make cmake xz-utils curl ninja-build git

# Install arm-none-eabi-gcc distributed by ARM
ENV GCC_VERSION="13.3.rel1"
ENV GCC_BASE_URL="https://developer.arm.com/-/media/Files/downloads/gnu"
ENV GCC_FOLDERNAME="arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi"
ENV GCC_ARCHIVE_FILENAME="arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi.tar.xz"
ENV DL_URL="${GCC_BASE_URL}/${GCC_VERSION}/binrel/${GCC_ARCHIVE_FILENAME}"
ENV TOOLCHAIN_FOLDER="/toolchain"

RUN mkdir -p ${TOOLCHAIN_FOLDER} \
    && wget ${DL_URL} \
    && mv ${GCC_ARCHIVE_FILENAME} ${TOOLCHAIN_FOLDER} \
    && tar xvf ${TOOLCHAIN_FOLDER}/${GCC_ARCHIVE_FILENAME} -C ${TOOLCHAIN_FOLDER} \
    && rm ${TOOLCHAIN_FOLDER}/${GCC_ARCHIVE_FILENAME}

ENV PATH="${TOOLCHAIN_FOLDER}/${GCC_FOLDERNAME}/bin:${PATH}"

COPY assets/toolchain.cmake ${TOOLCHAIN_FOLDER}/toolchain.cmake

ENTRYPOINT ["/bin/bash", "-l", "-c"]