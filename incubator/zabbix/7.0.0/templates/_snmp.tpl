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
