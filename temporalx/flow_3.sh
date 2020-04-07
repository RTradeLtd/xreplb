#! /bin/bash

cat << EOF >  replication.yml
topic: flow 3
author: 12D3KooWGrjfQVFPBoPXGBjwLpDtyQZ9iFCD55BjVxndH9YKHw2n
version: 1
redundancy: 3
cids: []
servers:
- id: 12D3KooWGrjfQVFPBoPXGBjwLpDtyQZ9iFCD55BjVxndH9YKHw2n
  grpcport: 9094
  addresses:
  - /ip4/127.0.0.1/tcp/4005
- id: 12D3KooWC2HDv4NtkrEgZyDaHCbE7SzwFciJihCCdaoacNtEnTi1
  grpcport: 9095
  addresses:
  - /ip4/127.0.0.1/tcp/4006
- id: 12D3KooWEeHhDv1ygsaKDNX6SFMrTSxyN4KXGkzQJLH2YqYUjUsP
  grpcport: 9096
  addresses:
  - /ip4/127.0.0.1/tcp/4007
authorprivatekey: ""
clientprivatekey: ""
EOF