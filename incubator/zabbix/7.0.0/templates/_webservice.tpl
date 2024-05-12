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
  initialDelaySeconds: {{ .Values.service.readinessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.readinessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.readinessprobe.periodSeconds }}
  failureThreshold: {{ .Values.service.readinessprobe.failureThreshold }}
livenessProbe:
  httpGet:
    path: /report
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.livenessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.livenessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.livenessprobe.periodSeconds }}
  failureThreshold: {{ .Values.service.livenessprobe.failureThreshold }}
startupProbe:
  httpGet:
    path: /report
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.startupprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.startupprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.startupprobe.periodSeconds }}
  failureThreshold: {{ .Values.service.startupprobe.failureThreshold }}
{{- end -}}
