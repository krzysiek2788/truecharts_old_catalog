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
  initialDelaySeconds: {{ .Values.service.readinessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.readinessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.readinessProbe.periodSeconds }}
  failureThreshold: {{ .Values.service.readinessProbe.failureThreshold }}
livenessProbe:
  httpGet:
    path: /report
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.livenessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.livenessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.livenessProbe.periodSeconds }}
  failureThreshold: {{ .Values.service.livenessProbe.failureThreshold }}
startupProbe:
  httpGet:
    path: /report
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.startupProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.startupProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.startupProbe.periodSeconds }}
  failureThreshold: {{ .Values.service.startupProbe.failureThreshold }}
{{- end -}}
