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
  initialDelaySeconds: {{ .Values.service.readinessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.readinessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.readinessProbe.periodSeconds }}
  failureThreshold: {{ .Values.service.readinessProbe.failureThreshold }}
livenessProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.livenessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.livenessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.livenessProbe.periodSeconds }}
  failureThreshold: {{ .Values.service.livenessProbe.failureThreshold }}
startupProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.startupProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.startupProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.startupProbe.periodSeconds }}
  failureThreshold: {{ .Values.service.startupProbe.failureThreshold }}
{{- end -}}
