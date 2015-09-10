#!/bin/bash

VBoxService --foreground --verbose --only-automount 2>&1 | \
while read line
do
  mount_log=$(echo $line | grep automount)

  if [ $? -eq 0 ] ; then
    mount_src=$(echo "$mount_log" | cut --delimiter '"' --fields 2)
    mount_target=$(echo "$mount_log" | cut --delimiter '"' --fields 4)

    echo "Mounting ${mount_src} on ${mount_target}"
    nsenter --mount=/hproc/1/ns/mnt mkdir -p "$mount_target"
    nsenter --mount=/hproc/1/ns/mnt mount -t vboxsf "$mount_src" "$mount_target"
  fi
done
