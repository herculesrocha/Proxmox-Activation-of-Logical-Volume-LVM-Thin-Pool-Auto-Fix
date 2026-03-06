#!/bin/bash

#############################################################
# Proxmox LVM Thin Pool Auto Recovery
#
# Objetivo:
# Corrigir automaticamente erro de ativação do volume pve/data
# quando os metadados do thin pool permanecem ativos.
#
# Este script executa apenas se detectar problema no LVM.
#
# Autor: Hercules Rocha
#############################################################

# Verifica se o volume lógico pve/data está ativo
LV_STATE=$(lvs --noheadings -o lv_active /dev/pve/data 2>/dev/null | tr -d ' ')

# Caso não esteja ativo, inicia procedimento de correção
if [ "$LV_STATE" != "active" ]; then

    echo "Volume lógico pve/data não está ativo."
    echo "Iniciando tentativa de recuperação do Thin Pool..."

    #########################################################
    # Desativa o volume de dados do thin pool
    # Isso evita conflito com o volume principal
    #########################################################

    lvchange -an pve/data_tdata 2>/dev/null

    #########################################################
    # Desativa metadados do thin pool
    #########################################################

    lvchange -an pve/data_tmeta 2>/dev/null

    #########################################################
    # Reativa o volume principal do thin pool
    #########################################################

    lvchange -ay pve/data

    sleep 2

    #########################################################
    # Verifica novamente o estado do volume
    #########################################################

    NEW_STATE=$(lvs --noheadings -o lv_active /dev/pve/data | tr -d ' ')

    if [ "$NEW_STATE" = "active" ]; then
        echo "Recuperação realizada com sucesso."
    else
        echo "Falha ao ativar o volume pve/data."
    fi

else

    echo "Volume lógico pve/data já está ativo. Nenhuma ação necessária."

fi

exit 0
