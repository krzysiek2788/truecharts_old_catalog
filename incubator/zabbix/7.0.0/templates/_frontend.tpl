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
  initialDelaySeconds: {{ .Values.service.readinessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.readinessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.readinessprobe.periodSeconds }}
  failureThreshold: {{ .Values.service.readinessprobe.failureThreshold }}
livenessProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.livenessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.livenessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.livenessprobe.periodSeconds }}
  failureThreshold: {{ .Values.service.livenessprobe.failureThreshold }}
startupProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.startupprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.startupprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.startupprobe.periodSeconds }}
  failureThreshold: {{ .Values.service.startupprobe.failureThreshold }}
{{- end -}}
