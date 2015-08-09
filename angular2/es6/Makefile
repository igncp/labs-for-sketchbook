.PHONY: run-tests

installs:
	@sudo npm install
	@bower install
	@echo 'Done.'

server:
	@echo "Port 9000"
	@http-server -s -c-1 -p 9000

run-tests:
	sh ./run-tests

karma-start:
	./node_modules/.bin/karma start