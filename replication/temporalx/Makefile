.PHONY: start
start:
	docker-compose up -d

.PHONY: cleanup
cleanup:
	docker-compose stop && docker-compose rm -v
	# create a fresh replication environment
	sudo rm -rf node1/keystore node1/peerstore node1/storage
	sudo rm -rf node2/keystore node2/peerstore node2/storage
	sudo rm -rf node3/keystore node3/peerstore node3/storage
	mkdir -p node1/storage/replication/publishers 
	mkdir -p node2/storage/replication/publishers
	mkdir -p node3/storage/replication/publishers
	cp 12D3KooWGrjfQVFPBoPXGBjwLpDtyQZ9iFCD55BjVxndH9YKHw2n.publickey node1/storage/replication/publishers
	cp 12D3KooWGrjfQVFPBoPXGBjwLpDtyQZ9iFCD55BjVxndH9YKHw2n.publickey node2/storage/replication/publishers 
	cp 12D3KooWGrjfQVFPBoPXGBjwLpDtyQZ9iFCD55BjVxndH9YKHw2n.publickey node3/storage/replication/publishers
	# reset the list of replicated cids
	tex-cli rep edit -r all