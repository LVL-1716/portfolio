# Workspace README — Port

Este diretório contém o projeto de portfólio em `./portfolio`.

Comandos convenientes (rodando do diretório raiz `C:\Users\Luciano\Desktop\Port`):

```powershell
# Instalar dependências do portfolio
npm install

# Iniciar desenvolvimento do portfolio
npm start

# Build de produção
npm run build

# Testes
npm test

# CI (instala dependências, testa e faz build)
npm run ci
```

Observação: Os scripts acima usam `npm --prefix ./portfolio ...` para executar as ações na pasta `portfolio`.

---

## Recomendação de Ambiente
- Node.js 18.x (ou LTS compatível). Use `nvm` para gerenciar versões com o arquivo `.nvmrc` disponível no root.
- NPM 8+.

CI / GitHub Actions
- O workflow `ci` está configurado em `.github/workflows/ci.yml` e roda em pushes/PRs na branch `main`/`master`. Ele roda `npm ci`, `npm test` e `npm run build` no diretório `portfolio`.

---

Se desejar, configure o repositório no GitHub e ative o deploy automático no Vercel (veja `./portfolio/README.md` para instruções detalhadas de deploy).
