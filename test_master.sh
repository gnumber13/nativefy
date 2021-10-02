#!/bin/sh 
echo "executing healthcheck..."
bats --tap test_healthcheck.sh


echo "executing unittests..."
bats --tap test_nativefy.sh
