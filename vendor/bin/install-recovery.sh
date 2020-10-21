#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):67108864:b19fa817c9f2f547719a7792eb5b98184375137d; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot$(getprop ro.boot.slot_suffix):134217728:6b4f59fe5acc69e81d6ba0f37b6282b4f4e42f48 \
          --target EMMC:/dev/block/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):67108864:b19fa817c9f2f547719a7792eb5b98184375137d && \
      log -t recovery "Installing new recovery image: succeeded" && \
        echo "Installing new recovery image: succeeded" > /cache/recovery/last_install_recovery_status || \
      (log -t recovery "Installing new recovery image: failed" && \
        echo "Installing new recovery image: failed" > /cache/recovery/last_install_recovery_status)
else
  log -t recovery "Recovery image already installed" && \
  echo "Recovery image already installed" > /cache/recovery/last_install_recovery_status
fi
