#!/usr/bin/env zsh

# Set the data file path
data_file="$HOME/.nvm_auto_use/dirs"

# Create the data file if it doesn't exist
[[ -f $data_file ]] || { mkdir -p "${data_file:h}" && touch $data_file; }

# User-defined directory paths, can be set via environment variables, for example:
# export NVM_AUTO_USE_DIRS=( "/path/to/projects/dir1" "/path/to/projects/dir2" )
nvm_auto_use_dirs=( "${NVM_AUTO_USE_DIRS[@]:-$HOME}" )

# Associative array to store directory and nvm use command mappings
declare -A nvm_use_dirs

# Function to load data from the data file
function load_data() {
  if [[ -f "$data_file" ]]; then
    # Read data from the file
    while read -r line; do
      key=$(echo "$line" | cut -d'=' -f1)
      value=$(echo "$line" | cut -d'=' -f2-)
      nvm_use_dirs[$key]="$value"
    done < "$data_file"
  fi
}

# Function to save data to the data file
function save_data() {
  # Clear the file content
  echo "" > "$data_file"  # Overwrite the file content using echo "" > 
  # Write the associative array to the file
  for key in "${(k)nvm_use_dirs[@]}"; do
    echo "$key=${nvm_use_dirs[$key]}" >> "$data_file"
  done
}

# Function to check if the current directory is in the specified directory array
function is_in_nvm_auto_use_dirs() {
  local current_dir="$PWD"
  for dir in "${nvm_auto_use_dirs[@]}"; do
    if [[ "$current_dir" == "$dir"/* ]]; then
      return 0  # Current directory is within the specified directories
    fi
  done
  return 1  # Current directory is not within the specified directories
}

# Function to handle the nvm use command
function nvm_use_handler() {
  # Check if the current directory is in the array and the command is 'nvm use'
  local cmd="$1"
  if [[ "$cmd" =~ ^nvm\ use ]] && is_in_nvm_auto_use_dirs; then
    local dir="$PWD"
    nvm_use_dirs[$dir]="$cmd"
    save_data  # Save the data to the file
  fi
}

# Function to automatically execute the nvm use command when entering a directory
function chpwd_handler() {
  # Check if the current directory is in the specified directory array
  if is_in_nvm_auto_use_dirs; then
    local dir="$PWD"
    if [[ -n "${nvm_use_dirs[$dir]}" ]]; then
      eval "${nvm_use_dirs[$dir]}"
    fi
  fi
}

# Load saved data
load_data

# Register the nvm use command handler
autoload -Uz add-zsh-hook
add-zsh-hook preexec nvm_use_handler

# Register the chpwd hook function
add-zsh-hook chpwd chpwd_handler