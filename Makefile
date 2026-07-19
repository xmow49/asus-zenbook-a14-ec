# SPDX-License-Identifier: GPL-2.0-only
#
# Out-of-tree build for the ASUS Zenbook A14 EC PoC driver.
#
# Usage:
#   make            # build i2c_asus_ec.ko against running kernel
#   make clean      # remove build artefacts
#   make load       # insmod the module (requires sudo)
#   make unload     # rmmod the module (requires sudo)
#   make dmesg      # tail kernel log lines from the driver
#
# To build against a specific kernel tree:
#   make KDIR=/path/to/linux
#

KERNELRELEASE ?= $(shell uname -r)
KDIR ?= /lib/modules/$(KERNELRELEASE)/build
PWD  := $(shell pwd)

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

load:
	sudo insmod ./i2c_asus_ec.ko

unload:
	sudo rmmod i2c_asus_ec

reload:
	-sudo rmmod i2c_asus_ec
	sudo insmod ./i2c_asus_ec.ko

dmesg:
	dmesg --ctime | grep -E 'i2c_asus_ec|asus.ec' | tail -n 40

.PHONY: all clean load unload reload dmesg
