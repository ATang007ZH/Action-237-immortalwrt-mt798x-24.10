#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
sed -i 's/ImmortalWrt/ImmortalWrt-23.05-PW-$(shell TZ="Asia/Shanghai" date +"%Y%m%d")/g' package/base-files/files/bin/config_generate

# Modify filename, add date prefix
sed -i 's|IMG_PREFIX:=|IMG_PREFIX:=$(shell TZ="Asia/Shanghai" date +"%Y%m%d")-PW-23.05|' include/image.mk

# Modify ppp-down, add sleep 3. my source code is change, no need this
sed -i '$a\\sleep 3' package/network/services/ppp/files/lib/netifd/ppp-down

# Insert two lines before the last line in 99-default-settings-chinese. For Modify opkg url, change mt7981 to filogic, del lines inlude passwall.
sed -i '/^exit 0$/i sed -i "s,mt7981,filogic,g" "package/base-files/files/etc/opkg/distfeeds.conf"\nsed -i '\''/passwall/d'\'' "package/base-files/files/etc/opkg/distfeeds.conf"' package/emortal/default-settings/files/99-default-settings-chinese

# Insert code to display distfeeds.conf before exit 0
#sed -i '/^exit 0$/i echo "Displaying distfeeds.conf content:"\ncat "package/base-files/files/etc/opkg/distfeeds.conf"' package/emortal/default-settings/files/99-default-settings-chinese
    
