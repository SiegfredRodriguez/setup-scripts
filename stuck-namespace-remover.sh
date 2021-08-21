###########
#
#   Author: J-dar Siegfred Rodriguez
#   Create: August 21, 2021
#   
#   Used for removing stuck namespaces
#   NOTE: Stuck for a long time, probably due to delete finalizers
#
#   Symptoms: 
#       executing "kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get -n <NAMESPACE>" results in 
#       "error: unable to retrieve the complete list of server APIs: something something: the server is currently unable to handle the request"
#
#   Dependency:
#       JQ JSON processor.
#
#########################

#!/bin/bash

for ns in $(kubectl get ns --field-selector status.phase=Terminating -o jsonpath='{.items[*].metadata.name}'); do  kubectl get ns $ns -ojson | jq '.spec.finalizers = []' | kubectl replace --raw "/api/v1/namespaces/$ns/finalize" -f -; done
for ns in $(kubectl get ns --field-selector status.phase=Terminating -o jsonpath='{.items[*].metadata.name}'); do  kubectl get ns $ns -ojson | jq '.metadata.finalizers = []' | kubectl replace --raw "/api/v1/namespaces/$ns/finalize" -f -; done