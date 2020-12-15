#!/bin/bash

ROOT=${HOME}/k8s_export
while read -r resource
do
    echo "  scanning resource '${resource}'"
    while read -r namespace item x
    do
        mkdir -p "${ROOT}/${namespace}/${resource}"        
        echo "    exporting item '${namespace} ${item}'"
        kubectl get "$resource" -n "$namespace" "$item" -o yaml > "${ROOT}/${namespace}/${resource}/$item.yaml" &
    done < <(kubectl get "$resource" --all-namespaces 2>&1  | tail -n +2)
done < <(kubectl api-resources --namespaced=true 2>/dev/null | grep -v "events" | tail -n +2 | awk '{print $1}')

wait