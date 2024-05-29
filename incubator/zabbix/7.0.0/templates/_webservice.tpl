{{- define "zabbix.webservice" -}}
image: {{ .Values.webServiceImage.repository }}:{{ .Values.webServiceImage.tag }}
imagePullPolicy: {{ .Values.webServiceImage.pullPolicy }}
securityContext:
  runAsUser: 1997
  runAsGroup: 0
  readOnlyRootFilesystem: false
  runAsNonRoot: false
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
  initialDelaySeconds: {{ .Values.readinessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.readinessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.readinessprobe.periodSeconds }}
  failureThreshold: {{ .Values.readinessprobe.failureThreshold }}
livenessProbe:
  httpGet:
    path: /report
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.livenessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.livenessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.livenessprobe.periodSeconds }}
  failureThreshold: {{ .Values.livenessprobe.failureThreshold }}
startupProbe:
  httpGet:
    path: /report
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.startupprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.startupprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.startupprobe.periodSeconds }}
  failureThreshold: {{ .Values.startupprobe.failureThreshold }}
{{- end -}}
