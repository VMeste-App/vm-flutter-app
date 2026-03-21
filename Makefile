.PHONY: pg
pg:
	@fvm flutter pub get

.PHONY: clean
clean:
	@fvm flutter clean

.PHONY: init
init:
	make clean && make pg

.PHONY: analyze
analyze:
	@fvm flutter analyze ./packages
	@fvm dart format --set-exit-if-changed -o none -l 120 ./packages

.PHONY: fix
fix:
	@fvm dart format -l 120 ./packages
	@fvm dart fix --apply