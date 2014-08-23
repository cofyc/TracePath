all::

PROJECT=TracePath
PROVISIONING_PROFILE='PROVISIONING_PROFILE="EE35AA15-55EF-4210-B3FF-2E0116E8CB00"'

.PHONY: all clean release debug

debug:
	xcodebuild -project ${PROJECT}.xcodeproj -alltargets -configuration Debug build ${PROVISIONING_PROFILE}

release:
	xcodebuild -project ${PROJECT}.xcodeproj -alltargets -configuration Release build ${PROVISIONING_PROFILE}

list:
	xcodebuild -list -project ${PROJECT}.xcodeproj

clean:
	rm -rf build

all:: debug
