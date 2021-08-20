#!/bin/bash -e

JAVA_HOME="${ROOTFS_DIR}/usr/lib/jvm/java-8-openjdk-armhf"


# 2.1-7 with ttySC support and nolockfile option
install -m 644 files/RXTXcomm.jar	        "${JAVA_HOME}/jre/lib/ext/"

install -m 644 files/librxtxI2C.so	        "${JAVA_HOME}/jre/lib/arm/"
install -m 644 files/librxtxParallel.so	        "${JAVA_HOME}/jre/lib/arm/"
install -m 644 files/librxtxRaw.so	        "${JAVA_HOME}/jre/lib/arm/"
install -m 644 files/librxtxRS485.so	        "${JAVA_HOME}/jre/lib/arm/"
install -m 644 files/librxtxSerial.so	        "${JAVA_HOME}/jre/lib/arm/"

# install -m 644 files/librxtxI2C.la	        "${JAVA_HOME}/jre/lib/arm/"
# install -m 644 files/librxtxParallel.la	"${JAVA_HOME}/jre/lib/arm/"
# install -m 644 files/librxtxRaw.la	        "${JAVA_HOME}/jre/lib/arm/"
# install -m 644 files/librxtxRS485.la	        "${JAVA_HOME}/jre/lib/arm/"
# install -m 644 files/librxtxSerial.la	        "${JAVA_HOME}/jre/lib/arm/"
