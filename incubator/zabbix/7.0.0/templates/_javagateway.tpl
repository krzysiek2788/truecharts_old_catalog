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
  initialDelaySeconds: {{ .Values.service.readinessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.readinessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.readinessprobe.periodSeconds }}
  failureThreshold: {{ .Values.service.readinessprobe.failureThreshold }}
livenessProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.livenessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.livenessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.livenessprobe.periodSeconds }}
  failureThreshold: {{ .Values.service.livenessprobe.failureThreshold }}
startupProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.service.startupprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.service.startupprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.service.startupprobe.periodSeconds }}
  failureThreshold: {{ .Values.service.startupprobe.failureThreshold }}
{{- end -}}
