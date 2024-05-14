WORKING_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
VERSION := $(shell type pubspec.yaml | findstr /R "^version:" | ForEach-Object { $_ -replace 'version:\s*', '' })

build-web-dev:
	flutter clean
	flutter build web --source-maps --no-tree-shake-icons --web-renderer canvaskit --dart-define ENV=development

build-web-stg:
	flutter clean
	flutter build web --release --source-maps --no-tree-shake-icons --web-renderer canvaskit --dart-define ENV=staging
	(robocopy "${WORKING_DIR}.build_deps/" "${WORKING_DIR}build/web/" /s) ^& IF %ERRORLEVEL% LEQ 1 exit 0
	"C:\Program Files\7-Zip\7z.exe" a -y "${WORKING_DIR}build/damz web stg v${VERSION}.zip" "${WORKING_DIR}build/web/*"

build-web-prod:
	flutter clean
	flutter build web --release --source-maps --no-tree-shake-icons --web-renderer canvaskit --dart-define ENV=production
	(robocopy "${WORKING_DIR}.build_deps/" "${WORKING_DIR}build/web/" /s) ^& IF %ERRORLEVEL% LEQ 1 exit 0
	"C:\Program Files\7-Zip\7z.exe" a -y "${WORKING_DIR}build/damz web prod v${VERSION}.zip" "${WORKING_DIR}build/web/*"

clean:
	flutter clean

codegen:
	dart run build_runner build --delete-conflicting-outputs
