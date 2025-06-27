#!/bin/bash

# Garante que não haja nenhum .env local para o Prisma carregar
rm -f .env

# Deploy das migrations PostgreSQL
if [[ "$DATABASE_PROVIDER" == "postgresql" ]]; then
  echo "Deploying migrations for postgresql"
  echo "Database URL: $DATABASE_URL"
  # Usa o Prisma CLI diretamente, sem carregar .env.local
  npx prisma migrate deploy --schema prisma/postgresql-schema.prisma
  STATUS=$?
  if [ $STATUS -ne 0 ]; then
    echo "Error: prisma migrate deploy falhou com status $STATUS"
    exit $STATUS
  fi
  echo "Migrations applied successfully"
  exit 0
else
  echo "Error: Database provider \$DATABASE_PROVIDER invalid."
  exit 1
fi
