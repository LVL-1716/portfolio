$BRANCH = "chore/update-portfolio-submodule-audit-fix"
$BASE_BRANCH = "master"
$OUTPUT_FILE = "PR_REVIEW_INFO.md"

Write-Host "[*] Coletando informacoes de revisao da PR..." -ForegroundColor Cyan
Write-Host ""

# Verificar branch atual
$CURRENT_BRANCH = git rev-parse --abbrev-ref HEAD
if ($CURRENT_BRANCH -ne $BRANCH) {
    Write-Host "[!] Voce nao esta na branch $BRANCH" -ForegroundColor Yellow
    Write-Host "Branch atual: $CURRENT_BRANCH"
    Write-Host "Mudando para a branch correta..."
    git checkout $BRANCH
}

# Criar arquivo de saída
$content = "# Informacoes de Revisao da PR`n`n"
$content += "## Referencias`n"
$content += "Branch: $BRANCH`n"
$content += "Base Branch: $BASE_BRANCH`n`n"

# Adicionar commits
$content += "## Commits`n`n"
$content += "``````text`n"
$commits = & git log "$BASE_BRANCH..$BRANCH" --oneline
$content += ($commits -join "`n") + "`n"
$content += "``````text`n`n"

# Adicionar arquivos modificados
$content += "## Arquivos Modificados`n`n"
$content += "``````text`n"
$files = & git diff --name-status "$BASE_BRANCH..$BRANCH"
$content += ($files -join "`n") + "`n"
$content += "``````text`n`n"

# Adicionar estatísticas
$content += "## Estatisticas`n`n"
$content += "``````text`n"
$stats = & git diff --stat "$BASE_BRANCH..$BRANCH"
$content += ($stats -join "`n") + "`n"
$content += "``````text`n`n"

# Adicionar resumo de mudanças
$content += "## Resumo das Mudancas`n`n"

# Verificar mudanças em arquivos específicos
$files_modified = & git diff --name-only "$BASE_BRANCH..$BRANCH"

if ($files_modified -match "PR_BODY.md") {
    $content += "### PR_BODY.md`n[OK] Descricao da PR atualizada`n`n"
}

if ($files_modified -match "audit-before-portfolio.json") {
    $content += "### audit-before-portfolio.json`n[OK] Relatorio de auditoria (antes) adicionado`n`n"
}

if ($files_modified -match "audit-after-portfolio.json") {
    $content += "### audit-after-portfolio.json`n[OK] Relatorio de auditoria (depois) adicionado`n`n"
}

if ($files_modified -match "update-submodules.sh") {
    $content += "### update-submodules.sh`n[OK] Script de atualizacao (Bash) adicionado`n`n"
}

if ($files_modified -match "update-submodules.ps1") {
    $content += "### update-submodules.ps1`n[OK] Script de atualizacao (PowerShell) adicionado`n`n"
}

# Adicionar diff detalhado
$content += "## Diff Detalhado`n`n"
$content += "``````diff`n"
$diff = & git diff "$BASE_BRANCH..$BRANCH"
$diff_array = @($diff) -split "`n"
$diff_head = $diff_array | Select-Object -First 200
$content += ($diff_head -join "`n") + "`n...`n"
$content += "``````diff`n`n"

# Salvar arquivo
$content | Out-File -FilePath $OUTPUT_FILE -Encoding UTF8

Write-Host "[OK] Informacoes coletadas em: $OUTPUT_FILE" -ForegroundColor Green
Write-Host ""
Write-Host "Conteudo do arquivo:"
Write-Host ""
Get-Content $OUTPUT_FILE
