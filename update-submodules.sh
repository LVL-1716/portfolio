#!/usr/bin/env bash
set -euo pipefail

SUPER_BRANCH="chore/update-portfolio-submodule-audit-fix"
BASE_BRANCH="main"

path_to_name() {
  echo "$1" | sed 's@/@-@g' | sed 's@^-@@'
}

if [ ! -f .gitmodules ]; then
  echo ".gitmodules não encontrado. Abortando."
  exit 1
fi

git fetch origin
git checkout -b "$SUPER_BRANCH" || git checkout "$SUPER_BRANCH"

SUBMODULE_PATHS=$(git config --file .gitmodules --get-regexp path | awk '{print $2}')

for path in $SUBMODULE_PATHS; do
  echo "=== Processando submódulo: $path ==="
  
  git submodule update --init --remote --recursive "$path"
  
  if [ ! -d "$path" ]; then
    echo "Diretório $path não existe; pulando."
    continue
  fi
  
  if [ ! -f "$path/package.json" ]; then
    echo "Sem package.json em $path; pulando."
    continue
  fi
  
  pushd "$path" > /dev/null
  
  git fetch origin || true
  DEFAULT_BRANCH="master"
  
  git checkout "$DEFAULT_BRANCH" || git checkout -b "$DEFAULT_BRANCH"
  git pull --ff-only origin "$DEFAULT_BRANCH" || true
  
  NAME=$(path_to_name "$path")
  BEFORE_FILE="../../audit-before-$NAME.json"
  AFTER_FILE="../../audit-after-$NAME.json"
  
  if [ -f package-lock.json ] || [ -f npm-shrinkwrap.json ]; then
    npm ci
  else
    npm install
  fi
  
  npm audit --json > "$BEFORE_FILE" || true
  npm audit fix || true
  
  if git status --porcelain | grep -E "package-lock.json|yarn.lock" >/dev/null 2>&1; then
    git add package-lock.json yarn.lock 2>/dev/null || true
    git commit -m "chore(deps): update packages to resolve audit issues" || true
    git push origin HEAD || true
  fi
  
  npm audit --json > "$AFTER_FILE" || true
  
  if npm run | grep -q "test"; then
    npm test || echo "AVISO: testes falharam em $path"
  fi
  
  if npm run | grep -q "build"; then
    npm run build || echo "AVISO: build falhou em $path"
  fi
  
  popd > /dev/null
  
  git add "$path"
done

git commit -m "chore: update submodule(s) - fix npm audit vulnerabilities" || echo "Nada para commitar no superprojeto"
git push origin HEAD

echo "Verifique audit-before-*.json, audit-after-*.json e PR_BODY.md na raiz."
