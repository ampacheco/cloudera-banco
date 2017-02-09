#!/bin/bash
alias azure=azure.cmd

#
# Información requerida se encuentra en está página.
# https://docs.microsoft.com/en-us/azure/virtual-machines/virtual-machines-linux-encrypt-disks
#

echo "Key Vault MAnagement to Encrypt VMs"
azure login
azure config mode arm

azure provider register Microsoft.KeyVault

azure group create myResourceGroup --location WestUS

azure keyvault create --vault-name myKeyVault --resource-group myResourceGroup \
  --location WestUS

azure keyvault key create --vault-name myKeyVault --key-name myKey \
  --destination software

azure keyvault set-policy --vault-name myKeyVault --resource-group myResourceGroup \
  --enabled-for-disk-encryption true
