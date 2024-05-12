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
