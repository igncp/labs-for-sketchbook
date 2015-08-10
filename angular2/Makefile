bundle:
	@cd repositories/angular; gulp bundle.js.dev

pre-bundle:
	cd repositories/angular; chown -R vagrant:vagrant /home/vagrant/.config/
	cd repositories/angular; sudo npm rebuild node-sass
	cd repositories/angular; sudo npm run postinstall
