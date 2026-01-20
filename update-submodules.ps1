$SUPER_BRANCH = "chore/update-portfolio-submodule-audit-fix"
$BASE_BRANCH = "main"

function path_to_name {
    param([string]$path)
    return $path -replace '@/@-@g', '-' -replace '^-', ''
}

if (-not (Test-Path ".gitmodules")) {
    Write-Host ".gitmodules não encontrado. Abortando."
    exit 1
}

git fetch origin
git checkout -b $SUPER_BRANCH -ErrorAction SilentlyContinue
if ($LASTEXITCODE -ne 0) {
    git checkout $SUPER_BRANCH
}

# Get submodule paths
$submodules = @()
$gitModules = Get-Content ".gitmodules" -Raw
$gitModules -split '\[\s*submodule' | Where-Object {$_} | ForEach-Object {
    if ($_ -match 'path\s*=\s*(.+)') {
        $submodules += $matches[1].Trim()
    }
}

foreach ($path in $submodules) {
    Write-Host "=== Processando submódulo: $path ==="
    
    git submodule update --init --remote --recursive $path
    
    if (-not (Test-Path $path)) {
        Write-Host "Diretório $path não existe; pulando."
        continue
    }
    
    if (-not (Test-Path "$path/package.json")) {
        Write-Host "Sem package.json em $path; pulando."
        continue
    }
    
    Push-Location $path
    
    git fetch origin -ErrorAction SilentlyContinue
    $DEFAULT_BRANCH = "master"
    
    git checkout $DEFAULT_BRANCH -ErrorAction SilentlyContinue
    if ($LASTEXITCODE -ne 0) {
        git checkout -b $DEFAULT_BRANCH
    }
    
    git pull --ff-only origin $DEFAULT_BRANCH -ErrorAction SilentlyContinue
    
    $NAME = $path -replace '@/@-@g', '-' -replace '^-', ''
    $BEFORE_FILE = "../../audit-before-$NAME.json"
    $AFTER_FILE = "../../audit-after-$NAME.json"
    
    if ((Test-Path "package-lock.json") -or (Test-Path "npm-shrinkwrap.json")) {
        npm ci
    } else {
        npm install
    }
    
    npm audit --json | Out-File $BEFORE_FILE -ErrorAction SilentlyContinue
    npm audit fix -ErrorAction SilentlyContinue
    
    $gitStatus = git status --porcelain
    if ($gitStatus -match "package-lock.json|yarn.lock") {
        git add package-lock.json, yarn.lock -ErrorAction SilentlyContinue
        git commit -m "chore(deps): update packages to resolve audit issues" -ErrorAction SilentlyContinue
        git push origin HEAD -ErrorAction SilentlyContinue
    }
    
    npm audit --json | Out-File $AFTER_FILE -ErrorAction SilentlyContinue
    
    $npmRun = npm run 2>&1
    if ($npmRun -match "test") {
        npm test -ErrorAction SilentlyContinue
        if ($LASTEXITCODE -ne 0) {
            Write-Host "AVISO: testes falharam em $path"
        }
    }
    
    if ($npmRun -match "build") {
        npm run build -ErrorAction SilentlyContinue
        if ($LASTEXITCODE -ne 0) {
            Write-Host "AVISO: build falhou em $path"
        }
    }
    
    Pop-Location
    
    git add $path
}

git commit -m "chore: update submodule(s) - fix npm audit vulnerabilities" -ErrorAction SilentlyContinue
if ($LASTEXITCODE -eq 0) {
    git push origin HEAD
} else {
    Write-Host "Nada para commitar no superprojeto"
}

Write-Host "Verifique audit-before-*.json, audit-after-*.json e PR_BODY.md na raiz."
