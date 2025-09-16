#!/bin/bash
set -e

# 1. Install Flutter (pin to version you need)
git clone https://github.com/flutter/flutter.git -b 3.24.0 --depth 1
export PATH="$PATH:$(pwd)/flutter/bin"

# 2. Show version (debugging)
flutter --version

# 3. Setup environment
cp .example.env .env

# 4. Install dependencies
flutter pub get

# 5. Build web app
flutter build web --release
