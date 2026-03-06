# Correção Manual

Desativar thin pool:

```
lvchange -an pve/data_tdata
lvchange -an pve/data_tmeta
```

Ativar volume principal:

```
lvchange -ay pve/data
```

Validar:

```
lvs
```
