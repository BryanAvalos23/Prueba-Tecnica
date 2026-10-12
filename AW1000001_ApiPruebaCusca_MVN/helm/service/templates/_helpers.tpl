{{/*
Nombre del chart.
*/}}
{{- define "demo-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Nombre completo de la aplicacion.
*/}}
{{- define "demo-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Etiquetas comunes.
*/}}
{{- define "demo-service.labels" -}}
app.kubernetes.io/name: {{ include "demo-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{/*
Etiquetas usadas por los selectores.
*/}}
{{- define "demo-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "demo-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}