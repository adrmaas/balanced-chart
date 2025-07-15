# standard name that all resources will be named after
{{- define "balanced.helpers.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

# standard labels: set of common labels applied to all chart resources
{{- define "balanced.helpers.labels" -}}
app.kubernetes.io/name: {{ include "balanced.helpers.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ $.Chart.AppVersion }}
github.com/adrmaas/balanced-chart: {{ $.Chart.Version }}
helm.sh/chart: {{ $.Chart.Name }}-{{ $.Chart.Version | replace "+" "_" }}
{{- if .Values.labels }}
{{ toYaml .Values.labels }}
{{- end }}
{{- end }}

# standard hostnaming: auto generated hostnames
# internal
{{- define "balanced.helpers.internalHost" -}}
{{- if .Values.internalHostOverride }}
{{- $internalHost := default .Values.internalHostOverride }}
{{- else -}}
{{- if not (.Values.domain) }}
{{- fail "the value domain is not defined" }}
{{- else }}
{{- printf "%s-%s.%s" (include "balanced.helpers.name" .) "internal" (.Values.domain) -}}
{{- end }}
{{- end }}
{{- end }}
# external
{{- define "balanced.helpers.externalHost" -}}
{{- if .Values.externalHostOverride }}
{{- $externalHost := default .Values.externalHostOverride }}
{{- else -}}
{{- if not (has .Values.domain) }}
{{- fail "the value domain is not defined" }}
{{- else }}
{{- printf "%s.%s" (include "balanced.helpers.name" .) (.Values.domain) -}}
{{- end }}
{{- end }}
{{- end }}