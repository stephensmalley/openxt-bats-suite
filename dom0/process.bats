#!/usr/bin/env bats

@test "check core processes are running" {
    run ps -e

    [ $(grep xenmgr <<< "${output}"|wc -l ) -eq 1 ]
    [ $(grep dbd <<< "${output}"|wc -l ) -eq 1 ]
    [ $(grep xenstored <<< "${output}"|wc -l ) -eq 1 ]
    [ $(grep uid <<< "${output}"|wc -l ) -eq 1 ]
    [ $(grep xcpmd <<< "${output}"|wc -l ) -eq 1 ]
    [ $(grep input_server <<< "${output}"|wc -l ) -eq 1 ]
    [ $(grep rpc-proxy <<< "${output}"|wc -l ) -eq 3 ]
    [ $(grep vusb-daemon <<< "${output}"|wc -l ) -eq 1 ]
    [ $(grep network-daemon <<< "${output}"|wc -l ) -eq 1 ]

}

