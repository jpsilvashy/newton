
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m

#
# BUILD DOCS
#

build:
	@echo "Building Newton..."
	# Build docs here
	@echo "${CHECK} Newton successfully built at ${DATE}."

#
# CLEANS THE ROOT DIRECTORY OF PRIOR BUILDS
#

clean:
	rm -r newton

#
# BUILD SIMPLE BOOTSTRAP DIRECTORY
# recess & uglifyjs are required
#

newton: newton-css newton-js


#
# JS COMPILE
#
newton-js: newton/javascripts/*.js

newton/javascripts/*.js: javascripts/*.js
	mkdir -p newton/javascripts
	cat javascripts/newton-modal.js javascripts/newton-alert.js > newton/javascripts/newton.js
	./node_modules/.bin/uglifyjs -nc newton/javascripts/newton.js > newton/javascripts/newton.min.tmp.js
	cat newton/javascripts/newton.min.tmp.js > newton/javascripts/newton.min.js
	rm newton/javascripts/newton.min.tmp.js

#
# CSS COMPLILE
#

newton-css: newton/stylesheets/*.css

newton/stylesheets/*.css: less/*.less
	mkdir -p newton/stylesheets
	./node_modules/.bin/recess --compile ./less/newton.less > newton/stylesheets/newton.css
	./node_modules/.bin/recess --compress ./less/newton.less > newton/stylesheets/newton.min.css

#
# IMAGES
#


watch:
	echo "Watching less files..."; \
	watchr -e "watch('less/.*\.less') { system 'make' }"


.PHONY: watch newton-css newton-js