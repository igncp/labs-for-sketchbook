build-repo:
	@cd repositories/jscodeshift; npm run build

install:
	@cd repositories/jscodeshift; sudo npm i

transform-all:
	@rm -fr dist;
	@./node_modules/.bin/babel-node transform-all.js