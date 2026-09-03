{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Sanitize commit from chart version
*/}}
{{- define "commit" -}}
{{- .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Sanitize branch from chart version
*/}}
{{- define "branch" -}}
{{- .Chart.Version | replace "+" "_" | replace "#" "-" | replace "/" "-" | replace "." "-" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "labels.selector" -}}
app.kubernetes.io/name: {{ include "name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "labels.common" -}}
{{ include "labels.selector" . }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
application.giantswarm.io/branch: {{ include "branch" . | quote }}
application.giantswarm.io/commit: {{ include "commit" . | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "io.giantswarm.application.team" | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
{{- end -}}

{{/*
Pod scheduling constraints: renders the `nodeSelector` and `tolerations` fields,
merging the `architecture` shorthand into the explicit values for both.

`architecture` exists because the two halves are coupled and fail in different,
non-obvious ways. Giant Swarm arm64 node pools carry a
`kubernetes.io/arch=arm64:NoSchedule` taint, so a pod needs the node selector
*and* the matching toleration: with only the selector it stays Pending, with
only the toleration it may be scheduled onto any pool. One value sets both.

A `nodeSelector` that sets `kubernetes.io/arch` to something other than
`architecture` is a contradiction rather than a preference to arbitrate, so it
fails the render instead of silently discarding one of the two. Any other
`nodeSelector` entry is kept.
Emits nothing when unset, so rendered output is unchanged for existing users.
*/}}
{{- define "podScheduling" -}}
{{- $nodeSelector := deepCopy (.Values.nodeSelector | default dict) -}}
{{- $tolerations := .Values.tolerations | default list -}}
{{- with .Values.architecture -}}
{{- if and (hasKey $nodeSelector "kubernetes.io/arch") (ne (index $nodeSelector "kubernetes.io/arch") .) -}}
{{- fail (printf "architecture=%s conflicts with nodeSelector.%q=%s; set only one" . "kubernetes.io/arch" (index $nodeSelector "kubernetes.io/arch")) -}}
{{- end -}}
{{- $nodeSelector = merge (dict "kubernetes.io/arch" .) $nodeSelector -}}
{{- if eq . "arm64" -}}
{{- $tolerations = concat $tolerations (list (dict "key" "kubernetes.io/arch" "operator" "Equal" "value" "arm64" "effect" "NoSchedule")) | uniq -}}
{{- end -}}
{{- end -}}
{{- $scheduling := dict -}}
{{- if $nodeSelector -}}{{- $_ := set $scheduling "nodeSelector" $nodeSelector -}}{{- end -}}
{{- if $tolerations -}}{{- $_ := set $scheduling "tolerations" $tolerations -}}{{- end -}}
{{- with $scheduling }}{{ toYaml . }}{{ end -}}
{{- end -}}
