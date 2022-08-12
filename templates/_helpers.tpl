{{/*
Expand the name of the chart.
*/}}
{{- define "optimizer.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "optimizer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "optimizer.labels" -}}
helm.sh/chart: {{ include "optimizer.chart" . }}
{{ include "optimizer.selectorLabels" . }}
{{- if or .Chart.AppVersion .Values.defaultImage.tag }}
app.kubernetes.io/version: {{ .Values.defaultImage.tag | default .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.extraLabels }}
{{ toYaml .Values.extraLabels }}
{{- end }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "optimizer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "optimizer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Default image for server, flower and worker
*/}}
{{- define "optimizer.defaultImage" -}}
image: {{ printf "%s/%s:%s" .Values.defaultImage.repository .Values.defaultImage.name .Values.defaultImage.tag }}
{{- end -}}

{{/*
redis image with custom tag for broker
*/}}
{{- define "optimizer.brokerImage" -}}
{{- if .Values.broker.image.tag -}}
image: {{ printf "redis:%s" .Values.broker.image.tag }}
{{- else -}}
image: {{ "redis:latest" }}
{{- end -}}
{{- end -}}

{{/*
redis image with custom tag for backend
*/}}
{{- define "optimizer.backendImage" -}}
{{- if .Values.backend.image.tag -}}
image: {{ printf "redis:%s" .Values.backend.image.tag }}
{{- else -}}
image: {{ "redis:latest" }}
{{- end -}}
{{- end -}}
