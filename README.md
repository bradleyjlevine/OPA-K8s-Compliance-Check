# OPA-K8s-Compliance-Check
kubectl and jq to check for running OPA Gatekeeper pods

# OPA Gatekeeper Deploy
```bash
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml
```

# Kubectl Test
```bash
kubectl get pods -A -o json | jq --arg labelk gatekeeper.sh/system '.items |= map(select(.metadata.labels | .[$labelk]=="yes")) | [{name:.items[].metadata.name, ns:.items[].metadata.namespace, phase:.items[].status.phase, image:.items[].spec.containers[].image}]' | jq unique | jq '.[] | select(.phase=="Running")'
```
