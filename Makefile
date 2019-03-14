ZOPOZIP=Speed7_ZP951_s5580n_m_20170105-131057_PC.zip
FWDIR=MP_mt6753_n325bh_s5580n_zwx_cc_128gbitp24d3_m_lte_3m-fdd-cs_mul_20170105-131057_songlixin_PC

RAWIMG=system.raw.img

ASISFILES = \
	boot.img \
	lk.bin \
	MT6753_Android_scatter.txt \
	recovery.img \
	userdata.img \
	cache.img \
	logo.bin \
	preloader_n325bh.bin \
	secro.img \
	trustzone.bin

proto: newsystem
	rm -rf proto
	mkdir proto
	cd $(FWDIR) ; ln $(ASISFILES) ../proto
	ln -s ../$(RAWIMG) proto/system.img

newsystem: mount malware garbage umount

garbage:
	sudo rm -rf mnt/app/Hangouts	# Google Hangouts
	sudo rm -rf mnt/app/Books	# Google Play Books
	sudo rm -rf mnt/app/PlayGames	# Googpe Play Games
	sudo rm -rf mnt/app/Newsstand	# Google Play Newsstand (discontinued, replaced by Google News)

malware:
	sudo rm -rf mnt/priv-app/com.google.android.youtube	# infected
	sudo rm -rf mnt/app/com.sherlock.news	# possibly infected, unknown purpose

umount:
	-sudo umount mnt
	-rmdir mnt
	rm -f mount

mount: mnt
	test -f $(RAWIMG) || $(MAKE) $(RAWIMG)
	sudo mount -w -t ext4 -o loop $(RAWIMG) mnt
	touch $@

mnt:
	mkdir mnt

$(RAWIMG): $(FWDIR)/system.img
	simg2img $< $@

$(FWDIR)/system.img: unpack

unpack: $(ZOPOZIP)
	unzip $(ZOPOZIP)
	touch $@

clean: umount
	! test -d mnt
	rm -f unpack
	rm -rf database
	rm -rf $(FWDIR)
	rm -rf MultiDownloadTool_V1648.zip
	rm -f system.raw.img
	rm -rf proto
