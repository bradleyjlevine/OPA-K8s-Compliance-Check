#!/bin/bash

test1=$(kubectl get pods -A -o json | jq --arg labelk gatekeeper.sh/system '.items |= map(select(.metadata.labels | .[$labelk]=="yes")) | [{name:.items[].metadata.name, ns:.items[].metadata.namespace, phase:.items[].status.phase, image:.items[].spec.containers[].image}]' | jq unique | jq '.[] | select(.phase=="Running")' | jq '. | length' | grep "4" -c)

if [[ "$test1" > "0" ]]; then
	echo "Passed! OPA Gatekeeper Found and Running."
else
	echo "Failed! OPA Gatekeeper Not Found Running."
fi
