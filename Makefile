all::

PROJECT=TracePath
PROVISIONING_PROFILE='PROVISIONING_PROFILE="02040ee5-e795-42c3-a6e2-ba0f6a71c136"'

.PHONY: all clean release debug

debug:
	xcodebuild -project ${PROJECT}.xcodeproj -alltargets -configuration Debug build ${PROVISIONING_PROFILE}
	#xcodebuild -scheme TracePath

release:
	xcodebuild -project ${PROJECT}.xcodeproj -alltargets -configuration Release build ${PROVISIONING_PROFILE}

list:
	xcodebuild -list -project ${PROJECT}.xcodeproj

clean:
	rm -rf build

all:: debug
