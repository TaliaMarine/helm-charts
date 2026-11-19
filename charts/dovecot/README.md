# Dovecot chart

Dovecot 2.4 as an IMAPS server on Kubernetes: passwd-file users from a Secret, TLS from cert-manager, Maildir on a dynamically provisioned PVC.

Source of the app: https://github.com/dovecot

```bash
helm repo add talia-marine https://taliamarine.github.io/helm-charts
helm install dovecot talia-marine/dovecot \
  --set config.hostname=dovecot.example.com \
  --set service.externalDnsHostname=dovecot.example.com \
  --set certificate.enabled=true \
  --set certificate.issuerRef.name=letsencrypt-prod
```

## Notes

- **Single replica, `Recreate` strategy**: the mail volume is ReadWriteOnce.
- **Storage**: `persistence.size` (30Gi) and `persistence.storageClass` (empty = cluster default). The PVC carries `helm.sh/resource-policy: keep`; use a StorageClass with `reclaimPolicy: Retain` to also keep the volume when the PVC is deleted. `persistence.existingClaim` uses a claim you made.
- **Users**: Secret `users.secretName` (default `dovecot-users`), key `passwd`, lines `user:{SCHEME}hash`. Generate a hash with `docker run --rm -it dovecot/dovecot doveadm pw -s ARGON2ID`. The Secret is mounted as a directory (not `subPath`), so changes reach the pod after the kubelet sync and Dovecot rereads the file on change: no restart. The pod starts without the Secret (`users.optional`).
- **TLS**: `tls.secretName` must hold `tls.crt`/`tls.key`; `certificate.enabled` creates the cert-manager Certificate.
- **Image**: the `-root` tag listens on 993. The rootless image uses 31993 (`service.targetPortImaps`).
- `config.extra` appends raw Dovecot 2.4 settings to `99-k8s.conf`; changes roll the pod (config checksum).
