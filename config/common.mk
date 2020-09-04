# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= LineageOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/lineage/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/lineage/prebuilt/common/bin/50-lineage.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-lineage.sh

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/lineage/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/lineage/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/lineage/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Lineage-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/lineage/config/permissions/lineage-sysconfig.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lineage-sysconfig.xml

# Copy all Lineage-specific init rc files
$(foreach f,$(wildcard vendor/lineage/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/lineage/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Lineage!
PRODUCT_COPY_FILES += \
    vendor/lineage/config/permissions/org.lineageos.android.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/org.lineageos.android.xml

# nethunter
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/addon.d/80-nethunter.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/80-nethunter.sh \
    vendor/lineage/prebuilt/common/bin/lualibs/commands.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/lualibs/commands.lua \
    vendor/lineage/prebuilt/common/bin/lualibs/default_toys.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/lualibs/default_toys.lua \
    vendor/lineage/prebuilt/common/bin/lualibs/getopt.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/lualibs/getopt.lua \
    vendor/lineage/prebuilt/common/bin/lualibs/hf_reader.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/lualibs/hf_reader.lua \
    vendor/lineage/prebuilt/common/bin/lualibs/html_dumplib.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/lualibs/html_dumplib.lua \
    vendor/lineage/prebuilt/common/bin/lualibs/htmlskel.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/lualibs/htmlskel.lua \
    vendor/lineage/prebuilt/common/bin/lualibs/mf_default_keys.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/lualibs/mf_default_keys.lua \
    vendor/lineage/prebuilt/common/bin/lualibs/read14a.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/lualibs/read14a.lua \
    vendor/lineage/prebuilt/common/bin/lualibs/taglib.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/lualibs/taglib.lua \
    vendor/lineage/prebuilt/common/bin/lualibs/utils.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/lualibs/utils.lua \
    vendor/lineage/prebuilt/common/bin/scripts/14araw.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/14araw.lua \
    vendor/lineage/prebuilt/common/bin/scripts/cmdline.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/cmdline.lua \
    vendor/lineage/prebuilt/common/bin/scripts/dumptoemul.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/dumptoemul.lua \
    vendor/lineage/prebuilt/common/bin/scripts/emul2dump.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/emul2dump.lua \
    vendor/lineage/prebuilt/common/bin/scripts/emul2html.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/emul2html.lua \
    vendor/lineage/prebuilt/common/bin/scripts/formatMifare.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/formatMifare.lua \
    vendor/lineage/prebuilt/common/bin/scripts/hf_read.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/hf_read.lua \
    vendor/lineage/prebuilt/common/bin/scripts/htmldump.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/htmldump.lua \
    vendor/lineage/prebuilt/common/bin/scripts/mfkeys.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/mfkeys.lua \
    vendor/lineage/prebuilt/common/bin/scripts/mifare_autopwn.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/mifare_autopwn.lua \
    vendor/lineage/prebuilt/common/bin/scripts/ndef_dump.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/ndef_dump.lua \
    vendor/lineage/prebuilt/common/bin/scripts/parameters.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/parameters.lua \
    vendor/lineage/prebuilt/common/bin/scripts/remagic.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/remagic.lua \
    vendor/lineage/prebuilt/common/bin/scripts/test.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/test.lua \
    vendor/lineage/prebuilt/common/bin/scripts/test_t55x7_ask.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/test_t55x7_ask.lua \
    vendor/lineage/prebuilt/common/bin/scripts/test_t55x7_bi.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/test_t55x7_bi.lua \
    vendor/lineage/prebuilt/common/bin/scripts/test_t55x7_fsk.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/test_t55x7_fsk.lua \
    vendor/lineage/prebuilt/common/bin/scripts/test_t55x7_psk.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/test_t55x7_psk.lua \
    vendor/lineage/prebuilt/common/bin/scripts/tnp3dump.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/tnp3dump.lua \
    vendor/lineage/prebuilt/common/bin/scripts/tnp3sim.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/tnp3sim.lua \
    vendor/lineage/prebuilt/common/bin/scripts/tracetest.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/tracetest.lua \
    vendor/lineage/prebuilt/common/bin/scripts/writeraw.lua:$(TARGET_COPY_OUT_SYSTEM)/bin/scripts/writeraw.lua \
    vendor/lineage/prebuilt/common/etc/init.d/90userinit:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/90userinit \
    vendor/lineage/prebuilt/common/etc/nano/asm.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/asm.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/awk.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/awk.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/c.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/c.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/cmake.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/cmake.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/css.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/css.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/fortran.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/fortran.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/groff.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/groff.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/html.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/html.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/java.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/java.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/makefile.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/makefile.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/nanorc \
    vendor/lineage/prebuilt/common/etc/nano/nanorc.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/nanorc.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/objc.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/objc.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/ocaml.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/ocaml.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/patch.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/patch.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/perl.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/perl.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/php.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/php.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/python.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/python.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/ruby.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/ruby.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/sh.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/sh.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/tcl.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/tcl.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/tex.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/tex.nanorc \
    vendor/lineage/prebuilt/common/etc/nano/xml.nanorc:$(TARGET_COPY_OUT_SYSTEM)/etc/nano/xml.nanorc \
    vendor/lineage/prebuilt/common/etc/permissions/com.offsec.nethunter.store.privileged.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.offsec.nethunter.store.privileged.xml \
    vendor/lineage/prebuilt/common/etc/terminfo/E/Eterm:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/E/Eterm \
    vendor/lineage/prebuilt/common/etc/terminfo/E/Eterm-color:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/E/Eterm-color \
    vendor/lineage/prebuilt/common/etc/terminfo/a/ansi:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/a/ansi \
    vendor/lineage/prebuilt/common/etc/terminfo/c/cons25:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/c/cons25 \
    vendor/lineage/prebuilt/common/etc/terminfo/c/cygwin:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/c/cygwin \
    vendor/lineage/prebuilt/common/etc/terminfo/d/dumb:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/d/dumb \
    vendor/lineage/prebuilt/common/etc/terminfo/h/hurd:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/h/hurd \
    vendor/lineage/prebuilt/common/etc/terminfo/l/linux:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/l/linux \
    vendor/lineage/prebuilt/common/etc/terminfo/m/mach:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/m/mach \
    vendor/lineage/prebuilt/common/etc/terminfo/m/mach-bold:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/m/mach-bold \
    vendor/lineage/prebuilt/common/etc/terminfo/m/mach-color:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/m/mach-color \
    vendor/lineage/prebuilt/common/etc/terminfo/p/pcansi:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/p/pcansi \
    vendor/lineage/prebuilt/common/etc/terminfo/r/rxvt:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/r/rxvt \
    vendor/lineage/prebuilt/common/etc/terminfo/r/rxvt-basic:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/r/rxvt-basic \
    vendor/lineage/prebuilt/common/etc/terminfo/s/screen:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/s/screen \
    vendor/lineage/prebuilt/common/etc/terminfo/s/screen-256color:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/s/screen-256color \
    vendor/lineage/prebuilt/common/etc/terminfo/s/screen-256color-bce:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/s/screen-256color-bce \
    vendor/lineage/prebuilt/common/etc/terminfo/s/screen-bce:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/s/screen-bce \
    vendor/lineage/prebuilt/common/etc/terminfo/s/screen-s:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/s/screen-s \
    vendor/lineage/prebuilt/common/etc/terminfo/s/screen-w:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/s/screen-w \
    vendor/lineage/prebuilt/common/etc/terminfo/s/sun:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/s/sun \
    vendor/lineage/prebuilt/common/etc/terminfo/v/vt100:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/v/vt100 \
    vendor/lineage/prebuilt/common/etc/terminfo/v/vt102:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/v/vt102 \
    vendor/lineage/prebuilt/common/etc/terminfo/v/vt220:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/v/vt220 \
    vendor/lineage/prebuilt/common/etc/terminfo/v/vt52:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/v/vt52 \
    vendor/lineage/prebuilt/common/etc/terminfo/w/wsvt25:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/w/wsvt25 \
    vendor/lineage/prebuilt/common/etc/terminfo/w/wsvt25m:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/w/wsvt25m \
    vendor/lineage/prebuilt/common/etc/terminfo/x/xterm:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/x/xterm \
    vendor/lineage/prebuilt/common/etc/terminfo/x/xterm-256color:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/x/xterm-256color \
    vendor/lineage/prebuilt/common/etc/terminfo/x/xterm-color:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/x/xterm-color \
    vendor/lineage/prebuilt/common/etc/terminfo/x/xterm-r5:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/x/xterm-r5 \
    vendor/lineage/prebuilt/common/etc/terminfo/x/xterm-r6:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/x/xterm-r6 \
    vendor/lineage/prebuilt/common/etc/terminfo/x/xterm-vt220:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/x/xterm-vt220 \
    vendor/lineage/prebuilt/common/etc/terminfo/x/xterm-xfree86:$(TARGET_COPY_OUT_SYSTEM)/etc/terminfo/x/xterm-xfree86 \
    vendor/lineage/prebuilt/common/xbin/hid-keyboard:$(TARGET_COPY_OUT_SYSTEM)/xbin/hid-keyboard \
    vendor/lineage/prebuilt/common/etc/firmware/ar9170-1.fw:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/ar9170-1.fw \
    vendor/lineage/prebuilt/common/etc/firmware/bluetooth_rxtx.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/bluetooth_rxtx.bin \
    vendor/lineage/prebuilt/common/etc/firmware/carl9170-1.fw:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/carl9170-1.fw \
    vendor/lineage/prebuilt/common/etc/firmware/hackrf_jawbreaker_usb.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/hackrf_jawbreaker_usb.bin \
    vendor/lineage/prebuilt/common/etc/firmware/hackrf_one_usb.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/hackrf_one_usb.bin \
    vendor/lineage/prebuilt/common/etc/firmware/htc_7010.fw:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/htc_7010.fw \
    vendor/lineage/prebuilt/common/etc/firmware/htc_9271.fw:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/htc_9271.fw \
    vendor/lineage/prebuilt/common/etc/firmware/rt73.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rt73.bin \
    vendor/lineage/prebuilt/common/etc/firmware/rt2561.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rt2561.bin \
    vendor/lineage/prebuilt/common/etc/firmware/rt2561s.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rt2561s.bin \
    vendor/lineage/prebuilt/common/etc/firmware/rt2661.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rt2661.bin \
    vendor/lineage/prebuilt/common/etc/firmware/rt2860.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rt2860.bin \
    vendor/lineage/prebuilt/common/etc/firmware/rt2870.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rt2870.bin \
    vendor/lineage/prebuilt/common/etc/firmware/rt3070.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rt3070.bin \
    vendor/lineage/prebuilt/common/etc/firmware/rt3071.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rt3071.bin \
    vendor/lineage/prebuilt/common/etc/firmware/rt3290.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rt3290.bin \
    vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8188efw.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/tlwifi/rtl8188efw.bin \
    vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8188eufw.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8188eufw.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192cfw.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192cfw.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192cfwU.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192cfwU.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192cfwU_B.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192cfwU_B.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192cufw.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192cufw.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192cufw_A.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192cufw_A.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192cufw_B.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192cufw_B.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192cufw_TMSC.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192cufw_TMSC.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192defw.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192defw.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192eefw.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192eefw.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192eu_ap_wowlan.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192eu_ap_wowlan.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192eu_nic.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192eu_nic.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192eu_wowlan.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192eu_wowlan.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8192sefw.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8192sefw.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8712u.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8712u.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723aufw_A.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723aufw_A.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723aufw_B.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723aufw_B.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723aufw_B_NoBT.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723aufw_B_NoBT.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723befw.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723befw.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723befw_36.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723befw_36.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723bs_ap_wowlan.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723bs_ap_wowlan.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723bs_bt.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723bs_bt.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723bs_nic.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723bs_nic.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723bs_wowlan.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723bs_wowlan.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723bu_ap_wowlan.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723bu_ap_wowlan.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723bu_nic.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723bu_nic.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723bu_wowlan.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723bu_wowlan.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723fw.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723fw.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8723fw_B.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8723fw_B.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8821aefw.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8821aefw.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8821aefw_29.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8821aefw_29.bin \
vendor/lineage/prebuilt/common/etc/firmware/rtlwifi/rtl8821aefw_wowlan.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/rtlwifi/rtl8821aefw_wowlan.bin \
vendor/lineage/prebuilt/common/etc/firmware/zd1211/zd1211_ub:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/zd1211/zd1211_ub \
vendor/lineage/prebuilt/common/etc/firmware/zd1211/zd1211_uph:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/zd1211/zd1211_uph \
vendor/lineage/prebuilt/common/etc/firmware/zd1211/zd1211_uphm:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/zd1211/zd1211_uphm \
vendor/lineage/prebuilt/common/etc/firmware/zd1211/zd1211_uphr:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/zd1211/zd1211_uphr \
vendor/lineage/prebuilt/common/etc/firmware/zd1211/zd1211_ur:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/zd1211/zd1211_ur \
vendor/lineage/prebuilt/common/etc/firmware/zd1211/zd1211b_ub:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/zd1211/zd1211b_ub \
vendor/lineage/prebuilt/common/etc/firmware/zd1211/zd1211b_uph:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/zd1211/zd1211b_uph \
vendor/lineage/prebuilt/common/etc/firmware/zd1211/zd1211b_uphm:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/zd1211/zd1211b_uphm \
vendor/lineage/prebuilt/common/etc/firmware/zd1211/zd1211b_uphr:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/zd1211/zd1211b_uphr \
vendor/lineage/prebuilt/common/etc/firmware/zd1211/zd1211b_ur:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/zd1211/zd1211b_ur

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Include AOSP audio files
include vendor/lineage/config/aosp_audio.mk

# Include Lineage audio files
include vendor/lineage/config/lineage_audio.mk

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/lineage/config/lineage_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/lineage/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# AOSP packages
PRODUCT_PACKAGES += \
    Terminal

# Lineage packages
PRODUCT_PACKAGES += \
    LineageParts \
    LineageSettingsProvider \
    LineageSetupWizard \
    Updater

# Themes
PRODUCT_PACKAGES += \
    LineageThemesStub \
    ThemePicker

# Extra tools in Lineage
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Root
PRODUCT_PACKAGES += \
    adb_root
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    TrebuchetQuickStep

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/lineage/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/lineage/overlay/common

PRODUCT_VERSION_MAJOR = 17
PRODUCT_VERSION_MINOR = 1
PRODUCT_VERSION_MAINTENANCE := 0

ifeq ($(TARGET_VENDOR_SHOW_MAINTENANCE_VERSION),true)
    LINEAGE_VERSION_MAINTENANCE := $(PRODUCT_VERSION_MAINTENANCE)
else
    LINEAGE_VERSION_MAINTENANCE := 0
endif

# Set LINEAGE_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef LINEAGE_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "LINEAGE_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^LINEAGE_||g')
        LINEAGE_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(LINEAGE_BUILDTYPE)),)
    LINEAGE_BUILDTYPE :=
endif

ifdef LINEAGE_BUILDTYPE
    ifneq ($(LINEAGE_BUILDTYPE), SNAPSHOT)
        ifdef LINEAGE_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            LINEAGE_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from LINEAGE_EXTRAVERSION
            LINEAGE_EXTRAVERSION := $(shell echo $(LINEAGE_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to LINEAGE_EXTRAVERSION
            LINEAGE_EXTRAVERSION := -$(LINEAGE_EXTRAVERSION)
        endif
    else
        ifndef LINEAGE_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            LINEAGE_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from LINEAGE_EXTRAVERSION
            LINEAGE_EXTRAVERSION := $(shell echo $(LINEAGE_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to LINEAGE_EXTRAVERSION
            LINEAGE_EXTRAVERSION := -$(LINEAGE_EXTRAVERSION)
        endif
    endif
else
    # If LINEAGE_BUILDTYPE is not defined, set to UNOFFICIAL
    LINEAGE_BUILDTYPE := UNOFFICIAL
    LINEAGE_EXTRAVERSION :=
endif

ifeq ($(LINEAGE_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        LINEAGE_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(LINEAGE_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(LINEAGE_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            ifeq ($(LINEAGE_VERSION_MAINTENANCE),0)
                LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(LINEAGE_BUILD)
            else
                LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(LINEAGE_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(LINEAGE_BUILD)
            endif
        else
            LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(LINEAGE_BUILD)
        endif
    endif
else
    ifeq ($(LINEAGE_VERSION_MAINTENANCE),0)
        ifeq ($(LINEAGE_VERSION_APPEND_TIME_OF_DAY),true)
            LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d_%H%M%S)-$(LINEAGE_BUILDTYPE)$(LINEAGE_EXTRAVERSION)-$(LINEAGE_BUILD)
        else
            LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(LINEAGE_BUILDTYPE)$(LINEAGE_EXTRAVERSION)-$(LINEAGE_BUILD)
        endif
    else
        ifeq ($(LINEAGE_VERSION_APPEND_TIME_OF_DAY),true)
            LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(LINEAGE_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d_%H%M%S)-$(LINEAGE_BUILDTYPE)$(LINEAGE_EXTRAVERSION)-$(LINEAGE_BUILD)
        else
            LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(LINEAGE_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(LINEAGE_BUILDTYPE)$(LINEAGE_EXTRAVERSION)-$(LINEAGE_BUILD)
        endif
    endif
endif

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/lineage/build/target/product/security/lineage

-include vendor/lineage-priv/keys/keys.mk

LINEAGE_DISPLAY_VERSION := $(LINEAGE_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
    ifneq ($(LINEAGE_BUILDTYPE), UNOFFICIAL)
        ifndef TARGET_VENDOR_RELEASE_BUILD_ID
            ifneq ($(LINEAGE_EXTRAVERSION),)
                # Remove leading dash from LINEAGE_EXTRAVERSION
                LINEAGE_EXTRAVERSION := $(shell echo $(LINEAGE_EXTRAVERSION) | sed 's/-//')
                TARGET_VENDOR_RELEASE_BUILD_ID := $(LINEAGE_EXTRAVERSION)
            else
                TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
            endif
        else
            TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
        endif
        ifeq ($(LINEAGE_VERSION_MAINTENANCE),0)
            LINEAGE_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(LINEAGE_BUILD)
        else
            LINEAGE_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(LINEAGE_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(LINEAGE_BUILD)
        endif
    endif
endif
endif

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/lineage/config/partner_gms.mk
