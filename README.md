# Portfólio — LVL-1716

> Um portfólio pessoal construído em React com CSS Modules. Preparado como PWA com testes e pronto para deploy no Vercel.

---

## Sumário
- [Sobre o projeto](#sobre-o-projeto)
- [Funcionalidades](#funcionalidades)
- [Estrutura do projeto](#estrutura-do-projeto)
- [Como rodar localmente](#como-rodar-localmente)
- [Testes](#testes)
- [PWA](#pwa)
- [Deploy (Vercel)](#deploy-vercel)
- [Projetos apresentados](#projetos-apresentados)
- [Personalização](#personaliza%C3%A7%C3%A3o)
- [Melhorias futuras](#melhorias-futuras)
- [Licença e Créditos](#licen%C3%A7a-e-cr%C3%A9ditos)

---

## Sobre o projeto
Este repositório contém um portfólio moderno construído com React. Ele foi criado para destacar projetos, habilidades e proporcionar um canal de contato profissional. Ideal para estudantes e desenvolvedores iniciantes que querem mostrar resultados de cursos e projetos pessoais.

- Componentes funcionais e React Hooks.
- CSS Modules para estilos modulares.
- PWA básico (service worker + manifest).
- Testes com Jest e React Testing Library.
- Preparado para deploy gratuito no Vercel.

---

## Funcionalidades
- Página inicial com resumo e foto de perfil.
- Navegação interna (anchor links) entre as seções do site.
- Lista de projetos com `ProjectCard` contendo captura, descrição e links.
- Seção de habilidades (badges)
- Formulário de contato com validação local.
- Responsividade para dispositivos móveis e desktop.
- Alternância de tema: light/dark (botão no canto do header). A preferência de tema é salva no `localStorage` e respeita a preferência do sistema por padrão.

---

## Estrutura do projeto
```
portfolio/
├─ public/
│  ├─ index.html
│  ├─ manifest.json
│  └─ service-worker.js
├─ src/
│  ├─ assets/
│  ├─ components/
│  ├─ App.js
│  └─ index.js
├─ package.json
├─ vercel.json
└─ README.md
```

---

## Como rodar localmente
Recomendações (Windows PowerShell):

1. Abra o PowerShell e vá para a pasta do projeto:
```powershell
cd C:\Users\Luciano\Desktop\Port\portfolio
```
2. Instale dependências:
```powershell
npm install
```
3. Rode em modo de desenvolvimento:
```powershell
npm start
```
4. Abra o navegador em http://localhost:3000

5. Para build de produção:
```powershell
npm run build
```

### Uso do NVM
Se você usa `nvm` para gerenciar versões do Node, rode:
```powershell
nvm use
```
Isto irá usar a versão listada em `.nvmrc` (recomendado `18`).

---

## Testes
Execute os testes com Jest e React Testing Library:

```powershell
npm run test
```

- Para rodar localmente os testes de forma não interativa:
```powershell
npm --prefix .\portfolio test -- --watchAll=false
```

### Lint
Rodar verificação de lint (ESLint):
```powershell
npm --prefix .\portfolio run lint
```

Os testes atuais cobrem:
- Renderização de seções (Header, Projects)
- Validação do formulário de contato
- Renderização de `ProjectCard`

---

## PWA
O projeto já contém suporte PWA simples:
- `public/manifest.json` com meta informações e ícones
- `public/service-worker.js` com cache básico

**Servir em produção**

- Build e servir localmente (HTTP estático, porta 5000):

```powershell
cd portfolio
npm run build
npm run serve:prod
```

- Manter o servidor em execução automaticamente usando PM2 (recomendado para host):

```powershell
cd portfolio
npm install
npm run pm2:start         # Inicia o processo PM2 definido em ecosystem.config.js
npm run pm2:save          # Salva a lista de processos para restaurar depois de reboot
# (Opcional) Para configurar o sistema a iniciar PM2 na inicialização, execute:
# npx pm2 startup
```

**Observação:** O servidor ficará disponível em http://localhost:5000 e o processo estará gerenciado pelo PM2.

- `src/serviceWorkerRegistration.js` faz o registro do service worker

Testes:
- Ao rodar em produção (`npm run build && npm run serve-build` ou utilizando o deploy), abra o site e veja se o navegador informa que o conteúdo está disponível offline.
- Use a aba "Application" do Chrome DevTools para inspecionar o manifest e o service worker.

---

## Deploy (Vercel)
O projeto está preparado para deploy no Vercel usando o builder `@vercel/static-build`.

Passos:
1. Crie um repositório no GitHub e dê push do conteúdo da pasta `portfolio`.
2. Faça login no Vercel e clique em "New Project" → escolha seu repositório.
3. Configure (padrão):
- Build Command: `npm run build`
- Output Directory: `build`
4. Clique em Deploy.

Quando terminar, insira sua URL pública abaixo para referência:
- URL do deploy (Vercel): https://<SEU-URL-AQUI>.vercel.app

> Dica: Permita o deploy automático (GitHub) para que uma nova versão seja publicada sempre que um PR for merged na branch principal.

---

## Projetos apresentados
Lista de projetos usados no portfólio (com links para os repositórios):

- **Tarefas App** — https://github.com/LVL-1716/tarefas-app
	- Descrição: Aplicação de gerenciamento de tarefas com criação, edição e marcação de atividades.
	- Tecnologias: React, JavaScript, CSS Modules, LocalStorage
- **Pet** — https://github.com/LVL-1716/Pet
	- Descrição: App de cadastro de pets com upload de imagem, filtros e gerenciamento de dados.
	- Tecnologias: React, Node.js (se aplicável), CSS Modules
- **MF** — https://github.com/LVL-1716/MF
	- Descrição: Projeto com rotas e integração com APIs para exemplificar consumo de dados.
	- Tecnologias: React, React Router, APIs REST

---

## Personalização
- Substitua `src/assets/profile-placeholder.png` pela sua foto.
- Adicione screenshots de projeto em `src/assets/` e altere `image` em `src/components/Projects/Projects.js`.
- Atualize os textos (Home/About) com suas informações reais.
- Configure o email em `src/components/Home/Home.js` e `src/components/Contact/Contact.js`.

---

## Melhorias sugeridas
- Implementar formulários backend (Formspree, Netlify Forms ou API custom).
- Melhorar estratégias de cache com Workbox (service worker mais robusto).
- Adicionar CI/CD com GitHub Actions (build + test antes do deploy).
- Incluir testes e2e com Cypress.
- Melhorar acessibilidade (A11Y) e performance (Lighthouse).

---

## Status de Segurança
Executamos uma verificação com `npm audit` e aplicamos correções seguras com `npm audit fix` além de adicionar `overrides` para certas dependências encadeadas (por exemplo `postcss`, `svgo`, `nth-check`) para mitigar vulnerabilidades reportadas.

Resultado:
- `npm audit` no branch `fix/audit-updates` reporta 0 vulnerabilidades.

Recomendações:
- Rode `npm audit --prefix .\portfolio` para ver detalhes locais.
- Evite `npm audit fix --prefix .\portfolio --force` sem revisar o impacto: pode atualizar `react-scripts` para uma versão com breaking changes.
- Para remoção definitiva das vulnerabilidades, considere atualizar `react-scripts` ou migrar para outra cadeia de build (Vite/Next.js).

---

## Licença e Créditos
- Este projeto é um template para portfólio; adicione a licença que preferir (ej. MIT).
- Feito por LVL-1716 — use como base para seu portfólio pessoal.

---

Obrigado por usar este template — Se quiser que eu automatize o deploy no Vercel, adicione o repositório no GitHub e me avise para que eu te guie em cada passo.