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
  initialDelaySeconds: {{ .Values.zabbix.readinessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.zabbix.readinessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.zabbix.readinessProbe.periodSeconds }}
  failureThreshold: {{ .Values.zabbix.readinessProbe.failureThreshold }}
livenessProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.zabbix.livenessProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.zabbix.livenessProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.zabbix.livenessProbe.periodSeconds }}
  failureThreshold: {{ .Values.zabbix.livenessProbe.failureThreshold }}
startupProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.zabbix.startupProbe.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.zabbix.startupProbe.timeoutSeconds }}
  periodSeconds: {{ .Values.zabbix.startupProbe.periodSeconds }}
  failureThreshold: {{ .Values.zabbix.startupProbe.failureThreshold }}
{{- end -}}
