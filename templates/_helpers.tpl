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
common labels
*/}}
{{- define "optimizer.commonLabels" -}}
app.kubernetes.io/name: {{ include "optimizer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
labels
*/}}
{{- define "optimizer.labels" -}}
helm.sh/chart: {{ include "optimizer.chart" . }}
{{ include "optimizer.commonLabels" . }}
{{- if or .Chart.AppVersion .Values.defaultImage.tag }}
app.kubernetes.io/version: {{ .Values.defaultImage.tag | default .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.extraLabels }}
{{ toYaml .Values.extraLabels }}
{{- end }}
{{- end -}}

{{/*
Selector labels for server
*/}}
{{- define "optimizer.server.selectorLabels" -}}
app: {{ .Values.server.defaultNameOverride | default .Values.server.defaultName }}
{{ include "optimizer.commonLabels" . }}
{{- end -}}

{{/*
Selector labels for worker
*/}}
{{- define "optimizer.worker.selectorLabels" -}}
app: {{ .Values.worker.defaultNameOverride | default .Values.worker.defaultName }}
{{ include "optimizer.commonLabels" . }}
{{- end -}}

{{/*
Selector labels for flower
*/}}
{{- define "optimizer.flower.selectorLabels" -}}
app: {{ .Values.flower.defaultNameOverride | default .Values.flower.defaultName }}
{{ include "optimizer.commonLabels" . }}
{{- end -}}

{{/*
Selector labels for broker
*/}}
{{- define "optimizer.broker.selectorLabels" -}}
app: {{ .Values.broker.defaultNameOverride | default .Values.broker.defaultName }}
{{ include "optimizer.commonLabels" . }}
{{- end -}}

{{/*
Selector labels for backend
*/}}
{{- define "optimizer.backend.selectorLabels" -}}
app: {{ .Values.backend.defaultNameOverride | default .Values.backend.defaultName }}
{{ include "optimizer.commonLabels" . }}
{{- end -}}

{{/*
Default image for server, flower and worker
*/}}
{{- define "optimizer.defaultImage" -}}
image: {{ printf "%s/%s:%s" .Values.defaultImage.repository .Values.defaultImage.name .Values.defaultImage.tag }}
{{- end -}}

{{/*
Default image broker
*/}}
{{- define "optimizer.brokerImage" -}}
{{- if .Values.broker.defaultImage.repository -}}
image: {{ printf "%s/%s:%s" .Values.broker.defaultImage.repository .Values.broker.defaultImage.name .Values.broker.defaultImage.tag }}
{{- else -}}
image: {{ printf "%s:%s" .Values.broker.defaultImage.name .Values.broker.defaultImage.tag }}
{{- end -}}
{{- end -}}

{{/*
Default image backend
*/}}
{{- define "optimizer.backendImage" -}}
{{- if .Values.backend.defaultImage.repository -}}
image: {{ printf "%s/%s:%s" .Values.backend.defaultImage.repository .Values.backend.defaultImage.name .Values.backend.defaultImage.tag }}
{{- else -}}
image: {{ printf "%s:%s" .Values.backend.defaultImage.name .Values.backend.defaultImage.tag }}
{{- end -}}
{{- end -}}
