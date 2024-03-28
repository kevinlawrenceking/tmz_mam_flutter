build-web-dev:
	flutter clean
	flutter build web --source-maps --no-tree-shake-icons --web-renderer canvaskit --dart-define ENV=development

build-web-stg:
	flutter clean
	flutter build web --release --source-maps --no-tree-shake-icons --web-renderer canvaskit --dart-define ENV=staging

build-web-prod:
	flutter clean
	flutter build web --release --source-maps --no-tree-shake-icons --web-renderer canvaskit --dart-define ENV=production

clean:
	flutter clean

codegen:
	dart run build_runner build --delete-conflicting-outputs
