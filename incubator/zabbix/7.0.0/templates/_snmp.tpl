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
