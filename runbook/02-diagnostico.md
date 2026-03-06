# Diagnóstico

Verificar estado dos volumes lógicos:

```
lvs -a
```

Verificar dispositivos:

```
lsblk
```

Verificar estado de ativação:

```
lvs -o +lv_active
```

Sintoma típico:

```
pve/data_tmeta active
pve/data inactive
```
