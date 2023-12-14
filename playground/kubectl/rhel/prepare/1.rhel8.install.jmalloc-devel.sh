#!/bin/bash

echo 'epel-release'
sleep 2
rpm -ivh dbus-glib-*.rpm
rpm -ivh python3*.rpm
rpm -ivh dnf-plugins-core-*.rpm
rpm -ivh epel-release-*.rpm
# to enable the CRB repository.
/usr/bin/crb enable

echo 'jemalloc-devel'
sleep 2
rpm -ivh openssl-*.rpm
rpm -ivh ncurses-*.rpm
rpm -ivh groff-base-*.rpm
rpm -ivh perl*.rpm
rpm -ivh libpkgconf-*.rpm
rpm -ivh pkgconf*.rpm
rpm -ivh jemalloc-*.rpm
