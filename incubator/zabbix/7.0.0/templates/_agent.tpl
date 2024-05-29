{{- define "zabbix.agent2" -}}
image: {{ .Values.agent2Image.repository }}:{{ .Values.agent2Image.tag }}
imagePullPolicy: {{ .Values.agent2Image.pullPolicy }}
securityContext:
  runAsUser: 1997
  runAsGroup: 0
  readOnlyRootFilesystem: false
  runAsNonRoot: false
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
