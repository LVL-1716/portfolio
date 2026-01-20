#!/usr/bin/env bash
set -euo pipefail

# Script para aplicar a alteração do workflow CI.
# Tenta dar push direto para master; se falhar, cria uma branch,
# faz push e abre um PR usando gh (GitHub CLI).
#
# Requisitos:
# - git configurado e autenticado
# - gh (GitHub CLI) instalado e autenticado para criar PRs
#
# Execute na raiz do repositório local.

REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

# Atualiza refs remotas
git fetch origin

# Trabalha sobre master localmente
git checkout master
git pull origin master

OLD_HEAD=$(git rev-parse HEAD)

# Substitui o arquivo do workflow com o conteúdo desejado
cat > .github/workflows/main.yml <<'YAML'
name: CI

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  ci:
    name: CI
    runs-on: ubuntu-latest

    steps:
      - name: Check out repository
        uses: actions/checkout@v4

      - name: Use Node.js 18
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run lint
        run: npm run lint

      - name: Run tests
        run: npm run test

      - name: Build
        run: npm run build
YAML

# Stage the change
git add .github/workflows/main.yml

# Se nada mudou, sair
if git diff --staged --quiet --exit-code; then
  echo "Nenhuma alteração detectada; nada para commitar."
  exit 0
fi

# Commit local
git commit -m "fix: adicionar suporte para deploy na branch master"

# Tenta dar push direto para master
if git push origin master; then
  echo "Push para master efetuado com sucesso."
  exit 0
fi

# Se o push falhar, cria branch, push e abre PR
echo "Push para master falhou — criando branch e abrindo PR..."

BRANCH="fix/add-deploy-master-$(date +%Y%m%d%H%M%S)"
git branch "$BRANCH"
git push -u origin "$BRANCH"

# Verifica se gh está disponível
if ! command -v gh >/dev/null 2>&1; then
  echo "gh (GitHub CLI) não encontrado. Por favor instale e autentique (gh auth login) e rode:"
  echo "  gh pr create --title \"fix: adicionar suporte para deploy na branch master\" --body \"Adiciona a branch master aos gatilhos (push e pull_request) no workflow CI.\" --base master --head $BRANCH"
  exit 0
fi

# Cria PR
gh pr create --title "fix: adicionar suporte para deploy na branch master" \
  --body $'Adiciona a branch `master` aos gatilhos (push e pull_request) no workflow CI.\n\nCommit: fix: adicionar suporte para deploy na branch master' \
  --base master --head "$BRANCH"

# Restaura master local ao estado anterior (remove o commit local de master)
git checkout master
git reset --hard "$OLD_HEAD"

echo "Branch '$BRANCH' criada e PR aberto. Seu master local foi restaurado ao estado anterior."
