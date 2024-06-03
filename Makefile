# SPDX-License-Identifier: GPLv3
#
# Makefile
# Copyright Peter Jones <pjones@redhat.com>
#

TOPDIR ?= .
DESTDIR ?= temp
VERSION ?= 0

include $(TOPDIR)/utils.mk

all:

install :
	install -m 0755 -d "$(DESTDIR)/usr/lib/dracut/modules.d/99grub2-emu-kexec"
	install -m 0644 -t "$(DESTDIR)/usr/lib/dracut/modules.d/99grub2-emu-kexec" $(wildcard 99grub2-emu-kexec/*)
	install -m 0755 -d "$(DESTDIR)/usr/lib/dracut/modules.d/99grub2-emu-switchroot"
	install -m 0644 -t "$(DESTDIR)/usr/lib/dracut/modules.d/99grub2-emu-switchroot" $(wildcard 99grub2-emu-switchroot/*)
	install -m 0755 -d "$(DESTDIR)/etc/dracut.conf.d"
	install -m 0644 -t "$(DESTDIR)/etc/dracut.conf.d" etc/dracut.conf.d/grub2-emu.conf

dracut-nmbl-$(VERSION).tar.xz : Makefile dracut-nmbl.spec
	@git archive --format=tar --prefix=dracut-nmbl-$(VERSION)/ HEAD \
		--add-file dracut-nmbl.spec \
		--add-file utils.mk \
		-- \
		99grub2-emu-kexec/ \
		99grub2-emu-switchroot/ \
		etc/ \
		Makefile \
	| xz > $@

tarball : dracut-nmbl-$(VERSION).tar.xz

clean :
	@rm -vf dracut-nmbl-$(VERSION).tar.xz

.PHONY: all install clean tarball

# vim:ft=make
