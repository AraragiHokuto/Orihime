#!/bin/sh

#
# --- Configurations ---
# Adjust those according to your setup
#

## Root of repository
export REPO_ROOT=`git rev-parse --show-toplevel`

## Distributable system root location
export SYSTEM_ROOT=${REPO_ROOT}/sysroot

## Working dir for build process
export BUILD_DIR=${REPO_ROOT}/build

## Build type: "Debug" or "Release"
export BUILD_TYPE=Debug

## Target architecture
export BUILD_ARCH=amd64

## Toolchain definitions
### LLVM root
export LLVM_ROOT=`realpath ${REPO_ROOT}/../llvm-orihime-root`

### C Compiler
export CC=${LLVM_ROOT}/bin/clang

### Assembler
export AS=${LLVM_ROOT}/bin/clang

### Linker
export LD=${LLVM_ROOT}/bin/ld.lld

#
# --- Internal definitions ---
# Do not touch those unless you know what you are doing
#

case $BUILD_ARCH in
    amd64)
	TRIPLE_ARCH=x86_64
	;;
esac

case $BUILD_TYPE in
    Debug)
	CFLAGS=-g
	;;
    Release)
	CLAGS=-O2
	;;
esac

# common CFLAGS
export CFLAGS="\
${CFLAGS} \
-Wall -Wextra \
-Wno-unused-function \
-Wno-sign-compare \
-I${REPO_ROOT}/include \
--target=${TRIPLE_ARCH}-pc-orihime-elf \
--sysroot=${SYSTEM_ROOT}"

# Add makefile rules inclusion
export MAKEFLAGS=-I${REPO_ROOT}/makerules

#
# --- Info output ---
#

echo "Project root:\t${REPO_ROOT}"
echo "Output sysroot:\t${SYSTEM_ROOT}"
echo "Build type:\t${BUILD_TYPE}"
echo "Target triple:\t${TRIPLE_ARCH}-pc-orihime-elf"
echo "C Compiler:\t${CC}"
echo "Assembler:\t${AS}"
echo "Linker:\t\t${LD}"
echo
echo "Run BSD make to build the whole system"
