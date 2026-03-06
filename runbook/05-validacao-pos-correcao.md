# Validação

Verificar estado do LVM:

```
lvs
```

Verificar logs:

```
journalctl -u proxmox-lvm-fix
```

Reiniciar servidor para validar automação:

```
reboot
```

Confirmar que:

* storage local-lvm está ativo
* VMs iniciam automaticamente
