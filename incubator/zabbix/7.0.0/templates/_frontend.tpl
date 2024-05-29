{{- define "zabbix.frontend" -}}
image: {{ .Values.frontendImage.repository }}:{{ .Values.frontendImage.tag }}
imagePullPolicy: {{ .Values.frontendImage.pullPolicy }}
securityContext:
  runAsUser: 1997
  runAsGroup: 0
  readOnlyRootFilesystem: false
  runAsNonRoot: false
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
  initialDelaySeconds: {{ .Values.readinessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.readinessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.readinessprobe.periodSeconds }}
  failureThreshold: {{ .Values.readinessprobe.failureThreshold }}
livenessProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.livenessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.livenessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.livenessprobe.periodSeconds }}
  failureThreshold: {{ .Values.livenessprobe.failureThreshold }}
startupProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.startupprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.startupprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.startupprobe.periodSeconds }}
  failureThreshold: {{ .Values.startupprobe.failureThreshold }}
{{- end -}}
