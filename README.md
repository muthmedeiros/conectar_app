# Conéctar Frontend

Frontend web/mobile app built with **Flutter** for the Conéctar platform.

---

## 🚀 Features

- Flutter **Clean Architecture**
- Modular by feature (Auth, Clients, etc.)
- **Provider** for state management
- **Dio** for HTTP with interceptors (auth, logging, unwrap)
- **SecureStore** for access tokens
- **go_router** for navigation
- Light & Dark themes with design tokens (color, spacing, typography)
- Responsive layouts (mobile & desktop breakpoints)

---

## ⚙️ Environment & Tooling

### Versions

- **Flutter**: 3.24.x (via [FVM](https://fvm.app/docs/getting_started/installation))
- **Dart**: 3.x
- **FVM** is required for consistent Flutter version management.

### Environment Variables

The app supports separate environment files for local and remote/production setups:

- `.local.env`: for local development (e.g. localhost API, local tokens)
- `.env`: for remote/production environment (e.g. production API, secrets)

**How it works:**

- The app automatically loads `.local.env` when running locally (using VS Code's "Flutter Web (Chrome) [Local]" launch config or `--dart-define=ENV=local`).
- It loads `.env` for remote/production runs (using "Flutter Web (Chrome) [Remote]" or `--dart-define=ENV=remote`).
- No manual copying is needed; just fill in each file with the appropriate values.

> Both files are ignored by git. Make sure to keep your secrets safe.

---

## 🏗️ Architecture Overview

- **Data layer**: datasources + repositories (API calls, persistence)
- **Domain layer**: Entities + repository interfaces
- **Presentation layer**: Controllers (`ChangeNotifier`) + Widgets
- **Dependency Injection**: `get_it` registered in `AppConfig.initialize()`
- **State**: Controllers provided via `Provider`

Shared code is under `core/` (env, di, network, logging, theme, storage, etc.).  
Domain-specific code is under `features/` (auth, clients, home, profile, splash).

---

## 🛠️ Development

### 1. Install dependencies

```bash
fvm flutter pub get
```

### 2. Run for Web

```bash
fvm flutter run -d chrome
```

### 3. Analyze & Lint

```bash
fvm flutter analyze
```

### 4. Run Tests

```bash
fvm flutter test
```

---

## 🔑 Authentication Flow

- On **login**: app saves `accessToken` in SecureStore.
- On **app start**: `SplashGate` checks token and calls `/auth/user` to load profile.
- **go_router guards** redirect:
  - Not logged in → `/login`
  - Logged in visiting `/login` → `/home`
  - Admin-only pages guarded by `AccessPolicy`

---

## 🎨 UI & Theming

- **Design Tokens**: Color, Radius, Spacing, Typography (`lib/core/theme/tokens/`)
- Uses **Google Fonts**
- Responsive: Mobile + Desktop breakpoints
- Shared components in `core/widgets`

---

## 📂 VS Code Setup

Project includes `.vscode/settings.json` and `.vscode/launch.json` for IDE consistency.

---

## ✅ Summary

- **Env**: Copy `.example.env` → `.env`
- **Run**: `fvm flutter run -d chrome`
- **Architecture**: Clean, modular, testable
- **Controllers**: Provided via `Provider`, dependencies injected via constructor
- **Interceptors**: Auth, unwrap, logging
- **Guards**: SplashGate + go_router route guards

---

## 📜 License

MIT © Conéctar
