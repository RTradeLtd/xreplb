#! /bin/bash
MAX=1001
while true; do
  OUTPUT=$(tex-cli --config node1/config.yml rep check | awk '{print $NF}')
  # get the current replication version number of node 1
  STAT1=$(echo $OUTPUT | awk '{print $1}')
  # get the current replication version number of node 2
  STAT2=$(echo $OUTPUT | awk '{print $2}')
  # get the current replication version number of node 3
  STAT3=$(echo $OUTPUT | awk '{print $3}')
  # ensure they're all the same, and greater than or equal to max indicating a successful convergence
  if [[ "$STAT1" == "$STAT2" && "$STAT2" == "$STAT3" && "$STAT1" == "$STAT3" ]]; then
    break
  fi
done
