all::

PROJECT=TracePath

.PHONY: all install uninstall clean release debug clean

debug:
	xcodebuild -project ${PROJECT}.xcodeproj -alltargets -configuration Debug build

release:
	xcodebuild -project ${PROJECT}.xcodeproj -alltargets -configuration Release build

install: uninstall release
	cp -r "build/Release/${PROJECT}.app" "/Applications"

uninstall:
	rm -rf "/Applications/${PROJECT}.app"

test: debug
	open "build/Debug/${PROJECT}.app/"

test-release: release
	open "build/Release/${PROJECT}.app/"

clean:
	rm -rf build
	rm -rf *.dmg
	rm -rf package/*.app
	rm -rf appcast.xml

package: release
	./package.py

archive:
	git archive master --prefix="${PROJECT}/" | gzip > `git describe master`.tar.gz

all:: debug
