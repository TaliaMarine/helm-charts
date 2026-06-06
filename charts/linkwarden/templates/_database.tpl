{{/*
  Define the fully qualified domain name (host) of the externally provisioned database.
  The database is no longer bundled, so the host must be provided explicitly.
*/}}
{{- define "linkwarden.db.fqdn" -}}
{{- required "You must set '.Values.linkwarden.database.host' to the FQDN of your externally provisioned PostgreSQL instance." .Values.linkwarden.database.host }}
{{- end -}}

{{/*
  Resolve the name of the existing Secret holding the database credentials
*/}}
{{- define "linkwarden.db.secretName" -}}
{{- required "You must set '.Values.linkwarden.database.existingSecret' with a Secret containing the keys username and password." .Values.linkwarden.database.existingSecret }}
{{- end -}}

{{/*
  The database port and name are non-sensitive and therefore sourced from the
  plain values. Only the credentials (username, password) come from the Secret.
*/}}
{{- define "linkwarden.db.port" -}}
{{- .Values.linkwarden.database.port | default 5432 | toString }}
{{- end -}}

{{- define "linkwarden.db.name" -}}
{{- .Values.linkwarden.database.name | default "linkwarden" }}
{{- end -}}
