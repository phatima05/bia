#!/bin/bash

# Script para adicionar permissões RDS à role role-acesso-ssm

echo "Adicionando permissões RDS à role role-acesso-ssm..."

aws iam attach-role-policy \
  --role-name role-acesso-ssm \
  --policy-arn arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess

if [ $? -eq 0 ]; then
    echo "✅ Permissões RDS adicionadas com sucesso!"
    echo "Aguarde alguns segundos para as permissões serem propagadas..."
    sleep 10
    echo "Testando acesso ao RDS..."
    aws rds describe-db-instances --query 'DBInstances[?DBInstanceStatus==`stopped`].[DBInstanceIdentifier,DBInstanceStatus]' --output table
else
    echo "❌ Erro ao adicionar permissões. Verifique se você tem permissões administrativas."
fi
