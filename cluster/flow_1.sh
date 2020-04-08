#! /bin/bash


export IPFS_PATH=./configs/node1
export IPFS_CLUSTER_PATH=./configs/node1

COUNT=0
MAX=$1
echo "start time $(date +%s)" > timer.txt
while IFS= read -r line; do
    if [[ "$COUNT" -ge "$MAX" ]]; then
      break
    fi
    FILE_NAME="../test_data/$line"
    HASH=$(ipfs add $FILE_NAME | awk '{print $2}')
    ipfs-cluster-ctl pin add "$HASH"
    let COUNT=COUNT+1
done < ../file_list.txt

while true; do
    OUTPUT=$(ipfs-cluster-ctl status --filter=cluster_error,pin_error,pin_queued,queued,pinning)
    if [[ "$OUTPUT" == "" ]]; then
        break
    fi
done

echo "end time $(date +%s)" >> timer.txt
echo "time to convergence $(./calc.sh)"