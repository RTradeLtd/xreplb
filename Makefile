.PHONY: start-temporalx
start-temporalx:
	(cd temporalx ; make cleanup ; make start)

.PHONY: stop-temporalx
stop-temporalx:
	(cd temporalx ; docker-compose stop && docker-compose rm)

.PHONY: gen-testdata
gen-testdata:
	./gen_test_data.sh

.PHONY: fix-perms
fix-perms:
	chown -R $(shell whoami) *
	chgrp -R $(shell whoami) *