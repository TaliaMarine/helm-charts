{{/*
  Check whether a domain is given if the Ingress is enabled
*/}}
{{- define "linkwarden.checks.domain" -}}
  {{- if .Values.ingress.enabled }}
  {{- if not .Values.linkwarden.domain }}
  {{- fail "You did not provide domain name for the installation but enabled the Ingress. Please set '.Values.linkwarden.domain' also." }}
  {{- end }}
  {{- end }}
{{- end -}}

{{/*
  Check whether the given SSO providers are allowed - if any are actually provided
*/}}
{{- define "linkwarden.checks.providers" -}}
{{- $allowedList := include "linkwarden.auth.providers.withIssuers" . | fromJsonArray }}
{{- $authSSOLength := len .Values.linkwarden.auth.sso }}
  {{- if (gt $authSSOLength 0) }}
  {{- range $_, $v := .Values.linkwarden.auth.sso }}
  {{- if not (has $v.provider $allowedList) }}
  {{ fail "Your given SSO provider is not allowed. Please see 'values.yaml' comments for a list of allowed providers." }}
  {{- end }}
  {{- end }}
  {{- end }}
{{- end -}}

{{/*
  Ensure all credentials are sourced from existing Kubernetes Secrets.
  Plain text credentials are not supported for security reasons.
*/}}
{{- define "linkwarden.checks.credentials" -}}
{{- if not .Values.linkwarden.nextAuthSecret.existingSecret.name }}
{{- fail "You must provide '.Values.linkwarden.nextAuthSecret.existingSecret.name' - the NextAuth secret can only be supplied through an existing Kubernetes Secret." }}
{{- end }}
{{- if not .Values.linkwarden.database.existingSecret }}
{{- fail "You must provide '.Values.linkwarden.database.existingSecret' containing the keys username and password - database credentials can only be supplied through an existing Kubernetes Secret." }}
{{- end }}
{{- if not .Values.linkwarden.database.host }}
{{- fail "You must provide '.Values.linkwarden.database.host' with the FQDN of your externally provisioned PostgreSQL instance." }}
{{- end }}
{{- if eq .Values.linkwarden.data.storageType "s3" }}
{{- if not .Values.linkwarden.data.s3.existingSecret }}
{{- fail "You enabled S3 storage but did not set '.Values.linkwarden.data.s3.existingSecret' containing the keys accessKey and secretKey - S3 credentials can only be supplied through an existing Kubernetes Secret." }}
{{- end }}
{{- end }}
{{- range $_, $v := .Values.linkwarden.auth.sso }}
{{- if not $v.existingSecret }}
{{- fail (printf "SSO provider '%s' is missing 'existingSecret' - OAuth credentials can only be supplied through an existing Kubernetes Secret containing the keys clientId and clientSecret." $v.provider) }}
{{- end }}
{{- end }}
{{- end -}}

