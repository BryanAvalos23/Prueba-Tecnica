#!/usr/bin/env bash
set -Eeuo pipefail
set +x

: "${VAULT_ADDR:?Falta VAULT_ADDR}"
: "${VAULT_TOKEN:?Falta VAULT_TOKEN}"

export VAULT_FORMAT=json

# Confirmar que Vault responde y está desbloqueado.
vault status -format=json |
  python3 -c '
import json,sys
d=json.load(sys.stdin)
if d.get("sealed", True):
    sys.exit("Vault sigue sellado; desbloquéalo antes de continuar.")
if not d.get("initialized", False):
    sys.exit("Vault no está inicializado.")
'

# No habilitar otro mount si Kubernetes Auth ya existe.
if ! vault auth list -format=json |
  python3 -c '
import json,sys
sys.exit(0 if "kubernetes/" in json.load(sys.stdin) else 1)
'; then
  vault auth enable -path=kubernetes kubernetes
fi

# Política de mínimo privilegio.
vault policy write jenkins-vso vault/policies/jenkins-vso.hcl

# Rol exclusivo para la ServiceAccount usada por VSO.
vault write auth/kubernetes/role/jenkins-vso \
  bound_service_account_names=jenkins-vault-auth \
  bound_service_account_namespaces=prueba-cusca \
  policies=jenkins-vso \
  ttl=1h

echo "Configuración de política y rol de VSO completada."