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
	sudo rm -rf mnt/app/PlayGames	# Google Play Games
	sudo rm -rf mnt/app/Music2	# Google Play Music
	sudo rm -rf mnt/app/GoogleVideos	# Google Play Movies & TV
	sudo rm -rf mnt/app/PlusOne	# Google+
	sudo rm -rf mnt/app/Newsstand	# Google Play Newsstand (discontinued, replaced by Google News)
	sudo rm -rf mnt/app/NewsWeather	# Google News & Weather (discontinued, replaced by Google News)
	sudo rm -rf mnt/app/Drive	# Google Drive
	sudo rm -rf mnt/app/Keep	# Google Keep
	sudo rm -rf mnt/app/Maps	# Google Maps
	sudo rm -rf mnt/priv-app/GooglePartnerSetup	# Google Partner Setup
	sudo rm -rf mnt/app/GoogleCalendarSyncAdapter	# Google Calendar Sync
	sudo rm -rf mnt/app/GoogleContactsSyncAdapter	# Google Contacts Sync
	sudo rm -rf mnt/app/HotKnot			# Hot Knot
	sudo rm -rf mnt/priv-app/HotKnotBeam		# Hot Knot
	sudo rm -rf mnt/priv-app/HotKnotCommonUI	# Hot Knot
	sudo rm -rf mnt/priv-app/HotKnotConnectivity	# Hot Knot
	sudo rm -rf mnt/app/AdupsFota			# Adups Fota
	sudo rm -rf mnt/app/AdupsFotaReboot		# Adups Fota
	sudo rm -rf mnt/priv-app/BackupRestoreConfirmation	# Backup and Restore
	sudo rm -rf mnt/priv-app/CallLogBackup			# Backup and Restore
	sudo rm -rf mnt/priv-app/GoogleBackupTransport		# Backup and Restore
	sudo rm -rf mnt/priv-app/SharedStorageBackup		# Backup and Restore
	sudo rm -rf mnt/vendor/operator/app/com.example.web	# zopo website
	sudo rm -rf mnt/vendor/operator/app/com.thihaayekyaw.frozenkeyboard	# Frozen Keyboard
	sudo rm -rf mnt/app/LocationEM2	# LocationEM2
	sudo rm -rf mnt/app/HoloSpiralWallpaper		# Wallpapers
	sudo rm -rf mnt/app/PhaseBeam			# Wallpapers
	sudo rm -rf mnt/app/LiveWallpapers		# Wallpapers
	sudo rm -rf mnt/app/LiveWallpapersPicker	# Wallpapers
	sudo rm -rf mnt/app/Exchange2	# Exchange Services
	sudo rm -rf mnt/app/SchedulePowerOnOff	# Scheduled power on & off
	sudo rm -rf mnt/app/Email	# Email (not easily upgradable)
	sudo rm -rf mnt/app/BSPTelephonyDevTool	# BSPTelephonyDevTool 1.0

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

clobber: clean
	rm -f $(ZOPOZIP)
