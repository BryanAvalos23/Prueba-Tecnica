# Configuración de autenticación Kubernetes en Vault

## Objetivo

Configurar el método de autenticación Kubernetes de Vault para permitir que Vault Secrets Operator (VSO) obtenga acceso únicamente al secreto autorizado.

## Prerrequisitos

* Vault desplegado y desbloqueado.
* Método de autenticación Kubernetes habilitado en Vault.
* Dirección de la API del clúster de Kubernetes de Deployment.
* CA del clúster para validar los tokens.
* ServiceAccount `jenkins-vault-auth` creada en el namespace `prueba-cusca`.
* Política `jenkins-vso.hcl` creada.
* Rol `jenkins-vso` vinculado a la ServiceAccount y a la política.

## Política

La política `policies/jenkins-vso.hcl` concede únicamente lectura sobre `secret/data/test-app`.

## Validación posterior al despliegue

1. Habilitar y configurar el método de autenticación Kubernetes.
2. Crear el rol `jenkins-vso`.
3. Verificar la autenticación de VSO.
4. Confirmar la sincronización del secreto Kubernetes.
5. Validar que la identidad no pueda leer otros secretos.

## Configuración de Kubernetes Auth después del despliegue

Ejecutar estos pasos únicamente cuando Vault esté desplegado, desbloqueado y accesible.

### 1. Verificar la identidad del servidor Vault

Confirmar que el pod utiliza la ServiceAccount `vault` en el namespace `prueba-cusca` y que tiene montado el token de ServiceAccount.

### 2. Verificar los permisos de TokenReview

Aplicar `k8s/rbac/vault-token-reviewer.yml` al clúster de Deployment y comprobar que el vínculo referencia `system:auth-delegator` y la ServiceAccount `vault`.

### 3. Habilitar Kubernetes Auth

Desde una sesión autenticada de Vault, habilitar el método `kubernetes` si aún no está habilitado.

### 4. Configurar la API de Kubernetes

Configurar `auth/kubernetes/config` con la dirección de la API del clúster de Deployment. Cuando Vault use su token local como revisor, evitar guardar un JWT de larga duración en archivos del repositorio.

### 5. Crear el rol de VSO

Crear el rol `jenkins-vso`, restringido a la ServiceAccount `jenkins-vault-auth` y al namespace `prueba-cusca`, y asociarlo a la política `jenkins-vso`.

### 6. Validar

Comprobar la autenticación de VSO y la sincronización del secreto `test-app` en el Kubernetes Secret `jenkins-vault-secret`.

