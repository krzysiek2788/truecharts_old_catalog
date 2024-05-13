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
  initialDelaySeconds: {{ .Values.readinessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.readinessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.readinessprobe.periodSeconds }}
  failureThreshold: {{ .Values.readinessprobe.failureThreshold }}
livenessProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.livenessprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.livenessprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.livenessprobe.periodSeconds }}
  failureThreshold: {{ .Values.livenessprobe.failureThreshold }}
startupProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.startupprobe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.startupprobe.timeoutSeconds }}
  periodSeconds: {{ .Values.startupprobe.periodSeconds }}
  failureThreshold: {{ .Values.startupprobe.failureThreshold }}
{{- end -}}
