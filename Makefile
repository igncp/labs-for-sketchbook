rm-vagrant-tmp-files:
	find . -name 'vagrant*-*-*' | xargs rm -f
	find . -name 'd*-*-*' | xargs rm -fr