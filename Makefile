.PHONY: pg
pg:
	@flutter pub get --no-example

.PHONY: clean
get:
	@flutter clean

.PHONY: analyze
analyze:
	@flutter analyze ./packages
	@dart format --set-exit-if-changed -o none -l 120 ./packages

.PHONY: fix
fix:
	@dart format -l 120 ./packages
	@dart fix --apply