#! /bin/sh -e

echo Config.
python /files/mako-render.py /files/nfs.conf.mako /files/config.yaml \
 > /etc/exports.d/container.exports

