#!/usr/bin/env bash

# Exit the script if any statement returns a non-true return value
set -e

apt autoremove -y 2&>1 >/dev/null || true
apt clean -y 2&>1 >/dev/null || true
apt autoclean -y 2&>1 >/dev/null || true

rm -rf \
  /var/lib/apt/lists/* \
  /tmp/*

find /var/log -type f | while read f; do
    echo -ne '' > ${f} 2&>1 > /dev/null || true;
done

# The for loop throws an error in case of absence file.
# Thus we'll use if-condition here.
# Note: We don't use recursive search .
if [ -z "$(find /docker/${WEB_SERVER}/after_build -maxdepth 1 -type f -name \"*.sh\" 2>/dev/null)" ]; then
  for file in /docker/${WEB_SERVER}/after_build/*.sh; do
    chmod +x ${file} || true
    ${file}
  done
fi

chmod +x /docker/entrypoint.sh || true

exit 0
