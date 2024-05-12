{{- define "zabbix.agent2" -}}
image: {{ .Values.agent2Image.repository }}:{{ .Values.agent2Image.tag }}
imagePullPolicy: {{ .Values.agent2Image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
  capabilities:
    add:
      - SYS_TIME
volumeMounts:
  - name: hostsys
    mountPath: {{ .Values.persistence.hostsys.mountPath }}
  - name: hostproc
    mountPath: {{ .Values.persistence.hostproc.mountPath }}
  - name: agentconf
    mountPath: {{ .Values.persistence.agentconf.mountPath }}
  - name: agentenc
    mountPath: {{ .Values.persistence.agentenc.mountPath }}
  - name: agentbuffer
    mountPath: {{ .Values.persistence.agentbuffer.mountPath }}
envFrom:
  - configMapRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-agent-config'
ports:
  - containerPort: {{ .Values.service.agent.ports.agent.port }}
    name: agent
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
  initialDelaySeconds: {{ Values.zabbix.startupProbe.initialDelaySeconds }}
  timeoutSeconds: {{ Values.zabbix.startupProbe.timeoutSeconds }}
  periodSeconds: {{ Values.zabbix.startupProbe.periodSeconds }}
  failureThreshold: {{ Values.zabbix.startupProbe.failureThreshold }}
{{- end -}}
