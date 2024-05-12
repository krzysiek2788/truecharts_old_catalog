{{- define "zabbix.javagateway" -}}
image: {{ .Values.javaGatewayImage.repository }}:{{ .Values.javaGatewayImage.tag }}
imagePullPolicy: {{ .Values.javaGatewayImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
volumeMounts:
  - name: javagatewaylibs
    mountPath: {{ .Values.persistence.javagatewaylibs.mountPath }}
envFrom:
  - configMapRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-javagateway-config'
ports:
  - containerPort: {{ .Values.service.javagateway.ports.javagateway.port }}
    name: javagateway
readinessProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.readinessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.readinessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.readinessProbe.periodSeconds }}
  failureThreshold: {{ .Values.service.readinessProbe.failureThreshold }}
livenessProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.livenessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.livenessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.livenessProbe.periodSeconds }}
  failureThreshold: {{ .Values.service.livenessProbe.failureThreshold }}
startupProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.startupProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.startupProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.startupProbe.periodSeconds }}
  failureThreshold: {{ .Values.service.startupProbe.failureThreshold }}
{{- end -}}
