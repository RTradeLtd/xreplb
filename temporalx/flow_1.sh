#! /bin/bash

# reset the repliation file

cat << EOF >  replication.yml
topic: flow 1
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

COUNT=0
MAX=$1
echo "start time $(date +%s)" > timer.txt
while IFS= read -r line; do
    if [[ "$COUNT" -ge "$MAX" ]]; then
      break
    fi
    FILE_NAME="../test_data/$line"
    HASH=$(tex-cli --config node1/config.yml client file upload --fn $FILE_NAME | awk '{print $NF}' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
    tex-cli --config node1/config.yml  rep edit -i -a "$HASH"
    tex-cli --config node1/config.yml rep sign
    let COUNT=COUNT+1
done < ../file_list.txt

while true; do
  OUTPUT=$(tex-cli --config node1/config.yml rep check | awk '{print $NF}')
  # get the current replication version number of node 1
  STAT1=$(echo $OUTPUT | sed '2,3d')
  # get the current replication version number of node 2
  STAT2=$(echo $OUTPUT | sed '1d;$d')
  # get the current replication version number of node 3
  STAT3=$(echo $OUTPUT | sed '1,2d')
  # ensure they're all the same, and greater than or equal to max indicating a successful convergence
  if [[ "$STAT1" == "$STAT2" && "$STAT2" == "$STAT3" && "$STAT1" == "$STAT3"]]; then
    break
  fi
done

echo "end time $(date +%s)" >> timer.txt

echo "time to convergence $(./calc.sh)"