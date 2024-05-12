{{- define "zabbix.snmptraps" -}}
image: {{ .Values.snmptrapsImage.repository }}:{{ .Values.snmptrapsImage.tag }}
imagePullPolicy: {{ .Values.agent2Image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
volumeMounts:
  - name: snmptraps
    mountPath: {{ .Values.persistence.snmptraps.mountPath }}
  - name: snmpmibs
    mountPath: {{ .Values.persistence.snmpmibs.mountPath }}
ports:
  - containerPort: {{ .Values.service.snmptraps.ports.snmptraps.targetPort }}
    name: snmptraps
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
