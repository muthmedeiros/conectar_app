# Conéctar Frontend

> Aplicativo web/mobile desenvolvido em **Flutter** para a plataforma Conéctar.

---

## 🚀 Funcionalidades

- **Clean Architecture** com Flutter
- Modularização por feature (Auth, Clientes, etc.)
- **Provider** para gerenciamento de estado
- **Dio** para HTTP com interceptors (auth, logging, unwrap)
- **SecureStore** para tokens de acesso
- **go_router** para navegação
- Temas claro e escuro com design tokens (cores, espaçamento, tipografia)
- Layouts responsivos (breakpoints mobile & desktop)

---

## 🏗️ Arquitetura do Projeto

O projeto segue a **Clean Architecture**, que foi escolhida por proporcionar uma separação clara de responsabilidades, facilitando a manutenção, testes e evolução do sistema. Essa abordagem modulariza o código em camadas bem definidas:

- **Camada de Dados**: datasources e repositórios (chamadas de API, persistência)
- **Camada de Domínio**: entidades e interfaces dos repositórios
- **Camada de Apresentação**: controllers (`ChangeNotifier`) e widgets
- **Injeção de Dependências**: via `get_it`, registrada em `AppConfig.initialize()`
- **Gerenciamento de Estado**: controllers providos via `Provider`

### Por que Clean Architecture?

A Clean Architecture foi escolhida para garantir:
- **Desacoplamento**: as dependências são invertidas, evitando acoplamento entre camadas e facilitando a troca de implementações.
- **Testabilidade**: cada camada pode ser testada isoladamente, tornando a identificação e correção de bugs mais simples e rápida.
- **Modularidade**: o código é organizado por feature, facilitando a localização de arquivos e a colaboração em equipe.
- **Facilidade de manutenção**: mudanças em uma camada não afetam as demais, reduzindo riscos e retrabalho.

### Provider como Gerenciador de Estado

O **Provider** foi escolhido por ser uma solução leve, simples e oficial para gerenciamento de estado no Flutter. Ele facilita a injeção de dependências, promove a reatividade dos widgets e integra-se facilmente com a arquitetura modular proposta.

### Componentes Compartilhados e Configurações

Componentes reutilizáveis e configurações globais ficam centralizados em `core/` (env, di, network, logging, theme, storage, etc.), enquanto o código específico de cada domínio está em `features/` (auth, clients, home, profile, splash). Isso garante reutilização, padronização e fácil manutenção.

---

## ⚙️ Ambiente & Ferramentas

### Versões

- **Flutter**: 3.24.x (via [FVM](https://fvm.app/docs/getting_started/installation))
- **Dart**: 3.x
- **FVM** é obrigatório para garantir a consistência da versão do Flutter.

### Variáveis de Ambiente

O app suporta arquivos de ambiente separados para desenvolvimento local e produção/remoto:

- `.local.env`: para desenvolvimento local (ex: API localhost, tokens locais)
- `.env`: para ambiente remoto/produção (ex: API de produção, segredos)

**Como funciona:**

- O app carrega automaticamente o `.local.env` ao rodar localmente (usando o launch config "Flutter Web (Chrome) [Local]" do VS Code ou `--dart-define=ENV=local`).
- Carrega o `.env` para execuções remotas/produção (usando "Flutter Web (Chrome) [Remote]" ou `--dart-define=ENV=remote`).
- Não é necessário copiar arquivos manualmente; basta preencher cada um com os valores apropriados.

> Ambos arquivos são ignorados pelo git. Mantenha seus segredos protegidos.

---


## 🌐 Deploy Web (Netlify)

O app web está publicado manualmente em: [https://conectarapp.netlify.app](https://conectarapp.netlify.app)

---
## 🛠️ Desenvolvimento

### 1. Instalar dependências

```bash
fvm flutter pub get
```

### 2. Rodar para Web

```bash
fvm flutter run -d chrome
```

### 3. Analisar & Lintar

```bash
fvm flutter analyze
```

### 4. Rodar Testes

```bash
fvm flutter test
```

---

## 🔑 Fluxo de Autenticação

- No **login**: o app salva o `accessToken` no SecureStore.
- Ao iniciar o app: `SplashGate` verifica o token e chama `/auth/user` para carregar o perfil.
- **Guards do go_router** redirecionam:
  - Não logado → `/login`
  - Logado acessando `/login` → `/home`
  - Páginas restritas a admin protegidas por `AccessPolicy`

---

## 🎨 UI & Tematização

- **Design Tokens**: Cor, Raio, Espaçamento, Tipografia (`lib/core/theme/tokens/`)
- Usa **Google Fonts**
- Responsivo: breakpoints para Mobile e Desktop
- Componentes compartilhados em `core/widgets`

---

## 📂 Configuração do VS Code

O projeto inclui `.vscode/settings.json` e `.vscode/launch.json` para padronização do ambiente de desenvolvimento.

---

## ✅ Resumo

- **Env**: Copie `.example.env` → `.env`
- **Rodar**: `fvm flutter run -d chrome`
- **Arquitetura**: Clean, modular, testável, desacoplada
- **Controllers**: Providos via `Provider`, dependências injetadas via construtor
- **Interceptors**: Auth, unwrap, logging
- **Guards**: SplashGate + guards do go_router
