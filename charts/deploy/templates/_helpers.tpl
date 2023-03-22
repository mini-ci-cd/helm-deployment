{{/*
Expand the name of the chart.
*/}}
{{- define "helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helm.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- regexReplaceAll "_" (.Values.fullnameOverride | trunc 63 | trimSuffix "-") "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- regexReplaceAll "_" (.Release.Name | trunc 63 | trimSuffix "-" ) "-" }}
{{- else }}
{{- regexReplaceAll "_" (printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-") "-"  }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "helm.labels" -}}
helm.sh/chart: {{ include "helm.chart" . }}
{{ include "helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "helm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "helm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
{{/*
Expand the name of the chart.
*/}}
{{- define "jobs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jobs.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jobs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "jobs.labels" -}}
helm.sh/chart: {{ include "jobs.chart" . }}
{{ include "jobs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "jobs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jobs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "jobs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "jobs.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "chart.name" -}}
{{- printf "%s-%s" .Name .Version | replace "+" "_" }}
{{- end }}

{{- define "metadata.name" -}}
{{- printf "%s-%s" .root.Release.Name .job.name }}
{{- end }}

{{- define "label.app" -}}
{{- printf "%s-%s" .release.Name .job.name }}
{{- end }}

{{- define "job.annotations.tpl" -}}
{{- with .annotations }}
  annotations:
  {{- toYaml . | nindent 4 }}
{{- end }}
{{- end }}

{{- define "job.image.name" -}}
{{- printf "%s:%s" .image.repository .image.tag }}
{{- end }}

{{- define "job.image.imagePullSecrets.tpl" -}}
{{- with .image }}
{{- with .imagePullSecrets }}
  imagePullSecrets:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}

{{- define "job.env.tpl" -}}
{{- with .env }}
  env:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{- define "job.envFrom.tpl" -}}
{{- with .envFrom }}
  envFrom:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{- define "job.command.tpl" -}}
{{- with .command }}
  command: 
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{- define "job.args.tpl" -}}
{{- with .args }}
  args:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{- define "job.resources.tpl" -}}
{{- with .resources }}
  resources:
  {{- toYaml . | nindent 4 }}
{{- end }}
{{- end }}

{{- define "job.volumemounts.tpl" -}}
{{- with .volumeMounts }}
  volumeMounts:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{- define "job.nodeSelector.tpl" -}}
{{- with .nodeSelector }}
  nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{- define "job.affinity.tpl" -}}
{{- with .affinity }}
  affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{- define "job.tolerations.tpl" -}}
{{- with .tolerations }}
  tolerations:
  {{- toYaml . | nindent 12 }}
{{- end }}
{{- end }}

{{- define "job.volumes.tpl" -}}
{{- with .volumes }}
  volumes:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{- define "job.isCron.tpl" -}}
{{- if .values.cronJob.enabled -}}
cron: {{ .job.name }}
type: "cronjob"
{{- end }}
{{- end }}

{{- define "job.tpl" -}}
{{- $release := .release }}
{{- $values := .values }}
{{- $job := .job }}
spec:
      template:
        metadata:
          labels:
            app: {{ $release.Name }}
            version: {{ $values.version | quote }}
            {{- include "job.isCron.tpl" (dict "values" $values "job" $job) | nindent 12}}
          {{- include "job.annotations.tpl" $job | indent 8}}
        spec:
          {{- include "job.image.imagePullSecrets.tpl" $job | indent 8 }}
          serviceAccountName: {{ $values.serviceAccount.name }}
          containers:
          - image: "{{- include "job.image.name" $job }}"
            imagePullPolicy: {{ $job.image.imagePullPolicy }}
            name: {{ $job.name }}
            {{- include "job.env.tpl" $job | indent 10 }}
            {{- include "job.envFrom.tpl" $job | indent 10}}
            {{- include "job.command.tpl" $job | indent 10}}
            {{- include "job.args.tpl" $job | indent 10}}
            {{- include "job.resources.tpl" $job | indent 10}}
            {{- include "job.volumemounts.tpl" $job | indent 10}}
            {{- include "job.nodeSelector.tpl" $job | indent 10}}
            {{- include "job.affinity.tpl" $job | indent 10}}
            {{- include "job.tolerations.tpl" $job | indent 10}}
          restartPolicy: {{ $job.restartPolicy }}
          {{- include "job.volumes.tpl" $job | indent 8}}
          {{- include "job.tolerations.tpl" $job | indent 8}}
      backoffLimit: {{ $job.backoffLimit }}
{{- end }}
