ZOPOZIP=Speed7_ZP951_s5580n_m_20170105-131057_PC.zip
FWDIR=MP_mt6753_n325bh_s5580n_zwx_cc_128gbitp24d3_m_lte_3m-fdd-cs_mul_20170105-131057_songlixin_PC

system.raw.img: $(FWDIR)/system.img
	simg2img $< $@

$(FWDIR)/system.img: unpack

unpack: $(ZOPOZIP)
	unzip $(ZOPOZIP)
	touch $@

clean:
	rm -f unpack
	rm -rf database
	rm -rf $(FWDIR)
	rm -rf MultiDownloadTool_V1648.zip
	rm -f system.raw.img
