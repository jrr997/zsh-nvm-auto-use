# zsh-nvm-auto-use

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A ZSH plugin that automatically manages your Node.js versions using [NVM](https://github.com/nvm-sh/nvm) based on your current directory.

## Tired of manually switching Node versions?

This plugin helps you:

**Automatically switch Node.js versions:** When you `cd` into a directory, it automatically runs the `nvm use` command if you run it before, so you just need to run `nvm use` once for every directory.

## Installation

1. **Prerequisites:** Make sure you have [NVM (Node Version Manager)](https://github.com/nvm-sh/nvm) installed on your system.

2. **Clone or Download:**

   - Clone this repository to your ZSH plugins directory:
     ```bash
     git clone https://github.com/your-username/zsh-nvm-auto-use.git $ZSH_CUSTOM/plugins/nvm-auto-use
     ```
   - Or download the `zsh-nvm-auto-use.plugin.zsh` file and place it in your ZSH plugins directory.

3. **Enable the Plugin:** Add the plugin to your `.zshrc` file:
   ```zsh
   plugins=(... nvm-auto-use)
   ```
