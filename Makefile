run: clean build
	cp ./.build/release/packageddataviewer /usr/local/bin/packageddataviewer
	packageddataviewer --help || exit 0 # --help exits with 1

install:
	./scripts/install.sh

clean: install
	swift package clean

build: install
	swift build --configuration release -Xswiftc -static-stdlib

release: clean build
	./scripts/release.sh $(version)

publish: clean build
	./scripts/publish.sh $(version) $(token)

xcode: install
	swift package generate-xcodeproj
	open PackagedDataViewer.xcodeproj
