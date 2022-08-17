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
Image broker
*/}}
{{- define "optimizer.brokerImage" -}}
{{- if .Values.broker.image.repository -}}
image: {{ printf "%s/%s:%s" .Values.broker.image.repository .Values.broker.image.name .Values.broker.image.tag }}
{{- else -}}
image: {{ printf "%s:%s" .Values.broker.image.name .Values.broker.image.tag }}
{{- end -}}
{{- end -}}

{{/*
Image backend
*/}}
{{- define "optimizer.backendImage" -}}
{{- if .Values.backend.image.repository -}}
image: {{ printf "%s/%s:%s" .Values.backend.image.repository .Values.backend.image.name .Values.backend.image.tag }}
{{- else -}}
image: {{ printf "%s:%s" .Values.backend.image.name .Values.backend.image.tag }}
{{- end -}}
{{- end -}}

{{/*
Backend service name
*/}}
{{- define "optimizer.backend.serviceName" -}}
{{- if .Values.backend.defaultNameOverride -}}
{{ printf "%s-service" .Values.backend.defaultNameOverride }}
{{- else -}}
{{ printf "%s-service" .Values.backend.defaultName }}
{{- end -}}
{{- end -}}

{{/*
Broker service name
*/}}
{{- define "optimizer.broker.serviceName" -}}
{{- if .Values.broker.defaultNameOverride -}}
{{ printf "%s-service" .Values.broker.defaultNameOverride }}
{{- else -}}
{{ printf "%s-service" .Values.broker.defaultName }}
{{- end -}}
{{- end -}}

{{/*
Flower service name
*/}}
{{- define "optimizer.flower.serviceName" -}}
{{- if .Values.flower.defaultNameOverride -}}
{{ printf "%s-service" .Values.flower.defaultNameOverride }}
{{- else -}}
{{ printf "%s-service" .Values.flower.defaultName }}
{{- end -}}
{{- end -}}

{{/*
Server service name
*/}}
{{- define "optimizer.server.serviceName" -}}
{{- if .Values.server.defaultNameOverride -}}
{{ printf "%s-service" .Values.server.defaultNameOverride }}
{{- else -}}
{{ printf "%s-service" .Values.server.defaultName }}
{{- end -}}
{{- end -}}
