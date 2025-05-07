#!/bin/bash

echo "🚀 Starting StatsWiz environment setup..."

# 1. Install pipenv if not installed
if ! command -v pipenv &> /dev/null; then
    echo "📦 pipenv not found. Installing..."
    pip install --user pipenv
else
    echo "✅ pipenv already installed."
fi

# 2. Install dependencies with --dev
echo "📦 Installing dependencies with pipenv..."
pipenv install --dev

# 3. Install pre-commit hooks if config exists
if [ -f .pre-commit-config.yaml ]; then
    echo "🧹 Installing pre-commit hooks..."
    pipenv run pre-commit install
else
    echo "⚠️ No .pre-commit-config.yaml found. Skipping pre-commit setup."
fi

# 4. Install Git hook: post-checkout
HOOKS_DIR="../.git/hooks"
HOOKS_SOURCE="./hooks"

if [ -f "$HOOKS_SOURCE/post-checkout" ]; then
    echo "🔗 Setting up Git hook: post-checkout"
    mkdir -p "$HOOKS_DIR"
    cp "$HOOKS_SOURCE/post-checkout" "$HOOKS_DIR/post-checkout"
    chmod +x "$HOOKS_DIR/post-checkout"
    echo "✅ Git hook installed successfully!"
else
    echo "⚠️ post-checkout hook not found in $HOOKS_SOURCE"
fi

echo "🎉 Setup complete. Use 'pipenv shell' to activate your environment."
