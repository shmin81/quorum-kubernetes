#!/bin/bash
#########################################

# Download (jdk 17)

### x86_x64
# wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm

### macOS
# wget https://download.oracle.com/java/17/latest/jdk-17_linux-aarch64_bin.rpm

#########################################

# Download (epel-release)
yum install --downloadonly --downloaddir=. epel-release

# Download (jemalloc-devel)
yum install --downloadonly --downloaddir=. jemalloc-devel

# Download (logrotate)
yum install --downloadonly --downloaddir=. logrotate
