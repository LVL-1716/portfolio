#!/usr/bin/env bash

# Script para coletar informações de revisão da PR

set -euo pipefail

BRANCH="chore/update-portfolio-submodule-audit-fix"
BASE_BRANCH="master"
OUTPUT_FILE="PR_REVIEW_INFO.md"

echo "🔍 Coletando informações de revisão da PR..."
echo ""

# Verificar se estamos na branch correta
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "$BRANCH" ]; then
  echo "⚠️  Você não está na branch $BRANCH"
  echo "Branch atual: $CURRENT_BRANCH"
  echo "Mudando para a branch correta..."
  git checkout "$BRANCH"
fi

# Criar arquivo de saída
cat > "$OUTPUT_FILE" << 'EOF'
# 📋 Informações de Revisão da PR

## 🔗 Referências
EOF

echo "Branch: $BRANCH" >> "$OUTPUT_FILE"
echo "Base Branch: $BASE_BRANCH" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Commits
echo "## 📝 Commits" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "\`\`\`" >> "$OUTPUT_FILE"
git log "$BASE_BRANCH..$BRANCH" --oneline >> "$OUTPUT_FILE"
echo "\`\`\`" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Arquivos modificados
echo "## 📂 Arquivos Modificados" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "\`\`\`" >> "$OUTPUT_FILE"
git diff --name-status "$BASE_BRANCH..$BRANCH" >> "$OUTPUT_FILE"
echo "\`\`\`" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Estatísticas
echo "## 📊 Estatísticas" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "\`\`\`" >> "$OUTPUT_FILE"
git diff --stat "$BASE_BRANCH..$BRANCH" >> "$OUTPUT_FILE"
echo "\`\`\`" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Resumo de mudanças
echo "## 📋 Resumo das Mudanças" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

if git diff "$BASE_BRANCH..$BRANCH" -- "PR_BODY.md" > /dev/null 2>&1; then
  echo "### PR_BODY.md" >> "$OUTPUT_FILE"
  echo "✅ Descrição da PR atualizada" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
fi

if git diff "$BASE_BRANCH..$BRANCH" -- "audit-before-portfolio.json" > /dev/null 2>&1; then
  echo "### audit-before-portfolio.json" >> "$OUTPUT_FILE"
  echo "✅ Relatório de auditoria (antes) adicionado" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
fi

if git diff "$BASE_BRANCH..$BRANCH" -- "audit-after-portfolio.json" > /dev/null 2>&1; then
  echo "### audit-after-portfolio.json" >> "$OUTPUT_FILE"
  echo "✅ Relatório de auditoria (depois) adicionado" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
fi

if git diff "$BASE_BRANCH..$BRANCH" -- "update-submodules.sh" > /dev/null 2>&1; then
  echo "### update-submodules.sh" >> "$OUTPUT_FILE"
  echo "✅ Script de atualização (Bash) adicionado" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
fi

if git diff "$BASE_BRANCH..$BRANCH" -- "update-submodules.ps1" > /dev/null 2>&1; then
  echo "### update-submodules.ps1" >> "$OUTPUT_FILE"
  echo "✅ Script de atualização (PowerShell) adicionado" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
fi

# Diff detalhado
echo "## 🔄 Diff Detalhado" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "\`\`\`diff" >> "$OUTPUT_FILE"
git diff "$BASE_BRANCH..$BRANCH" | head -200 >> "$OUTPUT_FILE"
echo "..." >> "$OUTPUT_FILE"
echo "\`\`\`" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

echo "✅ Informações coletadas em: $OUTPUT_FILE"
echo ""
echo "📄 Conteúdo do arquivo:"
cat "$OUTPUT_FILE"
