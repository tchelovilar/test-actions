#!/bin/bash

# Execute some commands in case of sigterm
function stop_deploy {
    echo "** Sigterm received **"
    sleep 3
    echo "Job cancelled..."
    echo "Exiting"
}


# Fake command to waste time
function fake_deploy {
    while [ 1 ] ; do
        echo "Deploy is running"
        sleep 1
        (( count++ ))
        if [[ $count -gt 60 ]]; then
            exit 0
        fi
    done
}


# Trap for sigterm to execute some commands before exit
trap 'trap " " SIGINT SIGTERM; kill 0; wait; stop_deploy' SIGINT SIGTERM


# Start and wait the deploy script finish
fake_deploy &
deploy_pid=$!

wait "$deploy_pid"
