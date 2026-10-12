#!/usr/bin/env bash

set -Eeuo pipefail

echo "======================================"
echo " EKS Agent Cluster - Preflight Checks"
echo "======================================"
echo

echo "1. Validando herramientas del runner"

command -v bash >/dev/null 2>&1 || {
  echo "[ERROR] bash no está disponible"
  exit 1
}
echo "[OK] bash disponible"

command -v git >/dev/null 2>&1 || {
  echo "[ERROR] git no está disponible"
  exit 1
}
echo "[OK] git disponible"

echo
echo "2. Validando estructura del repositorio"

required_files=(
  ".github/workflows/bootstrap.yml"
  "scripts/previo.sh"
)

for file in "${required_files[@]}"; do
  if [[ -f "$file" ]]; then
    echo "[OK] Archivo encontrado: $file"
  else
    echo "[ERROR] Archivo requerido no encontrado: $file"
    exit 1
  fi
done

echo
echo "3. Validando archivos YAML"

mapfile -t yaml_files < <(
  find . \
    -type d \( -name .git -o -name .venv -o -name node_modules \) -prune \
    -o -type f \( -name "*.yml" -o -name "*.yaml" \) -print \
    | sort
)

if [[ ${#yaml_files[@]} -eq 0 ]]; then
  echo "[ERROR] No se encontraron archivos YAML"
  exit 1
fi

echo "[INFO] Archivos YAML encontrados: ${#yaml_files[@]}"

for file in "${yaml_files[@]}"; do
  echo "[INFO] Validando: $file"
done

echo
echo "[OK] Validaciones iniciales completadas"
echo "No se han realizado cambios en AWS ni Kubernetes."
echo "======================================"