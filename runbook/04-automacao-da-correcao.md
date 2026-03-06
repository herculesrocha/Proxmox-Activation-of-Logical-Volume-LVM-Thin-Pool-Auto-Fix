# Automação da Correção

Criar script:

```
/usr/local/sbin/proxmox-lvm-fix.sh
```

Permissão:

```
chmod +x /usr/local/sbin/proxmox-lvm-fix.sh
```

Criar serviço systemd:

```
/etc/systemd/system/proxmox-lvm-fix.service
```

Conteúdo:

```
[Unit]
Description=Proxmox LVM Auto Fix
DefaultDependencies=no
After=lvm2-monitor.service
Before=pve-guests.service

[Service]
Type=oneshot
ExecStart=/usr/local/sbin/proxmox-lvm-fix.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

Ativar:

```
systemctl daemon-reload
systemctl enable proxmox-lvm-fix.service
```
