#/usr/bin/sh
# Build  arabic voice for Festival

default: all
# Clean build files
clean:
	
backup: 
	
publish:
	git push origin master 
DIR=net-ar-nwr-diphone
step3:
	echo "prepare diphone"
	cd ${DIR}; festival -b festvox/diphlist.scm festvox/ar_schema.scm '(diphone-gen-schema "ar" "etc/ardiph.list")'
step4:
	echo " build diphone "
	cd ${DIR}; festival -b festvox/diphlist.scm festvox/ar_schema.scm \
'(diphone-gen-waves "prompt-wav" "prompt-lab" "etc/ardiph.list")'
step5:
	echo "Record diphone"
	cd ${DIR}; bin/prompt_them etc/ardiph.list
step6:
	echo "auto labeling"
	cd ${DIR}; bin/make_labs prompt-wav/*.wav
step7:
	echo " manual labeling"
step8:
	echo "Create diphone index"
	cd ${DIR};  cp prompt-lab/* lab/ 
	cd ${DIR}; bin/make_diph_index etc/ardiph.list dic/nwrdiph.est
step9:
	echo "pitchmark extraction"
	cd ${DIR}; bin/make_pm_wave etc/ardiph.list 
	cd ${DIR}; bin/make_pm_fix  etc/ardiph.list 
step10:
	echo "power factor extraction"
	cd ${DIR}; bin/make_lpc etc/ardiph.list
step11:
	echo "test voice "
	cd ${DIR}; festival festvox/net_ar_nwr_diphone.scm '(voice_net_ar_nwr_diphone)'
