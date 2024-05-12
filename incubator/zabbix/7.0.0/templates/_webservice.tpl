{{- define "zabbix.webservice" -}}
image: {{ .Values.webServiceImage.repository }}:{{ .Values.webServiceImage.tag }}
imagePullPolicy: {{ .Values.webServiceImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
envFrom:
  - configMapRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-webservice-config'
ports:
  - containerPort: {{ .Values.service.webservice.ports.webservice.port }}
    name: webservice
readinessProbe:
  httpGet:
    path: /report
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.zabbix.readinessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.zabbix.readinessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.zabbix.readinessProbe.periodSeconds }}
  failureThreshold: {{ .Values.zabbix.readinessProbe.failureThreshold }}
livenessProbe:
  httpGet:
    path: /report
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.zabbix.livenessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.zabbix.livenessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.zabbix.livenessProbe.periodSeconds }}
  failureThreshold: {{ .Values.zabbix.livenessProbe.failureThreshold }}
startupProbe:
  httpGet:
    path: /report
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.zabbix.startupProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.zabbix.startupProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.zabbix.startupProbe.periodSeconds }}
  failureThreshold: {{ .Values.zabbix.startupProbe.failureThreshold }}
{{- end -}}
