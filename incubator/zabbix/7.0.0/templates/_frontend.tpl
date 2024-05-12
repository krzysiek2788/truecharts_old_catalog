{{- define "zabbix.frontend" -}}
image: {{ .Values.frontendImage.repository }}:{{ .Values.frontendImage.tag }}
imagePullPolicy: {{ .Values.frontendImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
envFrom:
  - secretRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-common-secret'
  - configMapRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-common-config'
  - configMapRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-frontend-config'
ports:
  - containerPort: {{ .Values.service.main.ports.main.targetPort }}
    name: main
readinessProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.zabbix.frontend.readinessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.zabbix.frontend.readinessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.zabbix.frontend.readinessProbe.periodSeconds }}
  failureThreshold: {{ .Values.zabbix.frontend.readinessProbe.failureThreshold }}
livenessProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.zabbix.livenessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.zabbix.livenessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.zabbix.livenessProbe.periodSeconds }}
  failureThreshold: {{ .Values.zabbix.livenessProbe.failureThreshold }}
startupProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.zabbix.startupProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.zabbix.startupProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.zabbix.startupProbe.periodSeconds }}
  failureThreshold: {{ .Values.zabbix.startupProbe.failureThreshold }}
{{- end -}}
