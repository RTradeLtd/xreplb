# xreplb

temporalx replication benchmarks comparing overall performance vs ipfs-cluster. A note on usage, this library will not work unless you have temporalx docker images locally available and these are not publicly distributed.

# configurations

All configurations are the defaults generated by the respective clients, with the exception of `ipfs` using the `--profile=badgerds` option.

# benchmarks

The goal of the benchmarks is to compare how long it will take TemporalX to replicate X number of pins amongst 3 peers, and how long it will take IPFS Cluster to perform the same tasks. A summary of the benchmarks is as follows:

* Time to inform the replication nodes about the pinset to replicate
  * For example if we can get TemporalX replication to pull in the entire set of CIDs to replicate faster than IPFS Cluster, thats good
  * If it takes TemporalX longer to pull the entire set of CIDs to replicate slower than IPFS Cluster, thats bad
* Time to reach a consistent state about the replication pinset
  * For example, if we can get all three TemporalX nodes to have the entire pinset replicated faster than IPFS Cluster, thats good
  * If it takes TemporalX longer to have the entire pinset replicated slower than IPFS Cluster, thats bad

We will not be looking at memory consumption as it's pretty clear TemporalX will consume less memory. We have published benchmarks previously about the memory consumption of TemporalX vs go-ipfs, so memory measurements are already pretty clear. Additionally IPFS Cluster requires a total of 6 services to run the equivalent set:

* 3 go-ipfs nodes
* 3 ipfs-cluster nodes

Whereas TemporalX simply requires 3 TemporalX nodes.

# benchmark workflow

The following benchmark workflow is meant to simulate general functioning of IPFS + IPFS Cluster in an environment similar to what Temporal does, which is letting users upload files and then triggering a replication update to the IPFS Cluster pinset. In summary:

* Add all test files 1 by 1 to TemporalX/Go-IPFS
* Add all new replication pinset updates 1-by-1 to TemporalX/IPFS Cluster

### results

* TemporalX took 128 seconds to reach convergence on 1000 pins
* IPFS Cluster took 1020 seconds to reach convergence on the same 1000 pins

# errors

## a note on temporalx replication errors

One of the great things about TemporalX's replication is that it can do run-time error recovering, some of the loops may run faster than temporalx being able to process replication updates and you'll see errors like so:

```
connecting to server 0 at {12D3KooWGrjfQVFPBoPXGBjwLpDtyQZ9iFCD55BjVxndH9YKHw2n 9094 [/ip4/127.0.0.1/tcp/4005]}
failed to check server state after submit:rpc error: code = Aborted desc = replication version target lowered
connecting to server 1 at {12D3KooWC2HDv4NtkrEgZyDaHCbE7SzwFciJihCCdaoacNtEnTi1 9095 [/ip4/127.0.0.1/tcp/4006]}
failed to check server state after submit:rpc error: code = DeadlineExceeded desc = context deadline exceeded
connecting to server 2 at {12D3KooWEeHhDv1ygsaKDNX6SFMrTSxyN4KXGkzQJLH2YqYUjUsP 9096 [/ip4/127.0.0.1/tcp/4007]}
receive server status failed:rpc error: code = DeadlineExceeded desc = context deadline exceeded
error encountered: publishing failed after all servers exhausted
```

This doesn't put a stop to the replication broadcast update, and TemporalX will recover from the error, continuing on with the replication updates. Time to recovery was much faster with TemporalX (roughly 2-3 seconds) whereas IPFS Cluster appeared to have a recovery time of roughly 10 seconds for equivalent pin failures.