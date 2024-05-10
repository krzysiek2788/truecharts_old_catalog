{{/* Define the secret */}}
{{- define "zabbix.secret" -}}

{{- $serverSecretName := printf "%s-server-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}
{{- $commonSecretName := printf "%s-common-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $commonSecretName }}
  labels:
    {{- include "tc.v1.common.lib.metadata.allLabels" . | nindent 4 }}
data:
  POSTGRES_PASSWORD: {{ .Values.cnpg.main.password | trimAll "\"" }}
{{- end }}
