#!/bin/bash
cd ./rocky8/

files="./files.out"
username="admin"
password="admin1234"
# Nexus - Repodata Depth: 0
nexusurl="http://besu-nexus3u-0.besu:8081/repository/yum-hosted/"

find . -name '*.rpm' -type f | cut -c 3- | grep "." > $files
while read i; do
echo "upload $i to $nexusurl"
curl -v -u $username:$password --upload-file $i "$nexusurl$i"
done <$files
