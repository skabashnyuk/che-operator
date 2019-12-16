#!/bin/bash
#
# Copyright (c) 2012-2018 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   Red Hat, Inc. - initial API and implementation
set -e
set -x

BASE_DIR=$(cd "$(dirname "$0")"; pwd)

kubectl apply -f "${BASE_DIR}"/deploy/service_account.yaml -n che
kubectl apply -f "${BASE_DIR}"/deploy/role.yaml -n che
kubectl apply -f "${BASE_DIR}"/deploy/role_binding.yaml -n che

kubectl apply -f "${BASE_DIR}"/deploy/cluster_role.yaml -n che
kubectl apply -f "${BASE_DIR}"/deploy/cluster_role_che.yaml -n che
kubectl apply -f "${BASE_DIR}"/deploy/cluster_role_createns.yaml -n che

kubectl apply -f "${BASE_DIR}"/deploy/cluster_role_binding.yaml -n che
kubectl apply -f "${BASE_DIR}"/deploy/cluster_role_binding_che.yaml -n che
kubectl apply -f "${BASE_DIR}"/deploy/cluster_role_binding_createns.yaml -n che

kubectl apply -f "${BASE_DIR}"/deploy/crds/org_v1_che_crd.yaml -n che
# sometimes the operator cannot get CRD right away
sleep 2

# uncomment if you need Login with OpenShift
#kubectl new-app -f ${BASE_DIR}/deploy/role_binding_oauth.yaml -p NAMESPACE=$1 -n=$1
#kubectl apply -f ${BASE_DIR}/deploy/cluster_role.yaml -n=$1

kubectl apply -f "${BASE_DIR}"/deploy/operator.yaml -n che
kubectl apply -f "${BASE_DIR}"/deploy/crds/org_v1_che_cr.yaml -n che