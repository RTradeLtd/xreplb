.PHONY: start-temporalx
start-temporalx:
	(cd temporalx ; make cleanup ; make start)

.PHONY: stop-temporalx
stop-temporalx:
	(cd temporalx ; docker-compose stop && docker-compose rm -v ; make cleanup)

.PHONY: start-ipfs
start-ipfs:
	(cd cluster ; docker-compose up -d)

.PHONY: stop-ipfs
stop-ipfs:
	(cd cluster ; docker-compose stop ; docker-compose rm -v)

.PHONY: gen-testdata
gen-testdata:
	./gen_test_data.sh

.PHONY: fix-perms
fix-perms:
	chown -R $(shell whoami) *
	chgrp -R $(shell whoami) *

.PHONY: temporalx-flow1
temporalx-flow1:
	(cd temporalx ; ./flow_1.sh 1000)

.PHONY: temporalx-flow2
temporalx-flow2:
	(cd temporalx ; ./flow_2.sh 1000)

.PHONY: temporalx-flow3
temporalx-flow3:
	(cd temporalx ; ./flow_3.sh 1000)

.PHONY: ipfs-flow1
ipfs-flow1:
	(cd cluster ; ./flow_1.sh 1000)

# this isn't working for some reason
# .PHONY: gen-file-list
# gen-file-list:
#	ls -l test_data | awk '{print $NF}' > file_list.txt
