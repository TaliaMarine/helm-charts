{{/*
  Resolve the name of the existing Secret holding the database connection URL.
  The database is provisioned externally and the full PostgreSQL connection URL
  is read directly from this Secret (see '.Values.linkwarden.database.urlKey').
*/}}
{{- define "linkwarden.db.secretName" -}}
{{- required "You must set '.Values.linkwarden.database.existingSecret' with a Secret containing the PostgreSQL connection URL." .Values.linkwarden.database.existingSecret }}
{{- end -}}
